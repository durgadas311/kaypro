// Copyright 2017 Douglas Miller

import java.util.Arrays;
import java.util.Vector;
import java.util.Map;
import java.util.HashMap;
import java.io.*;
import java.util.concurrent.Semaphore;
import java.util.concurrent.locks.ReentrantLock;
import java.util.Properties;

import z80core.*;

public class Kaypro implements Computer, KayproCommander, Interruptor, Runnable {
	private Z80 cpu;
	private long clock;
	private Map<Integer, IODevice> ios;
	private Vector<IODevice> devs;
	private Vector<DiskController> dsks;
	private Vector<InterruptController> intrs;
	private Memory mem;
	private SystemPort gpp;
	private boolean running;
	private boolean stopped;
	private Semaphore stopWait;
	private boolean tracing;
	private int traceCycles;
	private int traceLow;
	private int traceHigh;
	private int[] intRegistry;
	private int[] intLines;
	private int intState;
	private int intMask;
	private boolean nmiState;
	private boolean isHalted;
	private Vector<ClockListener> clks;
	private Z80Disassembler disas;
	private ReentrantLock cpuLock;
	private KayproKeyboard kbd; // to prevent erasure...

	// Relationship between virtual CPU clock and real time
	private long intervalTicks = 4000;	// 1ms
	private long intervalNs = 1000000;	// 1ms
	private long backlogTime = 10000000;	// 10ms backlog limit
	private long backlogNs;

	public Kaypro(Properties props, LEDHandler lh, IODevice crt) {
		String s;
		intRegistry = new int[8];
		intLines = new int[8];
		Arrays.fill(intRegistry, 0);
		Arrays.fill(intLines, 0);
		intState = 0;
		intMask = 0;
		running = false;
		stopped = true;
		stopWait = new Semaphore(0);
		cpuLock = new ReentrantLock();
		cpu = new Z80(this);
		ios = new HashMap<Integer, IODevice>();
		devs = new Vector<IODevice>();
		dsks = new Vector<DiskController>();
		clks = new Vector<ClockListener>();
		intrs = new Vector<InterruptController>();
		// Do this early, so we can log messages appropriately.
		s = props.getProperty("kaypro_log");
		if (s != null) {
			String[] args = s.split("\\s");
			boolean append = false;
			for (int x = 1; x < args.length; ++x) {
				if (args[x].equals("a")) {
					append = true;
				}
			}
			try {
				FileOutputStream fo = new FileOutputStream(args[0], append);
				PrintStream ps = new PrintStream(fo, true);
				System.setErr(ps);
			} catch (Exception ee) {}
		}
		s = props.getProperty("configuration");
		if (s == null) {
			System.err.format("No config file found\n");
		} else {
			System.err.format("Using configuration from %s\n", s);
		}

		gpp = new SystemPort(props, this);
		addDevice(gpp);
		addDevice(crt);
		// TODO: possibly allow customization of memory... and peripherals...
		mem = new KayproMemory(props, gpp);
		IODevice cpn = null;
		int nFlpy = 2;
		s = props.getProperty("kaypro_model");
		if (s != null && s.equals("10")) {
			//addDiskDevice(new KayproSASI(props, lh, this, gpp);
			nFlpy = 1;
		}
		addDiskDevice(new KayproFloppy(props, lh, this, gpp, nFlpy));
		WD1943 baudA = new WD1943(0x00, 4, "baud-A");
		WD1943 baudB = new WD1943(0x08, 4, "baud-B");
		Z80SIO sio1 = new Z80SIO(props, "data", "kbd", 0x04, this);
		Z80SIO sio2 = new Z80SIO(props, "aux", "modem", 0x0c, this);
		baudA.addBaudListener(sio1.clockA());
		sio1.clockB().setBaud(300 * 16);
		kbd = new KayproKeyboard(props, new Vector<String>(), sio1.portB());
		baudB.addBaudListener(sio2.clockA());
		sio2.clockB().setBaud(300 * 16);
		addDevice(baudA);
		addDevice(baudB);
		addDevice(sio1);
		addDevice(sio2);
		addDevice(new ParallelPrinter(props, gpp));
		// TODO: work out Z80-PIO and attached devices...
		// addDevice(new Z80PIO(props, "rtc", "modem", 0x20, this));
		// addDevice(new MM58167(props, 0x24, this));

		s = props.getProperty("kaypro_disas");
		if (s != null && s.equalsIgnoreCase("zilog")) {
			disas = new Z80DisassemblerZilog(mem);
		} else {
			disas = new Z80DisassemblerMAC80(mem);
		}
	}

	public void reset() {
		boolean wasRunning = running;
		tracing = false;
		traceCycles = 0;
		traceLow = 0;
		traceHigh = 0;
		// TODO: reset other interrupt state? devices should do that...
		intMask = 0;
		clock = 0;
		stop();
		if (false && wasRunning) {
			System.err.format("backlogNs=%d\n", backlogNs);
		}
		backlogNs = 0;
		cpu.reset();
		mem.reset();
		for (int x = 0; x < devs.size(); ++x) {
			devs.get(x).reset();
		}
		if (wasRunning) {
			start();
		}
	}

	public KayproKeyboard getKeyboard() {
		return kbd;
	}

	public boolean addDevice(IODevice dev) {
		if (dev == null) {
			System.err.format("NULL I/O device\n");
			return false;
		}
		int base = dev.getBaseAddress();
		int num = dev.getNumPorts();
		if (num <= 0) {
			System.err.format("No ports\n");
			return false;
		}
		for (int x = 0; x < num; ++x) {
			if (ios.get(base + x) != null) {
				System.err.format("Conflicting I/O %02x (%02x)\n", base, num);
				return false;
			}
		}
		devs.add(dev);
		for (int x = 0; x < num; ++x) {
			ios.put(base + x, dev);
		}
		return true;
	}

	public IODevice getDevice(int basePort) {
		IODevice dev = ios.get(basePort);
		return dev;
	}

	public Vector<DiskController> getDiskDevices() {
		return dsks;
	}

	public boolean addDiskDevice(DiskController dev) {
		if (!addDevice(dev)) {
			return false;
		}
		dsks.add(dev);
		return true;
	}

	// These must NOT be called from the thread...
	public void start() {
		stopped = false;
		if (running) {
			return;
		}
		running = true;
		Thread t = new Thread(this);
		t.setPriority(Thread.MAX_PRIORITY);
		t.start();
	}
	public void stop() {
		stopWait.drainPermits();
		if (!running) {
			return;
		}
		running = false;
		// This is safer than spinning, but still stalls the thread...
		try {
			stopWait.acquire();
		} catch (Exception ee) {}
	}
	private void addTicks(int ticks) {
		clock += ticks;
		for (ClockListener lstn : clks) {
			lstn.addTicks(ticks, clock);
		}
	}

	// I.e. admin commands to virtual Kaypro...
	public KayproCommander getCommander() {
		return (KayproCommander)this;
	}

	// TODO: these may be separate classes...

	/////////////////////////////////////////////
	/// Interruptor interface implementation ///
	public int registerINT(int irq) {
		int val = intRegistry[irq & 7]++;
		// TODO: check for overflow (32 bits max?)
		return val;
	}
	public void raiseINT(int irq, int src) {
		irq &= 7;
		intLines[irq] |= (1 << src);
		intState |= (1 << irq);
		if ((intState & ~intMask) != 0) {
			cpu.setINTLine(true);
		}
	}
	public void lowerINT(int irq, int src) {
		irq &= 7;
		intLines[irq] &= ~(1 << src);
		if (intLines[irq] == 0) {
			intState &= ~(1 << irq);
			if ((intState & ~intMask) == 0) {
				cpu.setINTLine(false);
			}
		}
	}
	public void blockInts(int msk) {
		intMask |= msk;
		if ((intState & ~intMask) == 0) {
			cpu.setINTLine(false);
		}
	}
	public void unblockInts(int msk) {
		intMask &= ~msk;
		if ((intState & ~intMask) != 0) {
			cpu.setINTLine(true);
		}
	}
	public void setNMI(boolean state) {
		if (isHalted && !nmiState && state) {
			cpu.triggerNMI();
		}
		nmiState = state;
	}
	// Not part of Interruptor interface.
	private void setHalted(boolean halted) {
		if (!isHalted && halted && nmiState) {
			cpu.triggerNMI();
		}
		isHalted = halted;
	}
	// Kaypro does not allow direct access to NMI pin.
	public void triggerNMI() {
		cpu.triggerNMI();
	}
	public void addClockListener(ClockListener lstn) {
		clks.add(lstn);
	}
	public void addIntrController(InterruptController ctrl) {
		// There really should be only zero or one.
		intrs.add(ctrl);
	}
	public void waitCPU() {
		// Keep issuing clock cycles while stalling execution.
		addTicks(1);
	}
	public boolean isTracing() {
		return tracing;
	}
	public void startTracing() {
		tracing = true;
	}
	public void stopTracing() {
		tracing = false;
	}

	/////////////////////////////////////////////
	/// H89Commander interface implementation ///
	public Vector<String> sendCommand(String cmd) {
		// TODO: stop Z80 during command? Or only pause it?
		String[] args = cmd.split("\\s");
		Vector<String> ret = new Vector<String>();
		ret.add("ok");
		Vector<String> err = new Vector<String>();
		err.add("error");
		if (args.length < 1) {
			return ret;
		}
		if (args[0].equalsIgnoreCase("quit")) {
			// Release Z80, if held...
			stop();
			System.exit(0);
		}
		if (args[0].equalsIgnoreCase("trace") && args.length > 1) {
			if (!traceCommand(args, err, ret)) {
				return err;
			}
			return ret;
		}
		try {
			cpuLock.lock(); // This might sleep waiting for CPU to finish 2mS
			if (args[0].equalsIgnoreCase("reset")) {
				reset();
				return ret;
			}
			if (args[0].equalsIgnoreCase("mount")) {
				if (args.length < 3) {
					err.add("syntax");
					err.add(cmd);
					return err;
				}
				GenericDiskDrive drv = findDrive(args[1]);
				if (drv == null) {
					err.add("nodrive");
					err.add(args[1]);
					return err;
				}
				drv.insertDisk(SectorFloppyImage.getDiskette(drv,
					new Vector<String>(Arrays.asList(Arrays.copyOfRange(args, 2, args.length)))));
				return ret;
			}
			if (args[0].equalsIgnoreCase("unmount")) {
				if (args.length < 2) {
					err.add("syntax");
					err.add(cmd);
					return err;
				}
				GenericDiskDrive drv = findDrive(args[1]);
				if (drv == null) {
					err.add("nodrive");
					err.add(args[1]);
					return err;
				}
				drv.insertDisk(null);
				return ret;
			}
			if (args[0].equalsIgnoreCase("getdevs")) {
				for (IODevice dev : devs) {
					String nm = dev.getDeviceName();
					if (nm != null) {
						ret.add(nm);
					}
				}
				return ret;
			}
			if (args[0].equalsIgnoreCase("getdisks")) {
				for (DiskController dev : dsks) {
					Vector<GenericDiskDrive> drvs = dev.getDiskDrives();
					for (GenericDiskDrive drv : drvs) {
						if (drv != null) {
							ret.add(drv.getDriveName() + "=" + drv.getMediaName());
						}
					}
				}
				return ret;
			}
			if (args[0].equalsIgnoreCase("dump") && args.length > 1) {
				if (args[1].equalsIgnoreCase("cpu")) {
					ret.add(cpu.dumpDebug());
					ret.add(disas.disas(cpu.getRegPC()) + "\n");
				}
				if (args[1].equalsIgnoreCase("page") && args.length > 2) {
					ret.add(dumpPage(args[2]));
				}
				if (args[1].equalsIgnoreCase("mach")) {
					ret.add(dumpDebug());
				}
				if (args[1].equalsIgnoreCase("disk") && args.length > 2) {
					IODevice dev = findDevice(args[2]);
					if (dev == null) {
						err.add("nodevice");
						err.add(args[2]);
						return err;
					}
					ret.add(dev.dumpDebug());
				}
				return ret;
			}
			err.add("badcmd");
			err.add(cmd);
			return err;
		} finally {
			cpuLock.unlock();
		}
	}

	private boolean traceCommand(String[] args, Vector<String> err,
			Vector<String> ret) {
		// TODO: do some level of mutexing?
		if (args[1].equalsIgnoreCase("on")) {
			startTracing();
		} else if (args[1].equalsIgnoreCase("off")) {
			traceLow = traceHigh = 0;
			traceCycles = 0;
			stopTracing();
		} else if (args[1].equalsIgnoreCase("cycles") && args.length > 2) {
			try {
				traceCycles = Integer.valueOf(args[2]);
			} catch (Exception ee) {}
		} else if (args[1].equalsIgnoreCase("pc") && args.length > 2) {
			// TODO: this could be a nasty race condition...
			try {
				traceLow = Integer.valueOf(args[2], 16);
			} catch (Exception ee) {}
			if (args.length > 3) {
				try {
					traceHigh = Integer.valueOf(args[3], 16);
				} catch (Exception ee) {}
			} else {
				traceHigh = 0x10000;
			}
			if (traceLow >= traceHigh) {
				traceLow = traceHigh = 0;
			}
		} else {
			err.add("unsupported:");
			err.add(args[1]);
			return false;
		}
		return true;
	}

	private GenericDiskDrive findDrive(String name) {
		for (DiskController dev : dsks) {
			GenericDiskDrive drv = dev.findDrive(name);
			if (drv != null) {
				return drv;
			}
		}
		return null;
	}

	private IODevice findDevice(String name) {
		for (IODevice dev : devs) {
			if (name.equals(dev.getDeviceName())) {
				return dev;
			}
		}
		return null;
	}

	/////////////////////////////////////////
	/// Computer interface implementation ///

	public int peek8(int address) {
		int val = mem.read(address);
		return val;
	}
	public void poke8(int address, int value) {
		mem.write(address, value);
	}

	// fetch Interrupt Response byte, IM0 (instruction bytes) or IM2 (vector).
	// Implementation must keep track of multi-byte instruction sequence,
	// and other possible state. For IM0, Z80 will call as long as 'intrFetch' is true.
	public int intrResp(Z80State.IntMode mode) {
		if (mode != Z80State.IntMode.IM2) {
			// Kaypro can only operate in IM2.(?)  IM1 should never call this.
			return 0; // TODO: What to return in this case?
		}
		int vector = -1;
		for (InterruptController ctrl : intrs) {
			vector = ctrl.readDataBus();
			if (vector >= 0) {
				return vector;
			}
		}
		// TODO: what if no device claimed interrupt?
		return vector;
	}

	public int inPort(int port) {
		int val = 0;
		port &= 0xff;
		IODevice dev = ios.get(port);
		if (dev == null) {
			//System.err.format("Undefined Input on port %02x\n", port);
		} else {
			val = dev.in(port);
		}
		return val;
	}
	public void outPort(int port, int value) {
		port &= 0xff;
		IODevice dev = ios.get(port);
		if (dev == null) {
			//System.err.format("Undefined Output on port %02x value %02x\n", port, value);
		} else {
			dev.out(port, value);
		}
	}

	// No longer used...
	public void contendedStates(int address, int tstates) {
		addTicks(tstates);
	}
	// not used?
	public long getTStates() {
		return clock;
	}

	public void breakpoint() {
	}
	public void execDone() {
	}

	//////// Runnable /////////
	public void run() {
		String traceStr = "";
		int clk = 0;
		int limit = 0;
		while (running) {
			cpuLock.lock(); // This might sleep waiting for GUI command...
			limit += intervalTicks;
			long t0 = System.nanoTime();
			int traced = 0; // assuming any tracing cancels 2mS accounting
			while (running && limit > 0) {
				int PC = cpu.getRegPC();
				boolean trace = tracing;
				if (!trace && (traceCycles > 0 ||
						(PC >= traceLow && PC < traceHigh))) {
					trace = true;
				}
				if (trace) {
					++traced;
					traceStr = String.format("{%05d} %04x: %02x %02x %02x %02x " +
						": %02x %04x %04x %04x [%04x] <%02x/%02x>%s",
						clock & 0xffff,
						PC, mem.read(PC), mem.read(PC + 1),
						mem.read(PC + 2), mem.read(PC + 3),
						cpu.getRegA(),
						cpu.getRegBC(),
						cpu.getRegDE(),
						cpu.getRegHL(),
						cpu.getRegSP(),
						intState, intMask,
						cpu.isINTLine() ? " INT" : "");
				}
				clk = cpu.execute();
				setHalted(cpu.isHalted());
				limit -= clk;
				if (traceCycles > 0) {
					traceCycles -= clk;
				}
				addTicks(clk);
				if (trace) {
					// TODO: collect data after instruction?
					System.err.format("%s {%d} %s\n", traceStr, clk,
						disas.disas(PC));
				}
			}
			cpuLock.unlock();
			if (!running) {
				break;
			}
			long t1 = System.nanoTime();
			if (traced == 0) {
				backlogNs += (intervalNs - (t1 - t0));
				t0 = t1;
				if (backlogNs > backlogTime) { 
					try {
						Thread.sleep(backlogTime / 1000000);
					} catch (Exception ee) {}
					t1 = System.nanoTime();
					backlogNs -= (t1 - t0);
				}
			}
			t0 = t1;
		}
		stopped = true;
		stopWait.release();
	}

	public String dumpPage(String pgnum) {
		String str = "";
		int pg = 0;
		try {
			pg = Integer.valueOf(pgnum, 16);
		} catch (Exception ee) {
			return ee.getMessage();
		}
		int adr = pg << 8;
		int end = adr + 0x0100;
		while (adr < end) {
			str += String.format("%04x:", adr);
			for (int x = 0; x < 16; ++x) {
				str += String.format(" %02x", mem.read(adr + x));
			}
			str += '\n';
			adr += 16;
		}
		return str;
	}

	public String dumpDebug() {
		String ret = gpp.dumpDebug();
		ret += String.format("CLK %d", getTStates());
		if (running) {
			ret += " RUN";
		}
		if (stopped) {
			ret += " STOP";
		}
		if (!running && !stopped) {
			ret += " limbo";
		}
		ret += "\n";
		ret += String.format("CPU Backlog = %d nS\n", backlogNs);
		ret += "INT = {";
		for (int x = 0; x < 8; ++x) {
			ret += String.format(" %x", intLines[x]);
		}
		ret += String.format(" } %02x %02x\n", intState, intMask);
		return ret;
	}
}

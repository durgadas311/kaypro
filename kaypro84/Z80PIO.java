// Copyright (c) 2017 Douglas Miller <durgadas311@gmail.com>

import java.util.Arrays;
import java.util.Vector;
import java.util.Properties;
import java.io.*;
import java.lang.reflect.Constructor;

public class Z80PIO implements IODevice {
	private Interruptor intr;
	private int src;
	private int basePort;
	private String name = null;

	private Z80PIOPort[] ports = new Z80PIOPort[2];
	private int intrs = 0;

	public Z80PIO(Properties props, String pfxA, String pfxB, int base,
			Interruptor intr) {
		name = String.format("Z80PIO%d", (base >> 3) + 1);
		this.intr = intr;
		src = intr.registerINT(0);
		basePort = base;
		ports[0] = new Z80PIOPort(props, pfxA, 0);
		ports[1] = new Z80PIOPort(props, pfxB, 1);
		reset();
	}

	///////////////////////////////
	/// Interfaces for IODevice ///
	public int in(int port) {
		int x = port & 1;
		return ports[x].in(port >> 1);
	}

	public void out(int port, int val) {
		int x = port & 1;
		ports[x].out(port >> 1, val);
	}

	public void reset() {
		intrs = 0;
		intr.lowerINT(0, src);
		ports[0].reset();
		ports[1].reset();
	}
	public int getBaseAddress() {
		return basePort;
	}
	public int getNumPorts() {
		return 4;
	}
	public String getDeviceName() {
		return name;
	}

	private void raiseINT(int idx) {
		int i = intrs;
		intrs |= (1 << idx);
		if (i == 0) {
			intr.raiseINT(0, src);
		}
	}

	private void lowerINT(int idx) {
		int i = intrs;
		intrs &= ~(1 << idx);
		if (i != 0 && intrs == 0) {
			intr.lowerINT(0, src);
		}
	}

	public VirtualPPort portA() { return ports[0]; }
	public VirtualPPort portB() { return ports[1]; }

	class Z80PIOPort implements VirtualPPort {
		private Object attObj;
		private OutputStream attFile;
		private boolean excl = true;
		private int index;
		private int mode;	// Operating mode
		private int vec;	// Interrupt vector
		private boolean intrEnable;
		private boolean ready;
		private boolean avail;
		private int data;
		private int inputs;	// I/O Mask (1 = Input)
		private int disables;	// INT disable mask (1 = disable)
		private boolean and;	// All must be active for INT
		private boolean high;	// All must be high for INT

		private boolean ctl;	// control byte follows
		private boolean mask;	// mask byte follows

		public Z80PIOPort(Properties props, String pfx, int idx) {
			attObj = null;
			attFile = null;
			index = idx;
			if (pfx == null) {
				return;
			}
			String s = props.getProperty(pfx + "att");
			if (s != null && s.length() > 1) {
				if (s.charAt(0) == '>') { // redirect output to file
					attachFile(s.substring(1));
				} else if (s.charAt(0) == '!') { // pipe to/from program
					attachPipe(s.substring(1));
				} else {
					attachClass(props, s);
				}
			}
		}

		private void attachFile(String s) {
			String[] args = s.split("\\s");
			setupFile(args, 0);
		}

		private void setupFile(String[] args, int start) {
			boolean append = false;
			for (int x = start + 1; x < args.length; ++x) {
				if (args[x].equals("a")) {
					append = true;
				} else if (args[x].equals("+")) {
					excl = false;
				}
			}
			if (args[start].equalsIgnoreCase("syslog")) {
				attFile = System.err;
				excl = false;
			} else try {
				attFile = new FileOutputStream(args[start], append);
				if (excl) {
					// handshake?
				}
			} catch (Exception ee) {
				System.err.format("Invalid file in attachment: %s\n", args[start]);
				return;
			}
		}

		private void attachPipe(String s) {
			System.err.format("Pipe attachments not yet implemented: %s\n", s);
		}

		private void attachClass(Properties props, String s) {
			String[] args = s.split("\\s");
			for (int x = 1; x < args.length; ++x) {
				if (args[x].startsWith(">")) {
					excl = false;
					args[x] = args[x].substring(1);
					setupFile(args, x);
					// TODO: truncate args so Class doesn't see?
				}
			}
			Vector<String> argv = new Vector<String>(Arrays.asList(args));
			// try to construct from class...
			try {
				Class<?> clazz = Class.forName(args[0]);
				Constructor<?> ctor = clazz.getConstructor(
						Properties.class,
						argv.getClass(),
						VirtualUART.class);
				// funky "new" avoids "argument type mismatch"...
				attObj = ctor.newInstance(
						props,
						argv,
						(VirtualUART)this);
			} catch (Exception ee) {
				System.err.format("Invalid class in attachment: %s\n", s);
				return;
			}
		}

		// Conditions affecting interrupts have changed, ensure proper signal.
		private void chkIntr() {
			// TODO: determine interrupt status
			if (false) {
				raiseINT(index);
			} else {
				lowerINT(index);
			}
		}

		public int in(int port) {
			int x = port & 1;
			int val = 0;
			if (x == 0) {	// data
				switch (mode) {
				case 0:
					break;
				case 1:
				case 2:
					val = data;
					ready = true;
					chkIntr();
					break;
				case 3:
					val = (data & inputs);
					break;
				}
			} else {	// control
				// TODO: what does this mean?
			}
			return val;
		}

		public void out(int port, int val) {
			int x = port & 1;
			val &= 0xff; // necessary?
			if (x == 0) {	// data
				switch (mode) {
				case 0:
				case 2:
					data = val;
					avail = true;
					chkIntr();
					break;
				case 1:
					break;
				case 3:
					data = (data & inputs) | (val & ~inputs);
					chkIntr();	// ??
					break;
				}
			} else {	// control
				if (ctl) {
					ctl = false;
					inputs = val & 0xff;
					return;
				}
				if (mask) {
					mask = false;
					disables = val & 0xff;
					return;
				}
				if ((val & 1) == 0) {
					vec = val;
					return;
				}
				switch (val & 0x0f) {
				case 0x0f:
					mode = (val >> 6);
					ctl = (mode == 3);
					return;
				case 0x07:
					intrEnable = ((val & 0x80) != 0);
					and = ((val & 0x40) != 0);
					high = ((val & 0x20) != 0);
					mask = ((val & 0x10) != 0);
					// TODO: reset intr if mask...
					chkIntr();
				}
			}
		}

		public void reset() {
			ready = false;
			avail = false;
			intrEnable = false;
			mode = 1;
			inputs = 0xff;
		}

		////////////////////////////////////////////////////
		/// Interfaces for the virtual peripheral device ///
		public int available() {
			return avail ? 1 : 0;
		}

		// TODO: must sleep?
		public int take(boolean sleep) {
			int val = 0;
			switch (mode) {
			case 0:
			case 2:
				if (sleep && !avail) {
					// TODO: sleep
				}
				val = data;
				avail = false;
				// TODO: strobe
				break;
			case 1:
				break;
			case 3:
				val = (data & ~inputs);
				break;
			}
			return val;
		}

		public boolean ready() {
			return ready;
		}
		// Must NOT sleep
		public synchronized void put(int ch) {
			switch (mode) {
			case 0:
				break;
			case 1:
			case 2:
				data = ch & 0xff;
				ready = false;
				// status?
				chkIntr();
				break;
			case 3:
				data = (data & ~inputs) | (ch & inputs);
				chkIntr();
				break;
			}
		}

		public String getDeviceName() { return name; }

		public String dumpDebug() {
			String ret = new String();
			ret += String.format("ch %c, vac = %02x mode = %d, dir = %02x data = %02x\n",
				index + 'A', vec, mode, inputs, data);
			return ret;
		}
	}

	public String dumpDebug() {
		String ret = new String();
		ret += String.format("port %02x\n", basePort);
		ret += ports[0].dumpDebug();
		ret += ports[1].dumpDebug();
		return ret;
	}
}

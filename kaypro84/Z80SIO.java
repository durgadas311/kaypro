// Copyright (c) 2017 Douglas Miller <durgadas311@gmail.com>

import java.util.Arrays;
import java.util.Vector;
import java.util.Properties;
import java.io.*;
import java.lang.reflect.Constructor;

public class Z80SIO implements IODevice {
	static final int fifoLimit = 10; // should never even exceed 2
	private Interruptor intr;
	private int src;
	private int basePort;
	private String name = null;

	private Z80SIOPort[] ports = new Z80SIOPort[2];
	private int intrs = 0;

	public Z80SIO(Properties props, String pfxA, String pfxB, int base,
			Interruptor intr) {
		name = String.format("Z80SIO%d", (base >> 3) + 1);
		this.intr = intr;
		src = intr.registerINT(0);
		basePort = base;
		ports[0] = new Z80SIOPort(props, pfxA, 0);
		ports[1] = new Z80SIOPort(props, pfxB, 1);
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

	public VirtualUART portA() { return ports[0]; }
	public BaudListener clockA() { return ports[0]; }
	public VirtualUART portB() { return ports[1]; }
	public BaudListener clockB() { return ports[1]; }

	class Z80SIOPort implements VirtualUART, BaudListener {
		private java.util.concurrent.LinkedBlockingDeque<Integer> fifo;
		private java.util.concurrent.LinkedBlockingDeque<Integer> fifi;
		private byte[] wr;
		private byte[] rr;

		static final int rr0_rxr_c = 0x01;
		static final int rr0_int_c = 0x02;
		static final int rr0_txp_c = 0x04;
		static final int rr0_dcd_c = 0x08;
		static final int rr0_syn_c = 0x10;
		static final int rr0_cts_c = 0x20;
		static final int rr0_txu_c = 0x40;
		static final int rr0_brk_c = 0x80;

		static final int wr5_dtr_c = 0x80;
		static final int wr5_rts_c = 0x02;

		private Object attObj;
		private OutputStream attFile;
		private boolean excl = true;
		private long lastTx = 0;
		private long lastRx = 0;
		private long nanoBaud = 0; // length of char in nanoseconds
		private int bits; // bits per character
		private int index;

		public Z80SIOPort(Properties props, String pfx, int idx) {
			attObj = null;
			attFile = null;
			index = idx;
			fifo = new java.util.concurrent.LinkedBlockingDeque<Integer>();
			fifi = new java.util.concurrent.LinkedBlockingDeque<Integer>();
			wr = new byte[8];
			rr = new byte[8]; // only 3 useable...
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
					setModem(VirtualUART.SET_CTS | VirtualUART.SET_DSR);
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
				synchronized(this) {
					if (fifi.size() > 0) {
						try {
							val = fifi.take();
						} catch (Exception ee) {}
						if (fifi.size() == 0) {
							rr[0] &= ~rr0_rxr_c;
							chkIntr();
						}
					}
				}
			} else {	// control
				int r = wr[0] & 0x07;
				val = rr[r] & 0xff;
				if (r != 0) {
					wr[0] &= ~0x07;
				}
				// TODO: any required updates?
			}
			return val;
		}

		public void out(int port, int val) {
			int x = port & 1;
			val &= 0xff; // necessary?
			if (x == 0) {	// data
				synchronized(this) {
					fifo.add(val);
					rr[0] &= ~rr0_txp_c;
					chkIntr();
				}
			} else {	// control
				int r = wr[0] & 0x07;
				wr[r] = (byte)val;
				if (r != 0) {
					wr[0] &= ~0x07;
				}
				// TODO: check for required updates...
			}
		}

		public void reset() {
			fifo.clear();
			fifi.clear();
			Arrays.fill(wr, (byte)0);
			Arrays.fill(rr, (byte)0);
			rr[0] |= rr0_txp_c;
		}

		////////////////////////////////////////////////////
		/// Interfaces for the virtual peripheral device ///
		public int available() {
			return fifo.size();
		}

		// Must sleep if nothing available...
		public int take() {
			try {
				int c = fifo.take();
				// TODO: how does this work with baud rate?
				if (fifo.size() == 0) {
					synchronized(this) {
						rr[0] |= rr0_txp_c;
						chkIntr();
					}
				}
				return c;
			} catch(Exception ee) {
				return -1;
			}
		}

		public boolean ready() {
			return (rr[0] & rr0_rxr_c) != 0;
		}
		// Must NOT sleep
		public synchronized void put(int ch) {
			// TODO: prevent infinite growth?
			fifi.add(ch & 0xff);
			lastRx = System.nanoTime();
			rr[0] |= rr0_rxr_c;
			chkIntr();
		}
		public void setBaud(int baud) {
			// TODO: implement something
		}

		public void setModem(int mdm) {
			int old = rr[0];
			int nuw = 0;
			if ((mdm & VirtualUART.SET_CTS) != 0) {
				nuw |= rr0_cts_c;
			}
			if ((mdm & VirtualUART.SET_DCD) != 0) {
				nuw |= rr0_dcd_c;
			}
			rr[0] &= ~(rr0_cts_c | rr0_dcd_c);
			rr[0] |= nuw;
			// TODO: must make this thread-safe...
			chkIntr();
		}
		public int getModem() {
			int mdm = 0;
			if ((wr[5] & wr5_dtr_c) != 0) {
				mdm |= VirtualUART.GET_DTR;
			}
			if ((wr[5] & wr5_rts_c) != 0) {
				mdm |= VirtualUART.GET_RTS;
			}
			if ((rr[0] & rr0_cts_c) != 0) {
				mdm |= VirtualUART.SET_CTS;
			}
			if ((rr[0] & rr0_dcd_c) != 0) {
				mdm |= VirtualUART.SET_DCD;
			}
			return mdm;
		}

		public String getDeviceName() { return name; }

		public String dumpDebug() {
			String ret = new String();
			ret += String.format("ch %c, #fifo = %d, #fifi = %d\n",
				index + 'A', fifo.size(), fifi.size());
			// TODO: dump WR and RR...
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

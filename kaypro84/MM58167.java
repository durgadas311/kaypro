// Copyright 2017 Douglas Miller <durgadas311@gmail.com>

import java.util.Arrays;
import java.util.Date;
import java.util.Properties;
import java.awt.event.*;
import java.text.SimpleDateFormat;
import java.text.ParsePosition;

public class MM58167 implements IODevice, ActionListener {
	private int baseAdr;
	private VirtualPPort pio = null;
	private int[] regs;
	private long off = 0;	// in milliseconds.
	private long last = 0;
	private int intr;
	private boolean dirty;
	private int lastWR;
	private javax.swing.Timer[] timers;

	public static SimpleDateFormat timestamp =
		new java.text.SimpleDateFormat("yyyy MM dd F HH:mm:ss.SSS");

	public MM58167(Properties pros, int base, VirtualPPort att) {
		baseAdr = base;
		pio = att;
		regs = new int[32];
		timers = new javax.swing.Timer[8];
		reset();
		// pretend time already set...
		getTime();
		regs[12] = 1; // trick TIME.COM
	}

	private void getTime() {
		long time = off + new Date().getTime();
		Date dt = new Date(time);
		String tod = timestamp.format(dt);
		// Setup year for CP/M 3...
		regs[10] = ((tod.charAt(0) & 0x0f) << 4) |
			(tod.charAt(1) & 0x0f);
		regs[9] = ((tod.charAt(2) & 0x0f) << 4) |
			(tod.charAt(3) & 0x0f);
		// Standard RTC regs
		regs[7] = ((tod.charAt(5) & 0x0f) << 4) |
			(tod.charAt(6) & 0x0f);
		regs[6] = ((tod.charAt(8) & 0x0f) << 4) |
			(tod.charAt(9) & 0x0f);
		regs[5] = (tod.charAt(11) & 0x0f) + 1;
		regs[4] = ((tod.charAt(13) & 0x0f) << 4) |
			(tod.charAt(14) & 0x0f);
		regs[3] = ((tod.charAt(16) & 0x0f) << 4) |
			(tod.charAt(17) & 0x0f);
		regs[2] = ((tod.charAt(19) & 0x0f) << 4) |
			(tod.charAt(20) & 0x0f);
		regs[1] = ((tod.charAt(22) & 0x0f) << 4) |
			(tod.charAt(23) & 0x0f);
		regs[0] = (tod.charAt(24) & 0x0f) << 4;
		dirty = false;
	}

	private void setTime() {
		Date now = new Date();
		String t = timestamp.format(now);
		String tod = t.substring(0, 5) +
			String.format("%02x %02x %d %02x:%02x:%02x.%02x%d",
				regs[7], regs[6], regs[5] - 1, regs[4],
				regs[3], regs[2], regs[1], regs[0] >> 4);
		Date dt = timestamp.parse(tod, new ParsePosition(0));
		off = now.getTime() - dt.getTime();
		dirty = false;
	}

	private void chkIntr() {
		// TODO: Not how we do things?
	}

	// TODO: implement this
	private int computeTime(int x) {
		int t = 0;
		if (x == 0) {
			// get time from compare regs, subtract 'now', ...
		} else if (x == 7) {
			// get current month, compute time to EOM
		}
		return t;
	}

	static final int[] times = new int[] {
		-1,		// 0: comparator - custom timeout, one-shot(?)
		100,		// 1: 1/10 second
		1000,		// 2: 1 second
		60*1000,	// 3: 1 minute
		60*60*1000,	// 4: 1 hour
		24*60*60*1000,	// 5: 1 day
		7*24*60*60*1000,// 6: 1 week
		-1,		// 7: TODO: how to manage 1 month...
	};

	private void setIntr() {
		for (int x = 0; x < 8; ++x) {
			if ((regs[0x11] & (1 << x)) == 0) {
				if (timers[x] != null) {
					timers[x].stop();
					timers[x] = null;
				}
			} else {
				if (timers[x] == null) {
					int t = times[x];
					if (t < 0) { // comparator...
						t = computeTime(x);
					}
					timers[x] = new javax.swing.Timer(t, this);
					timers[x].start(); // TODO: try to synchronize?
				}
			}
		}
	}

	private int getAddr(int port) {
		int adr = 0;
		if (pio != null) {
			adr = pio.take(false); // must not sleep
		} else {
			adr = port - baseAdr;	// TODO: extract some other address?
		}
		return adr & 0x1f;
	}

	public void reset() {
		Arrays.fill(regs, 0);
		intr = 0x80;
		if (pio != null) {
			// TODO: make bits configurable?
			pio.put(intr);
		}
		off = 0;
		dirty = false;
		lastWR = -1;
	}

	public int getBaseAddress() { return baseAdr; }
	public int getNumPorts() { return 4; }
	public int in(int port) {
		int val = 0;
		int adr = getAddr(port);
		if (adr < 0x08) {
			long t0 = System.nanoTime();
			if (lastWR != adr && (dirty || t0 - last >= 1000000)) {
				if (dirty) {
					setTime();
				} else {
					getTime();
				}
				// TODO: must avoid setting this initially...
				//regs[0x14] |= 1;
				last = t0;
			}
		}
		val = regs[adr];
		// TODO: any post-processing?
		if (adr == 0x14) {
			regs[adr] = 0;
		}
		if (adr == 0x10) {
			regs[adr] = 0;
			intr &= ~0x40;
			pio.put(intr);
		}
		return val;
	}
	public void out(int port, int value) {
		int adr = getAddr(port);
		lastWR = adr;
		regs[adr] = value;
		if (adr < 0x08) {
			dirty = true;
		}
		if (adr >= 0x08 && adr <= 0x0f) {
			chkIntr();
		}
		switch (adr) {
		case 0x11:	// Interrupt Control
			setIntr();
			break;
		case 0x12:	// Counters reset
			if (value == 0xff) {
				Arrays.fill(regs, 0, 8, 0);
				chkIntr(); // ?
			}
			break;
		case 0x13:	// RAM reset
			if (value == 0xff) {
				Arrays.fill(regs, 8, 16, 0);
				chkIntr(); // ?
			}
			break;
		case 0x14:
			// ??
			break;
		case 0x15:	// GO command
			Arrays.fill(regs, 0, 3, 0);
			setTime();
			break;
		case 0x1f:
			// TODO: support test mode?
			break;

		}
	}

	public void actionPerformed(ActionEvent e) {
		for (int x = 0; x < 8; ++x) {
			if (e.getSource() != timers[x]) {
				continue;
			}
			regs[0x10] |= (1 << x);
			intr |= 0x40;
			pio.put(intr);
			break;
		}
	}

	public String getDeviceName() {
		return "MM58167";
	}
	public String dumpDebug() {
		String str = String.format("%02x %02x %02x %02x %02x %02x %02x %02x\n" +
					"%02x %02x %02x %02x %02x %02x %02x %02x\n",
			regs[0], regs[1], regs[2], regs[3],
			regs[4], regs[5], regs[6], regs[7],
			regs[8], regs[9], regs[10], regs[11],
			regs[12], regs[13], regs[14], regs[15]);
		return str;
	}
}

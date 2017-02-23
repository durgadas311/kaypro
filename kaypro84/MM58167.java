// Copyright 2017 Douglas Miller <durgadas311@gmail.com>
import java.util.Arrays;
import java.util.Date;
import java.util.Properties;
import java.text.SimpleDateFormat;
import java.text.ParsePosition;

public class MM58167 implements IODevice {
	private int baseAdr;
	private VirtualPPort pio = null;
	private int[] regs;
	private long off = 0;	// in milliseconds.
	private long last = 0;
	private int intr;
	private boolean dirty;
	private int lastWR;

	public static SimpleDateFormat timestamp =
		new java.text.SimpleDateFormat("yyyy MM dd F HH:mm:ss.SSS");

	public MM58167(Properties pros, int base, VirtualPPort att) {
		baseAdr = base;
		pio = att;
		regs = new int[32];
		reset();
	}

	private void getTime() {
		long time = off + new Date().getTime();
		Date dt = new Date(time);
		String tod = timestamp.format(dt);
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
		if (pio != null) {
			// TODO: make bits configurable?
			pio.put(0x80);
		}
		intr = 0;
		off = 0;
		dirty = false;
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
		lastWR = adr;
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

// Copyright (c) 2026 Douglas Miller
import java.awt.event.*;
import java.io.*;
import java.util.Map;
import java.util.HashMap;
import java.util.Vector;
import java.util.Properties;
import javax.sound.sampled.*;

public class TtyKeyboard extends TtySerial implements Keyboard, Runnable {
	VirtualUART _uart;
	java.util.concurrent.LinkedBlockingDeque<String> fifo;
	int paste_delay = 0;	// mS, 1000/cps
	int cr_delay = 0;	// mS

	public TtyKeyboard(Properties props, Vector<String> argv,
			VirtualUART uart) {
		super(props, argv, uart);
		_uart = uart;
		fifo = new java.util.concurrent.LinkedBlockingDeque<String>();
		String s = props.getProperty("kaypro_paste_rate");
		int cps = 0;
		int crd = 0;
		if (s != null) {
			try {
				cps = Integer.valueOf(s);
			} catch (Exception ee) {
				cps = 33;
				System.err.format("Bad paste rate \"%s\", using %d\n",
									s, cps);
			}
		}
		s = props.getProperty("kaypro_paste_cr_delay");
		if (s != null) {
			try {
				crd = Integer.valueOf(s);
			} catch (Exception ee) {
				crd = cps > 0 ? 3 * (1000 / cps) : 100;
				System.err.format("Bad paste CR delay \"%s\", using %d\n",
									s, crd);
			}
		}
		if (cps > 0 && crd <= 0) {
			crd = 3 * (1000 / cps);
		}
		setPasteRate(cps, crd);
		Thread t = new Thread(new KeyboardPaster());
		t.start();
	}

	public void setPasteRate(int cps, int cr) {
		if (cps > 0) {
			if (cps < 1) {
				cps = 1;
			}
			int dly = 1000 / cps;
			if (dly <= 0) {
				dly = 1;
			}
			paste_delay = dly;
		}
		if (cr > 0) {
			cr_delay = cr;
		}
	}

	public void paste(String s) {
		// TODO: what is the right translation here?
		fifo.add(s.replaceAll("\n", "\r"));
	}

	// These are (currently) not used... but are called/required.
	// Could be used as override of Tty attached keyboard.
	public void keyTyped(KeyEvent e) { }
	public void keyPressed(KeyEvent e) { }
	public void keyReleased(KeyEvent e) { }

	// Must not override TtySerial.run()...
	class KeyboardPaster implements Runnable {
		public void run() {
			// everything on 'fifo' is pasted text, throttle it.
			while (true) {
				String s = null;
				try {
					s = fifo.take();
				} catch (Exception ee) { }
				if (s == null) {
					continue;
				}
				for (byte b : s.getBytes()) {
					_uart.put(b & 0xff, true);
					if (paste_delay > 0) try {
						if (b == '\r') {
							Thread.sleep(cr_delay);
						} else {
							Thread.sleep(paste_delay);
						}
					} catch (Exception ee) {}
				}
			}
		}
	}
}

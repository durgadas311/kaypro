// Copyright (c) 2017 Douglas Miller
import java.awt.event.*;
import java.io.*;
import java.util.Map;
import java.util.HashMap;
import java.util.Vector;

public class KayproKeyboard implements PasteListener, KeyListener, Runnable {
	OutputStream _fout;
	java.util.concurrent.LinkedBlockingDeque<String> fifo;
	int paste_delay = 33;	// mS, 1000/cps
	int cr_delay = 100;	// mS
	static final Map<Integer, Integer> altKeys;
	static {
		altKeys = new HashMap<Integer, Integer>();
		altKeys.put((int)'0', 0xb1);
		altKeys.put((int)'1', 0xc0);
		altKeys.put((int)'2', 0xc1);
		altKeys.put((int)'3', 0xc2);
		altKeys.put((int)'4', 0xd0);
		altKeys.put((int)'5', 0xd1);
		altKeys.put((int)'6', 0xd2);
		altKeys.put((int)'7', 0xe1);
		altKeys.put((int)'8', 0xe2);
		altKeys.put((int)'9', 0xe3);
		altKeys.put((int)'-', 0xe4);
		altKeys.put((int)',', 0xd3); // TODO: not on modern keyboard!
		altKeys.put((int)'+', 0xd3); // same relative position as comma...
		altKeys.put((int)'\n', 0xc3);
		altKeys.put((int)'.', 0xb2);
	}

	public KayproKeyboard(OutputStream fout) {
		_fout = fout;
		insertToggle = false;
		resetees = new Vector<ResetListener>();
		fifo = new java.util.concurrent.LinkedBlockingDeque<String>();
		Thread t = new Thread(this);
		t.start();
	}

	public void sendBack(String s) {
		byte[] bs = s.getBytes();
		try {
			_fout.write(bs);
			_fout.flush();
		} catch (Exception ee) {
		}
	}

	public void setPasteRate(int cps, int cr) {
		if (cps >= 0) {
			if (cps < 1) {
				cps = 1;
			}
			int dly = 1000 / cps;
			if (dly <= 0) {
				dly = 1;
			}
			paste_delay = dly;
		}
		if (cr >= 0) {
			cr_delay = cr;
		}
	}

	public void paste(String s) {
		// TODO: what is the right translation here?
		fifo.add(s.replaceAll("\n", "\r"));
	}

        public void keyTyped(KeyEvent e) { }

        public void keyPressed(KeyEvent e) {
		int s = -1;
                char c = e.getKeyChar();
                int k = e.getKeyCode();
  		int m = e.getModifiers();
		int l = e.getKeyLocation();
		if (l == KeyEvent.KEY_LOCATION_NUMPAD &&
				c != KeyEvent.CHAR_UNDEFINED) {
			if (altKeys.containsKey(c)) {
				s = altKeys.get(c);
			}
		}
  		// Assume if CTRL is down, must be ^J not ENTER...
  		if (k == KeyEvent.VK_ENTER && (m & InputEvent.CTRL_MASK) == 0) {
  			s = 0x0d;
  		}
		if (k == KeyEvent.VK_BACK_SPACE && (m & InputEvent.SHIFT_MASK) != 0) {
			s = 0x7f;
		}
		if (k == KeyEvent.VK_UP) {
			s = 0xf1;
		} else if (k == KeyEvent.VK_DOWN) {
			s = 0xf2;
		} else if (k == KeyEvent.VK_LEFT) {
			s = 0xf3;
		} else if (k == KeyEvent.VK_RIGHT) {
			s = 0xf4;
		}
		if (s < 0) {
			s = c;
		}
		// TODO: do we ever NOT consume event?
		try {
			_fout.write(s);
			_fout.flush();
			e.consume();
		} catch (Exception ee) {
			// handle? probably means back-end is dead...
		}
        }

        public void keyReleased(KeyEvent e) {
        }

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
			try {
				for (byte b : s.getBytes()) {
					_fout.write(b);
					if (b == '\r') {
						Thread.sleep(cr_delay);
					} else {
						Thread.sleep(paste_delay);
					}
				}
				_fout.flush();
			} catch (Exception ee) {
			}
		}
	}
}

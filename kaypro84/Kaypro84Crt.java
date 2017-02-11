// Copyright (c) 2017 Douglas Miller
import java.util.Arrays;
import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import java.awt.datatransfer.Transferable;
import java.awt.datatransfer.DataFlavor;
import java.awt.datatransfer.StringSelection;

public class CrtScreen extends JPanel
		implements ScreenDumper, ActionListener,
			MouseListener, MouseMotionListener {
	static final long serialVersionUID = 198900000001L;
	String[] lines = new String[25];
	private FontMetrics _fm;
	private int _fa; //, _fd;
	private int _fw, _fh;
	float _fz;
	int curs_x;
	int curs_y;
	String curs_char = "";
	boolean curs_on = true;
	boolean blink = false;
	javax.swing.Timer timer;
	Dimension _dim;
	int bd_width;
	boolean drag = false;
	Point dragStart;
	Point dragStop;
	int dragCount = 0;
	static final Color highlight = new Color(100, 100, 120);
	PasteListener paster = null;

	private char[] charCvt = null;

	public void setISO() {
		charCvt = new char[256];
		Arrays.fill(charCvt, '\0');
		for (int x = 32; x < 127; ++x) {
			charCvt[x] = (char)x;
		}
		// graphics chars
		charCvt[0] = '\u2502';
		charCvt[1] = '\u2500';
		charCvt[2] = '\u253c';
		charCvt[3] = '\u2510';
		charCvt[4] = '\u2518';
		charCvt[5] = '\u2514';
		charCvt[6] = '\u250c';
		charCvt[7] = '\u00b1';
		charCvt[8] = '\u2192';
		charCvt[9] = '\u2592';
		charCvt[10] = '\u00f7';
		charCvt[11] = '\u2193';
		charCvt[12] = '\u2597';
		charCvt[13] = '\u2596';
		charCvt[14] = '\u2598';
		charCvt[15] = '\u259d';
		charCvt[16] = '\u2580';
		charCvt[17] = '\u2590';
		charCvt[18] = '\u25e4';
		charCvt[19] = '\u252c';
		charCvt[20] = '\u2524';
		charCvt[21] = '\u2534';
		charCvt[22] = '\u2516';
		charCvt[23] = '\u2573';
		charCvt[24] = '\u2571';
		charCvt[25] = '\u2572';
		charCvt[26] = '\u2594';
		charCvt[27] = '\u2581';
		charCvt[28] = '\u258f';
		charCvt[29] = '\u2595';
		charCvt[30] = '\u00b6';
		charCvt[31] = '\u25e5';
		charCvt[127] = '\u2022';
		// rev-video graphics chars override
		charCvt[0x80+18] = '\u25e2';
		charCvt[0x80+31] = '\u25e3';
		blockCursor(false);
	}

	public Dimension getNormSize() {
		return _dim;
	}

	public CrtScreen(float fz) {
		_fz = fz;
		clearScreen();
		timer = new Timer(500, this);
		timer.start();
		setBackground(new Color(50,50,50, 255));
		setOpaque(true);
		bd_width = 3;
		blockCursor(false);
		addMouseListener(this);
	}

	public void setFont(Font f) {
		super.setFont(f);
		_fm = getFontMetrics(f);
		_fa = _fm.getAscent();
		//_fd = _fm.getDescent();
		_fw = _fm.charWidth('M');
		_fh = _fm.getHeight();

		// e.g. Font 30f = ascent 15.6, * 19.2 = 29.952... but getAscent is 16.
		// so, Math.round() would be correct if we had not already rounded...
		// TBD: what happens for sizes other than 30f?
		// Might need to employ getLineMetrics, but need graphics context...
		//_fh = (int)Math.floor(_fw * 1.92f);
		_fh = (int)Math.floor(_fz);
		//System.err.format("%s ascent=%d descent=%d width=%d height=%d\n", f.getName(), _fa, _fd, _fw, _fh);
		// leave room for borders...
		_dim = new Dimension(_fw * 80 + 2 * bd_width, _fh * 25 + 2 * bd_width);
		super.setPreferredSize(_dim);
		// TODO: determine how to do reverse video and graphics,
		// if this is not a custom H19 font.
	}

	public void setPasteListener(PasteListener lstn) {
		paster = lstn;
	}

	private void isoPaint(Graphics2D g2d) {
		char[] chr = new char[1];
		int y;
		for (y = 0;  y < 25; ++y) {
			int xx = bd_width;
			int yy = y * _fh + bd_width;
			for (int x = 0; x < 80; ++x) {
				boolean r = (lines[y].charAt(x) & 0x80) != 0;
				char c = charCvt[lines[y].charAt(x) & 0xff];
				if (c == 0) {
					if (r) {
						g2d.setColor(getForeground());
						g2d.fillRect(xx, yy, _fw, _fh);
						g2d.setColor(getBackground());
					}
					c = charCvt[lines[y].charAt(x) & 0x7f];
				}
				chr[0] = c;
				g2d.drawChars(chr, 0, 1, xx, yy + _fa);
				if (r) {
					g2d.setColor(getForeground());
				}
				xx += _fw;
			}
		}
	}

	private void paintHighlight(Graphics2D g2d) {
		int x0 = (int)dragStart.getX();
		int y0 = (int)dragStart.getY();
		int x1 = 80;
		int y1 = (int)dragStop.getY();
		g2d.setColor(highlight);
		for (int y = y0; y < y1; ++y) {
			if (y + 1 == y1) {
				x1 = (int)dragStop.getX();
			}
			g2d.fillRect(x0 * _fw + bd_width, y * _fh + bd_width,
					(x1 - x0) * _fw, _fh);
			x0 = 0;
		}
		g2d.setColor(getForeground());
	}

	public void paint(Graphics g) {
		super.paint(g);
		Graphics2D g2d = (Graphics2D)g;
		if (drag) {
			paintHighlight(g2d);
		}
		int y;
		if (charCvt != null) {
			isoPaint(g2d);
		} else for (y = 0;  y < 25; ++y) {
			g2d.drawString(lines[y], bd_width, y * _fh + _fa + bd_width);
		}
		if (blink && curs_on) {
			g2d.drawString(curs_char, curs_x * _fw + bd_width, curs_y * _fh + _fa + bd_width);
		}
	}

	private void _scrollDown(int y) {
		for (int x = 23; x > y; --x) {
			lines[x] = lines[x - 1];
		}
		lines[y] = String.format("%80s", "");
		repaint();
	}

	private void _scrollUp(int y) {
		for (int x = y; x < 23; ++x) {
			lines[x] = lines[x + 1];
		}
		lines[23] = String.format("%80s", "");
		repaint();
	}

	public void enableCursor(boolean on) {
		curs_on = on;
		repaint();
	}

	public void blockCursor(boolean on) {
		if (charCvt != null) { // i.e. ISO charset
			if (on) {
				curs_char = "\u2588";
			} else {
				curs_char = "\u2581";
			}
		} else if (on) {
			curs_char = "\u00a0";
		} else {
			curs_char = "\u011b";
		}
		repaint();
	}

	public void clearScreen() {
		for (int x = 0; x < 25; ++x) {
			lines[x] = String.format("%80s", "");
		}
		repaint();
	}

	public void insertChar(char c, int x, int y) {
		// Ugh...
		lines[y] = String.format("%-80s",
			lines[y].substring(0, x) + c +
			lines[y].substring(x, 79));
		repaint();
	}

	public void putChar(char c, int x, int y) {
		// Ugh...
		lines[y] = String.format("%-80s",
			lines[y].substring(0, x) + c +
			lines[y].substring(x + 1));
		repaint();
	}

	public void scrollUp() {
		_scrollUp(0);
	}

	public void scrollDown() {
		_scrollDown(0);
	}

	public void setCursor(int x, int y) {
		if (curs_x != x || curs_y != y) {
			curs_x = x;
			curs_y = y;
			repaint();
		}
	}

	public void clearLine(int y) {
		lines[y] = String.format("%80s", "");
		repaint();
	}

	public void clearBOP(int x, int y) {
		clearBOL(x, y);
		if (y == 24) {
			return;
		}
		for (int z = y - 1; z >= 0; --z) {
			clearLine(z);
		}
	}
	public void clearEOP(int x, int y) {
		clearEOL(x, y);
		for (int z = y + 1; z < 24; ++z) {
			clearLine(z);
		}
	}
	public void clearBOL(int x, int y) {
		lines[y] = String.format("%80s", lines[y].substring(x + 1));
		repaint();
	}
	public void clearEOL(int x, int y) {
		if (x == 0) {
			clearLine(y);
		} else {
			lines[y] = String.format("%-80s", lines[y].substring(0, x));
			repaint();
		}
	}

	public void insertLine(int y) {
		if (y == 24) {
			return;
		}
		_scrollDown(y);
	}

	public void deleteLine(int y) {
		if (y == 24) {
			return;
		}
		_scrollUp(y);
	}

	public void deleteChar(int x, int y) {
		lines[y] = String.format("%-80s",
			lines[y].substring(0, x) +
			lines[y].substring(x + 1));
		repaint();
	}

	private int graphicsChar(int c) {
		if (c >= '`') {
			c -= '`';
		} else if (c == '^') {
			c = 0x7f;
		} else if (c == '_') {
			c = 0x1f;
		}
		return c;
	}

	public int specialChar(int c, boolean rev, boolean gra) {
		// This will need to change if the font does not have
		// custom glyphs for H19 effects.
		// 'c' starts as code in 0x20-0x7e (' '..'~')
		if (rev) {
			if (gra) {
				c = graphicsChar(c);
			}
			c += '\u0080';
		} else if (gra) {
			c = graphicsChar(c);
		}
		if (c < ' ') {
			c += '\u0100';
		}
		return c;
	}

	// TODO: change for ISO charsets/fonts?
	// This currently neutralizes reverse video and graphics,
	// eliminating those attributes completely.
	private String normalize(String line) {
		byte[] str = new byte[line.length()];
		for (int x = 0; x < line.length(); ++x) {
			int c = line.charAt(x);
			if (c >= '\u0100') {
				c -= '\u0100'; // collapse graphics with rev-graphics
			}
			if (c >= '\u0080') {
				c -= '\u0080'; // remove reverse video
			}
			if (c < 0x20) {
				c += '`';
				if (c == 0x7f) {
					c = '_';
				}
			} else if (c == 0x7f) {
				c = '^';
			}
			str[x] = (byte)c;
		}
		return new String(str);
	}

	private String getRegion(Point p0, Point p1) {
		String s = "";
		int x0 = (int)p0.getX();
		int y0 = (int)p0.getY();
		int x1 = 80;
		int y1 = (int)p1.getY();
		for (int y = y0; y < y1; ++y) {
			if (y + 1 == y1) {
				x1 = (int)p1.getX();
			}
			if (!s.isEmpty()) {
				s += '\n';
			}
			s += normalize(lines[y].substring(x0, x1).replaceAll("\\s+$",""));
			x0 = 0;
		}
		return s;
	}

	// TODO: does this need to reconstruct graphics/reverse-video
	// ESC sequences?
	public String getScreen(int line) {
		String str = "";
		if (line >= lines.length) {
			return str;
		}
		int b = 0;
		int e = 23;
		if (line >= 0) {
			b = e = line;
		}
		for (int y = b; y <= e; ++y) {
			str += normalize(lines[y]);
		}
		return str;
	}

	public String dumpScreen(int line) {
		String str = "";
		if (line >= lines.length) {
			return str;
		}
		int b = 0;
		int e = 23;
		if (line >= 0) {
			b = e = line;
		}
		for (int y = b; y <= e; ++y) {
			str += normalize(lines[y].replaceAll("\\s+$","")) + '\n';
		}
		return str;
	}

	public void actionPerformed(ActionEvent e) {
		if (e.getSource() == timer) {
			blink = !blink;
			if (dragCount > 0) {
				--dragCount;
				if (dragCount == 0) {
					drag = false;
				}
			}
			repaint();
			return;
		}
	}

	private Point charStart(Point mp) {
		Point p = new Point();
		p.x = (int)Math.floor((mp.getX() - bd_width) / _fw);
		p.y = (int)Math.floor((mp.getY() - bd_width) / _fh);
		return p;
	}

	private Point charEnd(Point mp) {
		Point p = new Point();
		p.x = (int)Math.ceil((mp.getX() - bd_width) / _fw);
		p.y = (int)Math.ceil((mp.getY() - bd_width) / _fh);
		return p;
	}

	public void mouseClicked(MouseEvent e) {
		if (e.getButton() != MouseEvent.BUTTON2) {
			return;
		}
		if (paster == null) {
			return;
		}
		Transferable t = Toolkit.getDefaultToolkit().
				getSystemClipboard().getContents(null);
		try {
			if (t != null && t.isDataFlavorSupported(DataFlavor.stringFlavor)) {
				String text = (String)t.getTransferData(DataFlavor.stringFlavor);
				paster.paste(text);
			}
		} catch (Exception ee) {
		}
	}
	public void mouseEntered(MouseEvent e) { }
	public void mouseExited(MouseEvent e) { }
	public void mousePressed(MouseEvent e) {
		if (e.getButton() != MouseEvent.BUTTON1) {
			return;
		}
		drag = true;
		dragStop = dragStart = charStart(e.getPoint());
		addMouseMotionListener(this);
	}
	public void mouseReleased(MouseEvent e) {
		if (e.getButton() != MouseEvent.BUTTON1) {
			return;
		}
		dragCount = 5;
		repaint();
		removeMouseMotionListener(this);
		if (dragStart.equals(dragStop)) {
			return;
		}
		StringSelection ss = new StringSelection(getRegion(dragStart, dragStop));
		Toolkit.getDefaultToolkit().getSystemClipboard().setContents(ss, null);
	}

	public void mouseDragged(MouseEvent e) {
		dragStop = charEnd(e.getPoint());
		repaint();
	}
	public void mouseMoved(MouseEvent e) { }
}

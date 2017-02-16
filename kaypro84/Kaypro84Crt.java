// Copyright (c) 2017 Douglas Miller
import java.util.Arrays;
import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import java.awt.datatransfer.Transferable;
import java.awt.datatransfer.DataFlavor;
import java.awt.datatransfer.StringSelection;

public class Kaypro84Crt extends KayproCrt
		implements ActionListener, MouseListener, MouseMotionListener {
	static final long serialVersionUID = 198900000001L;

	static final int base = 0x1c;
	static final int vccmd = base;
	static final int vcstat = base;
	static final int vcrdat = base + 1;
	static final int vcdata = base + 3;
	String[] lines = new String[25];
	String[] blinks = new String[25];
	String[] halfint = new String[25];
	String[] halfblnk = new String[25];
	int[] ram = new int[2048]; // char + attrs
	private FontMetrics _fm;
	private int _fa; //, _fd;
	private int _fw, _fh;
	float _fz;
	int curs_x;
	int curs_y;
	boolean curs_on = true;
	int blink = 0;
	boolean crt_en = false;
	javax.swing.Timer timer;
	Dimension _dim;
	int bd_width;
	boolean drag = false;
	Point dragStart;
	Point dragStop;
	int dragCount = 0;
	static final Color highlight = new Color(100, 100, 120);
	PasteListener paster = null;

	private int curReg;
	private int data;
	private byte[] regs;
	private byte[] msks = new byte[]{
		0xff,	// R0
		0xff,	// R1
		0xff,	// R2
		0x0f,	// R3
		0x7f,	// R4
		0x1f,	// R5
		0x7f,	// R6
		0x7f,	// R7
		0x03,	// R8
		0x1f,	// R9
		0x7f,	// R10
		0x1f,	// R11
		0x3f,	// R12
		0xff,	// R13
		0x3f,	// R14
		0xff,	// R15
		0x3f,	// R16
		0xff,	// R17
		0x3f,	// R18	(is 81-189 same as MC6845?)
		0xff,	// R19
		0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
		0xff, 0xff, 0xff, 0xff, 0xff,
	};
	private int horizTotal;
	private int horizDisp;
	private int hSyncPos;
	private int hSyncWid;
	private int vertTotal;
	private int vertAdj;
	private int vertDisp;
	private int horizTotal;
	private int horizTotal;
	private int horizTotal;
	private int horizTotal;
	private int horizTotal;
	private int horizTotal;
	private int horizTotal;
	private int horizTotal;

	public Dimension getNormSize() {
		return _dim;
	}

	public Kaypro84Crt(Properties props) {
		regs = new byte[32];
		String f = "Kaypro84.ttf";
		float fz = 16f;
		Color fc = Color.green;
		String s = props.getProperty("kaypro_font");
		if (s != null) {
			f = s;
		}
		s = props.getProperty("kaypro_font_size");
		if (s != null) {
			fz = Float.valueOf(s);
		}
		s = props.getProperty("kaypro_font_color");
		if (s != null) {
			fc = new Color(Integer.valueOf(s, 16));
		}
		_fz = fz;
		clearScreen();
		timer = new Timer(308, this);
		timer.start();
		setBackground(new Color(50,50,50, 255));
		setOpaque(true);
		Font font = null;
		if (f.endsWith(".ttf")) {
			try {
				File ff = new File(f);
				java.io.InputStream ttf;
				if (ff.exists()) {
					ttf = new FileInputStream(ff);
				} else {
					ttf = VirtualKaypro.class.getResourceAsStream(f);
				}
				if (ttf != null) {
					font = Font.createFont(Font.TRUETYPE_FONT, ttf);
					font = font.deriveFont(fz);
				}
			} catch (Exception ee) {
				font = null;
			}
		} else {
			font = new Font(f, Font.PLAIN, (int)fz);
		}
		if (font == null) {
			System.err.println("Missing font \"" +
					f + "\", using default");
			font = new Font("Monospaced", Font.PLAIN, 10);
		}
		setFont(font);
		setForeground(fc);
		bd_width = 3;
		blockCursor(false);
		addMouseListener(this);
		reset();
	}

	private void setFont(Font f) {
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
	}

	public void setPasteListener(PasteListener lstn) {
		paster = lstn;
	}

	public void reset() {
		crt_en = false;
		Arrays.fill(regs, (byte)0);
	}

	public int getBaseAddress() {
		return base;
	}

	public int getNumPorts() {
		return 4;
	}

	public int in(int port) {
		int val = 0;
		switch(port) {
		case vcstat:
			val = status;
			break;
		case vcrdat:
			val = get_vcrdat();
			break;
		case vcdata:
			val = data;
			break;
		}
		return val;
	}

	public void out(int port, int value) {
		switch(port) {
		case vccmd:
			do_vccmd(value);
			break;
		case vcrdat:
			do_vcrdat(value);
			break;
		case vcdata:
			do_vcdata(value);
			break;
		}
	}

	public String getDeviceName() {
		return "MC6845";
	}

	public String dumpDebug() {
		return "";
	}

	private void do_vccmd(int value) {
		// essentially, CRTC register number...
		curReg = value & 0x1f;
		if (value == 0x1f) {
			// TODO: strobe, or "tickle", command
		}
	}

	private void do_vcrdat(int value) {
		regs[curReg] = value & msks[curReg];
		// TODO: any triggers?
	}

	private int get_vcrdat() {
		return regs[curReg];
	}

	private void do_vcdata(int value) {
		data = value & 0xff;
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
		if (!crt_en) {
			return;
		}
		Graphics2D g2d = (Graphics2D)g;
		if (drag) {
			paintHighlight(g2d);
		}
		int y;
		for (y = 0;  y < 25; ++y) {
			g2d.drawChars(lines[y], bd_width, y * _fh + _fa + bd_width);
		}
		if ((blink & 0x02) != 0) for (y = 0;  y < 25; ++y) {
			g2d.drawChars(blinks[y], bd_width, y * _fh + _fa + bd_width);
		}
		g2d.setColor(halfIntensity);
		for (y = 0;  y < 25; ++y) {
			g2d.drawChars(halfint[y], bd_width, y * _fh + _fa + bd_width);
		}
		if ((blink & 0x02) != 0) for (y = 0;  y < 25; ++y) {
			g2d.drawChars(halfblnk[y], bd_width, y * _fh + _fa + bd_width);
		}
		if ((blink & 0x01) == 0) && curs_on) {
			// TODO: is cursor solid or rev-video?
			g2d.fillRect(curs_x * _fw + bd_width,
				curs_y * _fh + bd_width + regs[10],
				_fw + 1, regs[11] - regs[10] + 1);
		}
	}

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
			blink = (blink + 1) & 0x03;
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

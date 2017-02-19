// Copyright (c) 2017 Douglas Miller
import java.util.Arrays;
import java.util.Properties;
import java.io.*;
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
	char[] lines = new char[2048];
	char[] blinks = new char[2048];
	char[] halfint = new char[2048];
	char[] halfblnk = new char[2048];
	int[] ram = new int[2048]; // char + attrs
	int status;
	private FontMetrics _fm;
	private int _fa; //, _fd;
	private int _fw, _fh;
	float _fz;
	int curs_x;
	int curs_y;
	int curs_s;
	int curs_e;
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
	Color halfIntensity;
	PasteListener paster = null;

	private int curReg;
	private int data;
	private int[] regs;
	private int[] msks = new int[]{
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

	public Dimension getNormSize() {
		return _dim;
	}

	public Kaypro84Crt(Properties props) {
		regs = new int[32];
		Arrays.fill(lines, ' ');
		Arrays.fill(blinks, ' ');
		Arrays.fill(halfint, ' ');
		Arrays.fill(halfblnk, ' ');
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
		s = props.getProperty("kaypro_font_color2");
		if (s != null) {
			halfIntensity = new Color(Integer.valueOf(s, 16));
		} else {
			halfIntensity = fc.darker().darker();
		}
		_fz = fz;
		timer = new javax.swing.Timer(308, this);
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
		setupFont(font);
		setForeground(fc);
		bd_width = 3;
		addMouseListener(this);
		reset();
	}

	private void setupFont(Font f) {
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
		Arrays.fill(regs, 0);
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
			val = status | 0x80;
			status &= 0x7f;
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
		String str = String.format(
			" R0=%02x  R1=%02x  R2=%02x  R3=%02x\n" +
			" R4=%02x  R5=%02x  R6=%02x  R7=%02x\n" +
			" R8=%02x  R9=%02x R10=%02x R11=%02x\n" +
			"R12=%02x R13=%02x R14=%02x R15=%02x\n" +
			"R16=%02x R17=%02x R18=%02x R19=%02x\n",
			regs[0], regs[1], regs[2], regs[3],
			regs[4], regs[5], regs[6], regs[7],
			regs[8], regs[9], regs[10], regs[11],
			regs[12], regs[13], regs[14], regs[15],
			regs[16], regs[17], regs[18], regs[19]);
		return str;
	}

	private void do_vccmd(int value) {
		// essentially, CRTC register number...
		curReg = value & 0x1f;
		if (value == 0x1f) {
			// TODO: strobe, or "tickle", command
			if (!crt_en) {
				crt_en = true;
				repaint();
			} else {
			}
			status |= 0x80;
		}
	}

	private void do_vcrdat(int value) {
		int d;
		regs[curReg] = value & msks[curReg];
		// TODO: any triggers?
		switch(curReg) {
		case 10:
			curs_s = regs[10] & 0x1f;
			curs_on = (regs[10] & 0x60) == 0x60;
			break;
		case 11:
			curs_e = regs[11];
			break;
		case 14:
		case 15:
		case 12:
		case 13:
			d = (regs[14] << 8) | regs[15];
			d -= (regs[12] << 8) | regs[13];
			d &= 0x07ff;
			curs_y = d / regs[1];
			curs_x = d % regs[1];
			break;
		}
	}

	private int get_vcrdat() {
		return regs[curReg];
	}

	private char chr2Font(int ch) {
		ch &= 0x09ff;
		ch += (ch & 0x0100); // move rev-vid bit over one
		return (char)ch;
	}

	private void setChar(int adr, int chr) {
		adr &= 0x7ff;
		switch(chr & 0x0600) {
		case 0x0200:	// half intensity
			halfint[adr] = chr2Font(chr);
			break;
		case 0x0400:	// blinking
			blinks[adr] = chr2Font(chr);
			break;
		case 0x0600:	// blinking half intensity
			halfblnk[adr] = chr2Font(chr);
			break;
		default:
			lines[adr] = chr2Font(chr);
			break;
		}
	}

	private void updateAttr(int adr, int atr) {
		adr &= 0x7ff;
		int old = ram[adr];
		int nuw = atr | (old & 0xff);
		ram[adr] = nuw;
		if (((nuw ^ old) & 0x0600) != 0) {
			setChar(adr, (old & 0x0600) | ' ');
		}
		setChar(adr, nuw);
	}

	private void updateChar(int adr, int chr) {
		int old = ram[adr & 0x7ff];
		int nuw = (old & 0xff00) | chr;
		ram[adr & 0x7ff] = nuw;
		setChar(adr, nuw);
	}

	private void do_vcdata(int value) {
		// hack? this also honors 'curReg'... it seems...
		if (curReg < 0x1f) {
			do_vcrdat(value);
			return;
		}
		value &= 0xff;
		int adr = (regs[18] << 8) | regs[19];
		if (adr > 0x7ff) {
			--adr;
			updateAttr(adr, value << 8);
		} else {
			int val = ram[adr & 0x7ff];
			int nval = (val & 0xff00) | value;
			updateChar(adr, nval);
		}
		// TODO: is there a way to aggregate on char/attr pair?
		repaint();
	}

	private void paintHighlight(Graphics2D g2d) {
		int x0 = (int)dragStart.getX();
		int y0 = (int)dragStart.getY();
		int x1 = regs[1];
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

	private void paintField(Graphics2D g2d, char[] chrs) {
		int a = (regs[12] << 8) | regs[13];
		int nr = regs[6];
		int nc = regs[1];
		int gx = bd_width;
		int gy = _fa + bd_width;
		for (int y = 0;  y < nr; ++y) {
			if (a + nc > 0x0800) {
				int n = 0x800 - a;
				g2d.drawChars(chrs, a, n, gx, gy);
				g2d.drawChars(chrs, 0, nc - n, gx + _fw * n, gy);
			} else {
				g2d.drawChars(chrs, a, nc, gx, gy);
			}
			a += nc;
			a &= 0x07ff;
			gy += _fh;
		}
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
		paintField(g2d, lines);
		if ((blink & 0x02) != 0) {
			paintField(g2d, blinks);
		}
		g2d.setColor(halfIntensity);
		paintField(g2d, halfint);
		if ((blink & 0x02) != 0) {
			paintField(g2d, halfblnk);
		}
		g2d.setColor(getForeground());
		if (((blink & 0x01) == 0) && curs_on) {
			// TODO: is cursor solid or rev-video?
			g2d.fillRect(curs_x * _fw + bd_width,
				curs_y * _fh + bd_width + curs_s,
				_fw + 1, curs_e - curs_s + 1);
		}
	}

	private String getRegion(Point p0, Point p1) {
		String s = "";
		int x0 = (int)p0.getX();
		int y0 = (int)p0.getY();
		int x1 = regs[1];
		int y1 = (int)p1.getY();
		// TODO: extract character and format into lines...
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
		// TODO: extract character and format into lines...
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
		// TODO: extract character and format into lines...
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
		dragCount = 10;
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

// Copyright (c) 2017 Douglas Miller
import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import java.util.Properties;
import java.util.Vector;
import java.util.Map;
import java.util.HashMap;
import javax.swing.border.*;

class RoundedRectangle extends JPanel {
	static final long serialVersionUID = 198900000003L;

	Color color;
	Color shadow;
	Color highlt;
	int _y, _x;
	float _w;
	Font _font;
	int _arch, _arcw;

	public RoundedRectangle(Color bg, boolean reverse,
			float x, float y, float w, float h,
			float arcw, float arch) {
		if (x == y) {}
		color = bg;
		if (reverse) {
			highlt = bg.darker();
			shadow = bg.brighter();
		} else {
			shadow = bg.darker();
			highlt = bg.brighter();
		}
		_arch = Math.round(arch / 2);
		_arcw = Math.round(arcw);
		_x = Math.round(w);
		_y = Math.round(h);
		setPreferredSize(new Dimension(_x, _y));
		setOpaque(false);
	}

	public void paint(Graphics g) {
		Graphics2D g2d = (Graphics2D)g;
		g2d.addRenderingHints(new RenderingHints(
			RenderingHints.KEY_ANTIALIASING,
			RenderingHints.VALUE_ANTIALIAS_ON));
		g2d.setColor(color);
		g2d.fillRoundRect(0, 0, _x, _y, _arcw, _arcw);
		g2d.setStroke(new BasicStroke(3f, BasicStroke.CAP_BUTT, BasicStroke.JOIN_MITER));
		g2d.setColor(highlt);
		g2d.drawLine(0, _arch, 0, _y - _arch);
		g2d.drawLine(_arch, 0, _x - _arch, 0);
		g2d.drawArc(0, 0, _arcw, _arcw, 180, -90);
		g2d.drawArc(_x - _arcw - 1, 0, _arcw, _arcw, 90, -45);
		g2d.drawArc(0, _y - _arcw - 1, _arcw, _arcw, 180, 45);
		g2d.setColor(shadow);
		g2d.drawLine(_x - 1, _arch, _x - 1, _y - _arch);
		g2d.drawLine(_arch, _y - 1, _x - _arch, _y - 1);
		g2d.drawArc(_x - _arcw - 1, _y - _arcw - 1, _arcw, _arcw, 0, -90);
		g2d.drawArc(_x - _arcw - 1, 0, _arcw, _arcw, 0, 45);
		g2d.drawArc(0, _y - _arcw - 1, _arcw, _arcw, -90, -45);
		super.paint(g2d);
	}
}

class BezelRoundedRectangle extends JPanel {
	static final long serialVersionUID = 198900000003L;
	java.awt.geom.RoundRectangle2D.Float shape;
	Color color;
	Color bezel;
	Color shadow;
	Color highlt;
	int _sy, _sx;
	int _y, _x;
	float _w;
	Font _font;
	int _arch, _arcw;
	Polygon lpoly;
	int _ox, _oy, _ex, _ey;

	public BezelRoundedRectangle(Color bg, Color bez, boolean reverse,
			float x, float y, float w, float h,
			float arcw, float arch) {
		color = bg;
		bezel = bez;
		if (reverse) {
			highlt = bez.darker();
			shadow = bez.brighter();
		} else {
			shadow = bez.darker();
			highlt = bez.brighter();
		}
		_arch = Math.round(arch / 2);
		_arcw = Math.round(arcw);
		_ox = Math.round(x);
		_oy = Math.round(y);
		_ex = Math.round(w);
		_ey = Math.round(h);
		int gap = Math.round(w / 100);
		if (gap < 3) gap = 3;
		_x = gap;
		_y = gap;
		_sx = _ex - 2 * _x;
		_sy = _ey - 2 * _y;
		setPreferredSize(new Dimension(_ex, _ey));
		setOpaque(false);
		lpoly = new Polygon();
		lpoly.addPoint(_ex, 0);
		lpoly.addPoint(_ex, _ey);
		lpoly.addPoint(0, _ey);
		lpoly.addPoint(0 + _arcw, _ey - _arcw);
		lpoly.addPoint(_ex - _arcw, 0 + _arcw);
	}

	public void paint(Graphics g) {
		Graphics2D g2d = (Graphics2D)g;
		g2d.addRenderingHints(new RenderingHints(
			RenderingHints.KEY_ANTIALIASING,
			RenderingHints.VALUE_ANTIALIAS_ON));
		g2d.setColor(highlt);
		g2d.fillRect(_ox, _oy, _ex - _ox, _ey - _oy);
		g2d.setColor(shadow);
		g2d.fillPolygon(lpoly);
		g2d.setColor(bezel);
		g2d.drawLine(_ox, _oy, _ox + _arcw, _oy + _arcw);
		g2d.drawLine(_ex, _ey, _ex - _arcw, _ey - _arcw);
		g2d.setColor(color);
		g2d.fillRoundRect(_x, _y, _sx, _sy, _arcw, _arcw);
		super.paint(g2d);
	}
}

class LEDPane extends JPanel implements MouseListener {
	JMenuItem mnu = null;
	String name;

	public LEDPane(Color bg) {
		super();
		setOpaque(false);
		setBackground(bg);
		addMouseListener(this);
	}

	public void setMenuItem(JMenuItem mi) {
		mnu = mi;
	}

	public void setName(String nm) {
		name = nm;
	}

	public String getName() { return name; }

	public void mouseClicked(MouseEvent e) {
		if (e.getButton() != MouseEvent.BUTTON1) {
			return;
		}
		if (mnu == null) {
			return;
		}
		mnu.doClick();
	}
	public void mouseEntered(MouseEvent e) {
		if (mnu == null) {
			return;
		}
		setOpaque(true);
		repaint();
	}
	public void mouseExited(MouseEvent e) {
		if (mnu == null) {
			return;
		}
		setOpaque(false);
		repaint();
	}
	public void mousePressed(MouseEvent e) { }
	public void mouseReleased(MouseEvent e) { }
}

class KayproPowerLED extends JPanel {
	int height;
	int width;
	int vcenter;
	public KayproPowerLED(int wd, int ht, Font ft) {
		super();
		setPreferredSize(new Dimension(wd, ht));
		setFont(ft);
		setOpaque(false);
		setForeground(Color.white);
		width = wd;
		height = ht;
		vcenter = ht / 2;
	}
	public void paint(Graphics g) {
		super.paint(g);
		Graphics2D g2d = (Graphics2D)g;
		g2d.addRenderingHints(new RenderingHints(
			RenderingHints.KEY_ANTIALIASING,
			RenderingHints.VALUE_ANTIALIAS_ON));
		g2d.drawString("~", 20, vcenter - 20);
		g2d.drawString("POWER", 0, vcenter + 20);
		g2d.setColor(Color.black);
		g2d.fillOval(15, vcenter - 20, 20, 20);
		g2d.setColor(Color.red);
		g2d.fillOval(19, vcenter - 16, 12, 12);
	}
}

class LEDPanel extends JPanel {
	LEDPane[] panes;
	public static final Font font = new Font("Monospaced", Font.BOLD, 16);

	public LEDPanel(int w, int h, int rows, Color bg) {
		super();
		panes = new LEDPane[rows];
		GridBagLayout gb = new GridBagLayout();
		GridBagConstraints gc = new GridBagConstraints();
		gc.fill = GridBagConstraints.NONE;
		gc.gridx = 0;
		gc.gridy = 0;
		gc.weightx = 0;
		gc.weighty = 0;
		gc.gridwidth = 1;
		gc.gridheight = 1;
		setLayout(gb);
		setOpaque(false);
		setPreferredSize(new Dimension(w, h));
		for (int y = 0; y < rows; ++y) {
			LEDPane pn = new LEDPane(bg);
			if (y == 0) {
				pn.setPreferredSize(new Dimension(w, h / 3));
				gb.setConstraints(pn, gc);
				add(pn);
				++gc.gridy;
				KayproPowerLED kp = new KayproPowerLED(w, h / 3, font);
				gb.setConstraints(kp, gc);
				add(kp);
			} else {
				pn.setPreferredSize(new Dimension(w, h / 3 / (rows - 1)));
				gb.setConstraints(pn, gc);
				add(pn);
			}
			panes[y] = pn;
			++gc.gridy;
		}
	}

	public LEDPane getPane(int row) {
		if (row < panes.length) {
			return panes[row]; // should not be null
		} else {
			return null;
		}
	}

	public void putMap(String drive, JMenuItem mi) {
		for (LEDPane pn : panes) {
			if (pn == null) continue;
			if (drive.equals(pn.getName())) {
				pn.setMenuItem(mi);
			}
		}
	}

	public void reFmt(String fmt) {
		for (LEDPane pn : panes) {
			if (pn == null) continue;
			// Component #0 is always the label...
			// But, it might not be there yet...
			int n = pn.getComponentCount();
			if (n < 1) {
				continue;
			}
			JLabel lb = (JLabel)pn.getComponent(0);
			lb.setText(String.format(fmt, lb.getText()));
		}
	}

	public void rePad(int num) {
		++num; // one component is the label...
		for (LEDPane pn : panes) {
			if (pn == null) continue;
			int n = pn.getComponentCount();
			if (n <= 0 || n >= num) continue;
			for (int x = n; x < num; ++x) {
				pn.add(LED.blank());
			}
		}
	}
}

public class KayproFrontSide extends JPanel
		implements LEDHandler {
	static final long serialVersionUID = 198900000004L;

	BezelRoundedRectangle _crtshape;
	LEDPanel _ledspace;
	int _ledy;
	int _ledmax = 1;
	int _ledwid = 5;
	String _ledfmt = "%5s";
	int gaps;
	float rounding;
	int width, height;
	int offset;

	public KayproFrontSide(JFrame main, JPanel crt,
			Properties props) {
		super();
		if (props == null) {}
		setBackground(main.getContentPane().getBackground());
		setOpaque(true);
		Dimension dim = crt.getPreferredSize();
		gaps = dim.width / 50;
		if (gaps < 5) gaps = 5;
		offset = dim.width / 40;
		rounding = offset * 2;
		width = Math.round(dim.width + 2 * offset);
		height = Math.round(dim.height + 2 * offset);

		GridBagLayout gridbag = new GridBagLayout();
		setLayout(gridbag);
		GridBagConstraints gc = new GridBagConstraints();
		gc.fill = GridBagConstraints.NONE;
		gc.gridx = 0;
		gc.gridy = 0;
		gc.weightx = 0;
		gc.weighty = 0;
		gc.gridwidth = 1;
		gc.gridheight = 1;
		gc.anchor = GridBagConstraints.NORTH;
		JPanel pan;
		pan = new JPanel();
		pan.setPreferredSize(new Dimension(gaps, gaps));
		pan.setOpaque(false);
		gc.gridx = 0;
		gc.gridwidth = 5;
		gridbag.setConstraints(pan, gc);
		gc.gridwidth = 1;
		add(pan);
		++gc.gridy;

		pan = new JPanel();
		pan.setPreferredSize(new Dimension(gaps, gaps));
		pan.setOpaque(false);
		gc.gridx = 0;
		gridbag.setConstraints(pan, gc);
		add(pan);

		_crtshape = new BezelRoundedRectangle(crt.getBackground(),
			main.getContentPane().getBackground(), true,
			0f, 0f, width, height,
			rounding, rounding);
		GridBagLayout gb = new GridBagLayout();
		_crtshape.setLayout(gb);
		_crtshape.setOpaque(false);
		gridbag.setConstraints(crt, gc);
		_crtshape.add(crt);
		gc.gridx = 1;
		gridbag.setConstraints(_crtshape, gc);
		add(_crtshape);

		pan = new JPanel();
		pan.setPreferredSize(new Dimension(gaps, gaps));
		pan.setOpaque(false);
		gc.gridx = 2;
		gridbag.setConstraints(pan, gc);
		add(pan);

		int nmwid = width / 3;
		int nmhgh = height;

		// TODO: scan properties and count number of drives?
		_ledspace = new LEDPanel(nmwid - 20, dim.height, 4,
					getBackground().brighter());
		_ledy = 0;
		gc.gridx = 3;
		gridbag.setConstraints(_ledspace, gc);
		add(_ledspace);

		pan = new JPanel();
		pan.setPreferredSize(new Dimension(gaps, gaps));
		pan.setOpaque(false);
		gc.gridx = 4;
		gridbag.setConstraints(pan, gc);
		add(pan);

		++gc.gridy;
		gc.gridx = 0;

		pan = new JPanel();
		pan.setPreferredSize(new Dimension(gaps, gaps));
		pan.setOpaque(false);
		gc.gridwidth = 5;
		gridbag.setConstraints(pan, gc);
		gc.gridwidth = 1;
		add(pan);
	}

	public void setMenuItem(String drive, JMenuItem mi) {
		_ledspace.putMap(drive, mi);
	}

	public LED registerLED(String drive, LED.Colors color) {
		LED led[] = registerLEDs(drive, 1, new LED.Colors[]{color});
		return led[0];
	}

	public LED registerLED(String drive) {
		return registerLED(drive, LED.Colors.RED);
	}

	public LED[] registerLEDs(String drive, int num, LED.Colors[] colors) {
		LED[] leds = new LED[num];
		if (_ledmax < num) {
			_ledmax = num;
			_ledspace.rePad(num);
		}
		if (drive.length() > 20) {
			drive = drive.substring(0, 20);
		}
		if (drive.length() > _ledwid) {
			_ledwid = drive.length();
			_ledfmt = String.format("%%%ds", _ledwid);
			_ledspace.reFmt(_ledfmt);
		}
		LEDPane pn = _ledspace.getPane(_ledy++);
		if (pn != null) {
			pn.setName(drive);
			JLabel lb = new JLabel(String.format(_ledfmt, drive));
			lb.setForeground(Color.white);
			lb.setFont(LEDPanel.font);
			pn.add(lb);
		}
		for (int x = 0; x < num; ++x) {
			leds[x] = new LED(colors[x]);
			if (pn != null) {
				pn.add(leds[x]);
			}
		}
		if (pn != null) {
			for (int x = num; x < _ledmax; ++x) {
				pn.add(LED.blank());
			}
		}
		return leds;
	}
}

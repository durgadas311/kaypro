// Copyright (c) 2017 Douglas Miller
import java.awt.*;
import javax.swing.*;
import java.io.*;
import java.util.Properties;
import java.lang.reflect.Field;
import java.util.Properties;

public class VirtualH89 {
	private static JFrame front_end;

	public static void main(String[] args) {
		java.net.URL url = VirtualH89.class.getResource("VirtualH89.class");
		String jar = "jar:" + url.getFile().replace("VirtualH89.class", "");
		//System.err.println(jar);
		// jar:file:/path/to/jar/H89jni.jar!/

		Properties props = new H19Properties("89");

		String f = "H19a.ttf";
		float fz = 20f;
		Color fc = Color.green;
		String s = props.getProperty("h19_font");
		if (s != null) {
			f = s;
		}
		s = props.getProperty("h19_font_size");
		if (s != null) {
			fz = Float.valueOf(s);
		}
		s = props.getProperty("h19_font_color");
		if (s != null) {
			fc = new Color(Integer.valueOf(s, 16));
		}

		CrtScreen screen = new CrtScreen(fz);
		Font font = null;
		if (f.endsWith(".ttf")) {
			try {
				File ff = new File(f);
				java.io.InputStream ttf;
				if (ff.exists()) {
					ttf = new FileInputStream(ff);
				} else {
					ttf = VirtualH89.class.getResourceAsStream(f);
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
			screen.setISO();
		}
		if (font == null) {
			System.err.println("Missing font \"" +
					f + "\", using default");
			font = new Font("Monospaced", Font.PLAIN, 10);
		}
		screen.setFont(font);
		screen.setForeground(fc);

		front_end = new JFrame("Virtual H89 Computer");
		front_end.getContentPane().setName("H89 Emulator");
		front_end.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		front_end.getContentPane().setBackground(new Color(100, 100, 100));
		// This allows TAB to be sent
		front_end.setFocusTraversalKeysEnabled(false);
		s = props.getProperty("h89_nameplate");
		if (s == null) {
			s =	"<HTML>&nbsp;" +
				"Heathkit H89" +
				"&nbsp;</HTML>";
		}
		LEDHandler lh = null;
		if (s.equals("none")) {
			front_end.add(screen);
		} else {
			s = s.replaceAll("jar:", jar);
			HxxFrontSide front = new HxxFrontSide(front_end, screen, props, s);
			front_end.add(front);
			lh = front;
		}

		H89 h89 = new H89(props, lh);
		// All LEDs should be registered now...
		H89Operator op = new H89Operator(front_end, props, screen, lh);
		op.setCommander(h89.getCommander());

		H19Keyboard kbd = new H19Keyboard(h89.getOutputStream(), false);
		front_end.addKeyListener(kbd);
		screen.setPasteListener(kbd);
		H19Terminal term = new H19Terminal(props, screen, kbd, h89.getInputStream());
		kbd.addResetListener(term);
		kbd.addResetListener(op);

		front_end.pack();
		front_end.setVisible(true);

		h89.start(); // spawns its own thread... returns immediately
		term.run(); // consumes caller's thread... i.e. does not return...
	}
}

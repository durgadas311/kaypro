// Copyright (c) 2017 Douglas Miller
import java.awt.*;
import javax.swing.*;
import java.io.*;
import java.util.Properties;
import java.lang.reflect.Field;
import java.util.Properties;

public class VirtualKaypro {
	private static JFrame front_end;

	public static void main(String[] args) {
		Properties props = new Properties();
		String config;
		config = System.getenv("KAYPRO_CONFIG");
		if (config == null) {
			config = "vkayprorc";
			File f = new File(config);
			if (f.exists()) {
				config = f.getAbsolutePath();
			} else {
				config = System.getProperty("user.home") + "/." + config;
			}
		}
		try {
			FileInputStream cfg = new FileInputStream(config);
			setProperty("configuration", config);
			load(cfg);
			cfg.close();
		} catch(Exception ee) {
			config = null;
		}

		// TODO: configure based on model...
		KayproCrt crt = new Kaypro84Crt(props);
		front_end = new JFrame("Virtual Kaypro Computer");
		front_end.getContentPane().setName("Kaypro Emulator");
		front_end.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		front_end.getContentPane().setBackground(new Color(100, 100, 100));
		// This allows TAB to be sent
		front_end.setFocusTraversalKeysEnabled(false);
		KayproFrontSide front = new KayproFrontSide(front_end, crt, props);
		LEDHandler lh = front;

		Kaypro kaypro = new Kaypro(props, lh, crt);
		// All LEDs should be registered now...
		KayproOperator op = new KayproOperator(front_end, props, crt, lh);
		op.setCommander(kaypro.getCommander());

		front_end.addKeyListener(kaypro.getKeyboard());
		crt.setPasteListener(kaypro.getKeyboard());
		// TODO:
		// kbd.addResetListener(term);
		// kbd.addResetListener(op);

		if (false) {
			front_end.add(crt);
		} else {
			front_end.add(front);
		}

		front_end.pack();
		front_end.setVisible(true);

		kaypro.start(); // spawns its own thread... returns immediately
	}
}

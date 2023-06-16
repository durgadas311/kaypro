// Copyright (c) 2023 Douglas Miller <durgadas311@gmail.com>
import java.awt.*;
import javax.swing.*;
import java.io.*;
import java.util.Properties;
import java.lang.reflect.Field;
import java.util.Properties;

import java.awt.datatransfer.Transferable;
import java.awt.datatransfer.DataFlavor;
import java.awt.event.*;

public class VirtualKeyboard implements MouseListener {
	private static VirtualKeyboard vk;
	private JFrame front_end;
	KayproKeyboard kbd;

	public static void main(String[] args) {
		vk = new VirtualKeyboard(args);
	}

	public VirtualKeyboard(String[] args) {
		Properties props = new Properties();
		String config = null;
		if (args.length > 0) {
			File f = new File(args[0]);
			if (f.exists()) {
				config = f.getAbsolutePath();
			}
		} else {
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
		}
		if (config != null) {
			try {
				FileInputStream cfg = new FileInputStream(config);
				props.setProperty("configuration", config);
				props.load(cfg);
				cfg.close();
			} catch(Exception ee) {
				config = null;
			}
		}
		String title = "Virtual Kaypro Keyboard";

		front_end = new JFrame(title);
		front_end.getContentPane().setName("Kaypro Keyboard Emulator");
		front_end.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		front_end.getContentPane().setBackground(new Color(25, 25, 25));
		// This allows TAB to be sent
		front_end.setFocusTraversalKeysEnabled(false);
		JPanel pn;

		pn = new JPanel();
		pn.setPreferredSize(new Dimension(300, 100));
		pn.add(new JLabel("Kaypro Keyboard Emulator"));
		front_end.add(pn);

		VirtualUART uart = new TtyUART(props);
		kbd = new KayproKeyboard(props, null, uart);
		front_end.addMouseListener(this);
		front_end.addKeyListener(kbd);

		front_end.pack();
		front_end.setVisible(true);
	}

	// MouseListener
	public void mouseClicked(MouseEvent e) {
		if (e.getButton() != MouseEvent.BUTTON2) {
			return;
		}
		Transferable t = Toolkit.getDefaultToolkit().
				getSystemClipboard().getContents(null);
		try {
			if (t != null && t.isDataFlavorSupported(DataFlavor.stringFlavor)) {
				String text = (String)t.getTransferData(DataFlavor.stringFlavor);
				kbd.paste(text);
			}
		} catch (Exception ee) {
		}
	}
	public void mouseEntered(MouseEvent e) { }
	public void mouseExited(MouseEvent e) { }
	public void mousePressed(MouseEvent e) {}
	public void mouseReleased(MouseEvent e) {}
	public void mouseDragged(MouseEvent e) {}
	public void mouseMoved(MouseEvent e) { }
}

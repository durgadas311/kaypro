// Copyright (c) 2016 Douglas Miller <durgadas311@gmail.com>

import java.util.Arrays;
import java.util.Vector;
import java.util.Properties;
import java.io.*;
import java.awt.Font;

public class Diablo630Serial extends InputStream implements Runnable {
	VirtualUART uart;
	String file;
	Diablo630 front_end;

	public Diablo630Serial(Properties props, Vector<String> argv, VirtualUART uart) {
		this.uart = uart;
		file = "out.ps";
		// Defaulting to 10 cpi, 6 lpi...
		front_end = new Diablo630(props, argv, this);
		Thread t = new Thread(this);
		t.start();
		uart.setModem(VirtualUART.SET_CTS | VirtualUART.SET_DSR);
	}

	public int read() {
		while (true) {
			int c = uart.take();
			if ((c & VirtualUART.GET_CHR) == 0) {
				return c;
			}
			// ignore modem control changes...
		}
	}
	public int available() {
		return uart.available();
	}

	public void run() {
		front_end.runPrinter(file);
		System.err.println("Diablo 630 detaching");
	}
}

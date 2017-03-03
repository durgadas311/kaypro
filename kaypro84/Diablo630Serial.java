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
		return uart.take();
	}
	public int available() {
		return uart.available();
	}

	public void run() {
		front_end.runPrinter(file);
		System.err.println("Diablo 630 detaching");
	}
}

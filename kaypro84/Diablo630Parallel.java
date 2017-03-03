// Copyright (c) 2017 Douglas Miller <durgadas311@gmail.com>

import java.util.Arrays;
import java.util.Vector;
import java.util.Properties;
import java.io.*;
import java.awt.Font;

public class Diablo630Parallel extends InputStream implements Runnable {
	VirtualPPort pprt;
	String file;
	Diablo630 front_end;

	public Diablo630Parallel(Properties props, Vector<String> argv, VirtualPPort pprt) {
		this.pprt = pprt;
		file = "out.ps";
		// Defaulting to 10 cpi, 6 lpi...
		front_end = new Diablo630(props, argv, this);
		Thread t = new Thread(this);
		t.start();
	}

	public int read() {
		// We can sleep here...
		return pprt.take(true);
	}
	public int available() {
		return pprt.available();
	}

	public void run() {
		front_end.runPrinter(file);
		System.err.println("Diablo 630 detaching");
	}
}

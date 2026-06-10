// Copyright (c) 2016 Douglas Miller <durgadas311@gmail.com>

import java.util.Arrays;
import java.util.List;
import java.util.Vector;
import java.util.Properties;
import java.io.*;
import java.awt.Font;

public class Diablo630Stream extends OutputStream implements Runnable {
	String file;
	Diablo630 front_end;
	java.util.concurrent.LinkedBlockingDeque<Integer> fifo;

	List<String> boolArgs = Arrays.asList();
	String[] seqArgs = new String[0];

	public Diablo630Stream(Properties props, Vector<String> argv) {
		fifo = new java.util.concurrent.LinkedBlockingDeque<Integer>();
		// argv.get(0) is this class name.
		String[] args = argv.subList(1, argv.size()).toArray(new String[0]);
		Diablo630.processArgs(props, args, boolArgs, seqArgs);
		// everything is now a property...
		file = props.getProperty("diablo630_file");
		if (file == null) {
			file = "out.ps";
		}
		// Defaulting to 10 cpi, 6 lpi...
		front_end = new Diablo630(props, new PrinterInput());
		Thread t = new Thread(this);
		t.start();
	}

	class PrinterInput extends InputStream {
		public int read() {
			try {
				return fifo.take() & 0xff;
			} catch (Exception ee) {
				return -1;
			}
		}
		public int available() {
			return fifo.size();
		}
	}

	public void write(int b) {
		fifo.add(b);
	}

	public void run() {
		front_end.runPrinter(file);
		System.err.println("Diablo 630 detaching");
	}
}

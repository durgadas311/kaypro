// Copyright (c) 2020 Douglas Miller <durgadas311@gmail.com>

import java.util.Arrays;
import java.util.List;
import java.util.Vector;
import java.util.Properties;
import java.io.*;
import java.awt.Font;

public class Diablo630Serial extends InputStream implements SerialDevice, Runnable {
	VirtualUART uart;
	String file;
	Diablo630 front_end;
	java.util.concurrent.LinkedBlockingDeque<Integer> fifo;

	List<String> boolArgs = Arrays.asList();
	String[] seqArgs = new String[0];

	public Diablo630Serial(Properties props, Vector<String> argv, VirtualUART uart) {
		this.uart = uart;
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
		front_end = new Diablo630(props, this);
		Thread t = new Thread(this);
		t.start();
		uart.attachDevice(this);
		uart.setModem(VirtualUART.SET_CTS | VirtualUART.SET_DSR);
	}

	// SerialDevice interface
	public void write(int b) {	// CPU is writing the serial data port
		fifo.add(b); // TODO: limit?
	}
	//public int read();		// CPU is reading the serial data port
	//public int available();	// returns number available bytes on Rx (0/1)
	public void rewind() {}		// If device supports it, restart stream
				// (e.g. rewind cassette tape)
	// bits a la VirtualUART get/setModem()
	public void modemChange(VirtualUART me, int mdm) {
		// ignore modem control outputs?
	}
	public int dir() { return SerialDevice.DIR_OUT; }
	public String dumpDebug() {
		return "";	// TODO: add some debug
	}

	// InputStream interface
	public int read() {
		try {
			int c = fifo.take();
			return c;
		} catch (Exception ee) {
			// ee.printStackTrace();
			return -1;
		}
	}
	public int available() {
		return fifo.size();
	}

	public void run() {
		front_end.runPrinter(file);
		System.err.println("Diablo 630 detaching");
	}
}

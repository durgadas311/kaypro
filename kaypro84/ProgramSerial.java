// Copyright (c) 2017 Douglas Miller <durgadas311@gmail.com>

import java.util.Arrays;
import java.util.Vector;
import java.util.Properties;
import java.io.*;
import java.awt.Font;

public class ProgramSerial extends InputStream implements Runnable {
	VirtualUART uart;
	RunProgram prog;

	public ProgramSerial(String arg, VirtualUART uart) {
		this.uart = uart;
		prog = new RunProgram(arg, this, true);
		if (prog.excp == null) {
			Thread t = new Thread(this);
			t.start();
			// TODO: allow special program codes to change?
			uart.setModem(VirtualUART.SET_CTS | VirtualUART.SET_DSR);
		}
	}

	public int read() {
		return uart.take();
	}
	public int available() {
		return uart.available();
	}

	// This thread reads program stdout and sends to UART
	public void run() {
		while (true) {
			try {
				// This probably needs to be throttled...
				int c = prog.proc.getInputStream().read();
				uart.put(c);
			} catch (Exception ee) {
				ee.printStackTrace();
				break;
			}
		}
	}
}

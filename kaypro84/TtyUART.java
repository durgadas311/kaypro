// Copyright (c) 2023 Douglas Miller <durgadas311@gmail.com>

import java.util.Arrays;
import java.util.Vector;
import java.util.Properties;
import java.io.*;
// See: https://fazecast.github.io/jSerialComm/
// Currently using: jSerialComm-2.6.2.jar
import com.fazecast.jSerialComm.*;

// Provides a conduit between virtual UART and a TTY device.
// Intended use is to attach a TTY in simulators,
// to provide access to a real TTY. Typical usage example (in config file):
//
// tty = /dev/ttyUSB0
// baud = 9600
//
// Requires invoking the simulator with jSerialComm.jar on the classpath,
// which also precludes using the "-jar" option. Typical invocation:
//
// java -cp <sim-jar>:<jSerialComm-jar> sim-class [sim-args...]

public class TtyUART implements VirtualUART, Runnable {
	SerialDevice io;
	Object periph;
	SerialPort comm;
	String tty = null;
	int baud = -1;
	InputStream inp;
	OutputStream out;
	boolean modem = false;
	int mdms = -1;

	public TtyUART(Properties props, String pfx, String[] args) {
		String prefix = "";
		if (pfx != null && pfx.length() > 0) {
			prefix = pfx + "_";
		}
		String s = props.getProperty(prefix + "tty");
		if (s != null) {
			tty = s;
		}
		s = props.getProperty(prefix + "baud");
		if (s != null) {
			baud = Integer.valueOf(s);
		}
		s = props.getProperty(prefix + "modem");
		if (s != null) {
			modem = true;
		}
		for (String arg : args) {
			if (arg.startsWith("tty=")) {
				tty = arg.substring(4);
			} else if (arg.startsWith("baud=")) {
				baud = Integer.valueOf(arg.substring(5));
			} else if (arg.equals("modem")) {
				modem = true;
			}
		}
		if (tty == null) {
			throw new RuntimeException("No valid TTY specified\n");
		}
		if (baud < 0) {
			baud = 300;
		}
		comm = getPort(tty, baud);
		if (comm == null) {
			throw new RuntimeException("TTY not found\n");
		}
		try {
			inp = comm.getInputStream();
			out = comm.getOutputStream();
		} catch (Exception ee) {
			throw ee;
		}
		if (!modem) {
			setModem(VirtualUART.SET_CTS |
					VirtualUART.SET_DSR |
					VirtualUART.SET_DCD);
		} else {
			updateModem();
		}
		Thread t = new Thread(this);
		t.start();
		if (modem) {
			t = new Thread(new ModemControl());
			t.start();
		}
	}

	public String getConfig() {
		return String.format("Port: %s Baud: %d", tty, baud);
	}

	private static SerialPort getPort(String tty, int baud) {
		try {
			SerialPort serialPort = SerialPort.getCommPort(tty);
			if (serialPort == null) {
				return null;
			}
			// TODO: timeout values...
			if (!serialPort.openPort()) {
				return null;
			}
			if (baud > 0) {
				if (!serialPort.setComPortParameters(baud, 8,
							SerialPort.ONE_STOP_BIT,
							SerialPort.NO_PARITY)) {
					serialPort.closePort();
					return null;
				}
			}
			if (!serialPort.setComPortTimeouts(SerialPort.TIMEOUT_READ_BLOCKING,
					0, 0)) {
				serialPort.closePort();
				return null;
			}
			return serialPort;
		} catch (Exception ee) {
			ee.printStackTrace();
			return null;
		}
	}

	// VirtualUART
	public int available() { return 0; }
	public int take() { return 0; }
	public boolean ready() { return true; }
	public void put(int ch, boolean sleep) {
		try {
			out.write(ch);
		} catch (Exception ee) {}
	}
	public void setModem(int mdm) {
		if (!modem) return;
		if ((mdm & VirtualUART.GET_RTS) == 0) {
			comm.clearRTS();
		} else {
			comm.setRTS();
		}
		if ((mdm & VirtualUART.GET_DTR) == 0) {
			comm.clearDTR();
		} else {
			comm.setDTR();
		}
	}
	public int getModem() {
		int mdm = 0;
		if (comm.getCTS()) {
			mdm |= VirtualUART.SET_CTS;
		}
		if (comm.getDSR()) {
			mdm |= VirtualUART.SET_DSR;
		}
		if (comm.getDCD()) {
			mdm |= VirtualUART.SET_DCD;
		}
		if (comm.getRI()) {
			mdm |= VirtualUART.SET_RI;
		}
		return mdm;
	}
	public boolean attach(Object periph) {
		this.periph = periph;
		return true;
	}
	public void detach() {
		this.periph = null;
	}
	public String getPortId() {
		return tty;
	}
	public void attachDevice(SerialDevice io) {
		this.io = io;
	}
	////
	public String dumpDebug() {
		String ret = String.format("%s: %3s %3s %3s %3s %3s %3s\n",
			tty,
			comm.getCTS() ? "CTS" : "cts",
			comm.getDSR() ? "DSR" : "dsr",
			comm.getDCD() ? "DCD" : "dcd",
			comm.getRI()  ? "RI"  : "ri",
			comm.getRTS() ? "RTS" : "rts",
			comm.getDTR() ? "DTR" : "dtr");
		return ret;
	}
	/////////////////////////////

	private void updateModem() {
		int mdm = 0;
		if (comm.getCTS()) {
			mdm |= VirtualUART.SET_CTS;
		}
		if (comm.getDSR()) {
			mdm |= VirtualUART.SET_DSR;
		}
		if (comm.getDCD()) {
			mdm |= VirtualUART.SET_DCD;
		}
		if (comm.getRI()) {
			mdm |= VirtualUART.SET_RI;
		}
		if ((mdms ^ mdm) != 0) {
			mdms = mdm;
			if (io != null) {
				io.modemChange(this, mdm);
			}
		}
	}

	class ModemControl implements Runnable {
		public void run() {
			while (comm != null) {
				updateModem();
				try {
					Thread.sleep(1); // 1mS too short? long?
				} catch (Exception ee) {}
			}
		}
	}

	private void discon() {
		comm.closePort();
		comm = null;
		if (modem) {
			if (io != null) {
				io.modemChange(this, 0);
			}
		}
		detach();
	}

	// This thread reads TTY and sends to UART
	// TODO: how to monitor CTS, DSR, DCD (and RI)?
	public void run() {
		int c;
		while (true) {
			try {
				c = inp.read();
				if (c < 0) {
					break;
				}
				if (io != null) {
					io.write(c);
				}
			} catch (Exception ee) {
				break;
			}
		}
		discon();
	}
}

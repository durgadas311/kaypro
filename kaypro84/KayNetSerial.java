// Copyright (c) 2025 Douglas Miller <durgadas311@gmail.com>

// Usage: xxx_att = KayNetSerial <host> <port> <node-id>
// <node-id> is arbitrary but must be unique. does not relate
// to node id used in ULCNet.

import java.util.Arrays;
import java.util.Vector;
import java.util.Properties;
import java.io.*;
import java.net.*;

public class KayNetSerial implements SerialDevice, ClockListener, Runnable {
	VirtualUART uart;
	String dbg;
	int dtr; // current state of DTR from UART
	int dcd; // current state of DCD to UART
	boolean started;
	int to;	// timeout for driving DCD off last Rx char
	boolean client;

	// if client == false
	ServerSocket listen;
	int nc = 16;
	SocketConnection[] sc;

	// if client == true
	Socket conn;
	InputStream inp;
	OutputStream out;

	// server mode, tracks each client connection
	class SocketConnection implements Runnable {
		public Socket sok;
		public InputStream inp;
		public OutputStream out;
		public String remote;
		public int remPort;
		public int idx;

		public SocketConnection(Socket so, int ix) throws Exception {
			sok = so;
			idx = ix;
			InetAddress ia = so.getInetAddress();
			remote = ia.getCanonicalHostName();
			remPort = so.getPort();
			inp = so.getInputStream();
			out = so.getOutputStream();
			Thread t = new Thread(this);
			t.start();
		}

		private void discon() {
			if (sok == null) {
				return;
			}
			try {
				sok.close();
			} catch (Exception ee) {}
			sok = null;
		}

		public String dumpDebug() {
			String ret;
			if (sok == null) {
				ret = String.format("[%02x] DEAD\n", idx);
			} else {
				ret = String.format("[%02x] %s %d\n",
					idx, remote, remPort);
			}
			return ret;
		}

		public void run() {
			int b;
			while (sok != null) {
				try {
					b = inp.read();
					if (b < 0) {
						discon();
						break;
					}
				} catch (Exception ee) {
					discon();
					break;
				}
				netIn(b, idx);
			}
		}
	}

	public KayNetSerial(Properties props, Vector<String> argv, VirtualUART uart) {
		this.uart = uart;
		if (argv.size() != 3) {
			System.err.format("KayNetSerial: Invalid args\n");
			return;
		}
		String host = argv.get(1);
		int port = Integer.valueOf(argv.get(2));
		dbg = String.format("KayNetSerial %s %d\n", host, port);
		// TODO: configurable number of connections
		InetAddress ia = null;
		try {
			if (host.length() == 0 || host.equals("localhost")) {
				ia = InetAddress.getLocalHost();
			} else {
				ia = InetAddress.getByName(host);
			}
		} catch (Exception ee) {
			System.err.println(ee.getMessage());
			return;
		}
		try {
			listen = new ServerSocket(port, nc, ia);
			client = false;
		} catch (IOException ee) { // TODO: if address already bound?
			try {
				conn = new Socket(ia, port);
				inp = conn.getInputStream();
				out = conn.getOutputStream();
				client = true;
			} catch (Exception eee) {
				System.err.println(eee.getMessage());
				return;
			}
		} catch (Exception ee) {
			ee.printStackTrace();
			return;
		}
		if (!client) {
			sc = new SocketConnection[nc];
		}
		uart.attachDevice(this);
		int mdm = uart.getModem();
		dtr = (mdm & VirtualUART.GET_DTR) == 0 ? 0 : 1;
		setDCD(1);
		Kaypro.getInterruptor().addClockListener(this);
		Thread t = new Thread(this);
		t.start();
	}

	// broadcast character/handshake on network.
	// exclude connection index 'xcl'
	private void bcast(int b, int xcl) {
		for (int x = 0; x < nc; ++x) {
			if (sc[x] == null) continue;
			if (sc[x].sok == null) {
				sc[x] = null;
				continue;
			}
			if (x == xcl) continue;
			try {
				sc[x].out.write(b);
			} catch (Exception ee) { }
		}
	}

	private void rxChar(int b) {
		uart.put(b, false);
		if (!started) {
			started = true;
			setDCD(0);
		}
		synchronized(this) {
			to = 200;
		}
	}

	// character arrived from UART.
	private void lclChar(int b) {
		// TODO: this does not get corrupted by collision... fix it
		rxChar(b); // echo immediately, to meet timing
		if (dtr == 0) {
			return;
		}
		if (client) {
			// client mode: just send upstream
			try {
				out.write(b);
			} catch (Exception ee) {}
			return;
		}
		// server mode: send to ALL connections.
		bcast(b, -1);
	}

	// set local DCD according to 'l'
	private void setDCD(int l) {
		dcd = l;
		if (l == 0) {
			uart.setModem(VirtualUART.SET_CTS |
				VirtualUART.SET_DSR);
		} else {
			uart.setModem(VirtualUART.SET_CTS |
				VirtualUART.SET_DSR |
				VirtualUART.SET_DCD);
		}
	}

	// client action incoming from network.
	// process character/handshake locally (on UART)
	private void lclAction(int b) {
		rxChar(b);
	}

	// server receive DAT on a socket
	private void netIn(int b, int ix) {
		rxChar(b);
		bcast(b, ix); // exclude sender, they echo locally
	}

	///////////////////////////
	// ClockListener interface:
	//
	public void addTicks(int ticks, long clk) {
		if (to > 0) {
			synchronized(this) {
				to -= ticks;
			}
			if (to <= 0) {
				started = false;
				setDCD(1);
			}
		}
	}

	///////////////////////////
	// SerialDevice interface:
	//
	public void write(int b) {
		lclChar(b);
	}

	// This should not be used...
	// We push received data from the thread...
	public int read() {
		if (conn == null) {
			return -1;
		}
		// prevent blocking? needed?
		try {
			if (inp.available() < 1) return 0;
			return inp.read();
		} catch (Exception ee) {
			return -1;
		}
	}

	// Not used...
	public int available() {
		if (conn == null) {
			return 0;
		}
		try {
			return inp.available();
		} catch (Exception ee) {
			return -1;
		}
	}

	public void rewind() {}

	// This must NOT call uart.setModem() (or me...)
	public void modemChange(VirtualUART me, int mdm) {
		int l = (mdm & VirtualUART.GET_DTR) == 0 ? 0 : 1;
		if (dtr == l) {
			return;
		}
		dtr = l;
		if (dtr == 0) {
			started = false;
		}
	}
	public int dir() { return SerialDevice.DIR_OUT; }

	public String dumpDebug() {
		String ret = dbg;
		ret += String.format("DTR=%s DCD=%d started=%s to=%d\n",
				dtr, dcd, started, to);
		if (client) {
			if (conn != null) {
				ret += "CONNECTED\n";
			} else {
				ret += "not connected\n";
			}
		} else {
			if (listen != null) {
				ret += "Listening...\n";
			} else {
				ret += "DEAD.\n";
			}
			for (int x = 0; x < nc; ++x) {
				if (sc[x] == null) continue;
				ret += sc[x].dumpDebug();
			}
		}
		return ret;
	}
	/////////////////////////////

	// client mode connection fail
	private void cltDiscon() {
		if (conn == null) {
			return;
		}
		try {
			conn.close();
		} catch (Exception ee) {}
		conn = null;
	}

	private void tryConn(Socket nc) {
		int x;
		int n;
		for (x = 0; x < this.nc && sc[x] != null && sc[x].sok != null; ++x);
		if (x >= this.nc) {
			try {
				nc.close();
			} catch (Exception ee) { }
			return;
		}
		try {
			sc[x] = new SocketConnection(nc, x);
		} catch (Exception ee) {
			ee.printStackTrace();
		}
	}

	public void run() {
		if (client) {
			int b;
			while (conn != null) {
				try {
					b = inp.read();
					if (b < 0) {
						cltDiscon();
						break;
					}
					lclAction(b);
				} catch (Exception ee) {
					cltDiscon();
					break;
				}
			}
		} else {
			Socket rem;
			while (listen != null) {
				try {
					rem = listen.accept();
					tryConn(rem);
				} catch (Exception ee) {
					System.err.println(ee.getMessage());
					listen = null;
					break;
				}
			}
		}
		uart.attachDevice(null);
		uart.detach();
	}
}

// Copyright (c) 2025 Douglas Miller <durgadas311@gmail.com>

// Usage: xxx_att = KayNetSerial <host> <port> <node-id>
// <node-id> is arbitrary but must be unique. does not relate
// to node id used in ULCNet.

// All socket communications is in byte-pairs, to facilitate OOB.
// First byte of pair is NID, DTR, DCD, or DAT. Second is the data/operand.

import java.util.Arrays;
import java.util.Vector;
import java.util.Properties;
import java.io.*;
import java.net.*;

public class KayNetSerial implements SerialDevice, Runnable {
	static final byte NID = (byte)0xff;
	static final byte SOM = (byte)0xfe; // client is starting send
	static final byte EOM = (byte)0xfd; // client send finished
	static final byte DAT = (byte)0;

	VirtualUART uart;
	String dbg;
	int dtr; // current state of DTR in UART
	boolean started;
	boolean client;

	// if client == false
	ServerSocket listen;
	int nc = 16;
	SocketConnection[] sc;
	int active;
	int actIdx;
	boolean collision;

	// if client == true
	Socket conn;
	InputStream inp;
	OutputStream out;
	int nid;

	// server mode, tracks each client connection
	class SocketConnection implements Runnable {
		public Socket sok;
		public InputStream inp;
		public OutputStream out;
		public int nid;
		public String remote;
		public int remPort;
		public int idx;
		public int dtr; // current state of DTR in remote UART

		public SocketConnection(Socket so, int ni, int ix) throws Exception {
			sok = so;
			nid = ni;
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
				ret = String.format("[%02x] DEAD\n", nid);
			} else {
				ret = String.format("[%02x] %s %d dtr=%d\n",
					nid, remote, remPort, dtr);
			}
			return ret;
		}

		public void run() {
			int n;
			byte[] bb = new byte[2];
			while (sok != null) {
				try {
					n = inp.read(bb);
					if (n != 2) {
						discon();
						break;
					}
				} catch (Exception ee) {
					discon();
					break;
				}
				if (bb[0] == SOM) {
					som(idx);
				} else if (bb[0] == EOM) {
					eom(idx);
				} else if (bb[0] == DAT) {
					netIn(bb, idx);
				}
			}
		}
	}

	public KayNetSerial(Properties props, Vector<String> argv, VirtualUART uart) {
		this.uart = uart;
		if (argv.size() != 4) {
			System.err.format("KayNetSerial: Invalid args\n");
			return;
		}
		String host = argv.get(1);
		int port = Integer.valueOf(argv.get(2));
		nid = Integer.decode(argv.get(3));
		dbg = String.format("KayNetSerial %s %d 0x%02x\n", host, port, nid);
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
				byte[] bb = new byte[]{ NID, (byte)nid };
				out.write(bb);
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
		Thread t = new Thread(this);
		t.start();
	}

	// broadcast character/handshake on network.
	// exclude connection index 'xcl'
	private void bcast(byte[] bb, int xcl) {
		for (int x = 0; x < nc; ++x) {
			if (sc[x] == null) continue;
			if (sc[x].sok == null) {
				sc[x] = null;
				continue;
			}
			if (x == xcl) continue;
			try {
				sc[x].out.write(bb);
			} catch (Exception ee) { }
		}
	}

	// character arrived from UART.
	private void lclChar(int b) {
		// TODO: this does not get corrupted by collision... fix it
		uart.put(b, false); // echo immediately, to meet timing
		byte[] bb = new byte[2];
		if (!started) {
			started = true;
			if (client) {
				bb[0] = SOM;
				try {
					out.write(bb);
				} catch (Exception ee) {}
			} else {
				som(-1);
			}
		}
		bb[0] = DAT;
		bb[1] = (byte)b;
		if (client) {
			// client mode: just send upstream
			try {
				out.write(bb);
			} catch (Exception ee) {}
			return;
		}
		// server mode: handles collisions.
		// broadcast on network but also echo back to UART.
		if (collision) {
			bb[1] = (byte)0;
		}
		// send to ALL connections.
		bcast(bb, -1);
	}

	// set local DCD according to 'l'
	private void setDCD(int l) {
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
	private void lclAction(byte[] bb) {
		if (bb[0] == SOM) {
			setDCD(0);
		} else if (bb[0] == EOM) {
			setDCD(1);
		} else if (bb[0] == DAT) {
			uart.put(bb[1] & 0xff, false);
		} else {
			// protocol/sync error
		}
	}

	// server receive DAT on a socket
	private void netIn(byte[] bb, int ix) {
		if (active > 1) { // collision
			bb[1] = (byte)0;
		}
		bcast(bb, ix); // exclude sender, they echo locally
		uart.put(bb[1] & 0xff, false);
	}

	// Start Of Message - only called in server
	private void som(int ix){
		boolean first = false;
		synchronized(this) {
			first = (active == 0);
			if (first) {
				actIdx = ix;
			}
			++active;
		}
		if (first) {
			byte[] bb = new byte[]{ SOM, 0 };
			bcast(bb, ix); // exclude sender, they handled
		}
	}

	// End Of Message - only called in server
	private void eom(int ix){
		boolean last = false;
		synchronized(this) {
			if (active == 0) {
				//System.err.format("active ref undeflow\n");
				return;
			}
			--active;
			last = (active == 0);
			if (last) {
				actIdx = -1;
			}
		}
		if (last) {
			byte[] bb = new byte[]{ EOM, 0 };
			bcast(bb, ix); // exclude sender, they handled
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
			if (client) {
				byte[] bb = new byte[]{ EOM, (byte)dtr };
				try {
					out.write(bb); // propagate to network
				} catch (Exception ee) {}
			} else {
				eom(-1);
			}
		}
	}
	public int dir() { return SerialDevice.DIR_OUT; }

	public String dumpDebug() {
		String ret = dbg;
		ret += String.format("DTR=%s started=%s\n", dtr, started);
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
			ret += String.format("active: refs=%d idx=%d\n",
				active, actIdx);
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

	// Should not get here unless conn == null...
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
		byte[] bb = new byte[2];
		try {
			n = nc.getInputStream().read(bb);
			if (n != 2) {
				try { nc.close(); } catch (Exception eee) { }
				return;
			}
		} catch (Exception ee) {
			ee.printStackTrace();
			try { nc.close(); } catch (Exception eee) { }
			return;
		}
		if (bb[0] != NID) {
			// protocol/sync error...
			try {
				nc.close();
			} catch (Exception eee) {}
			return;
		}
		try {
			sc[x] = new SocketConnection(nc, bb[1] & 0xff, x);
			// client sends it's own DTR, normal channels
		} catch (Exception ee) {
			ee.printStackTrace();
		}
	}

	private boolean _debug = false;

	// This thread reads socket and sends to UART
	// When disconnected, just quit and go back to listening mode...
	public void run() {
		if (client) {
			byte[] bb = new byte[2];
			int n;
			while (conn != null) {
				try {
					n = inp.read(bb);
					if (n != 2) {
						cltDiscon();
						break;
					}
					lclAction(bb);
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

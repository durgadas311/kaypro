// Copyright (c) 2017 Douglas Miller <durgadas311@gmail.com>

public interface VirtualUART {
	static final int SET_CTS = 0x01; // Settable and Readable
	static final int SET_DSR = 0x02; // Settable and Readable
	static final int SET_DCD = 0x04; // Settable and Readable
	static final int SET_RI  = 0x08; // Settable and Readable
	static final int GET_RTS = 0x10; // Readable
	static final int GET_DTR = 0x20; // Readable
	static final int GET_OT1 = 0x40; // Readable
	static final int GET_OT2 = 0x80; // Readable
	int available();	// Num bytes available from UART Tx.
	int take();		// Get byte from UART Tx, possibly sleep.
	boolean ready();	// Can UART Rx accept byte without overrun?
	void put(int ch);	// Put byte into UART Rx.
	void setModem(int mdm);	// Change Modem Control Lines in to UART.
	int getModem();		// Get all Modem Control Lines for UART.
}

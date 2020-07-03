// Copyright (c) 2020 Douglas Miller <durgadas311@gmail.com>

public interface VirtualPPort {
	// deprecated, "passive", interface
	int available();	// Num bytes available from Port
	int take(boolean sleep); // Get byte from Port (allow sleep)
	boolean ready();	// Port accepting input
	void put(int ch, boolean sleep);	// Send byte to port input
	
	// new "active" interface
	void poke(int val, int msk);	// active input(s) changed
	boolean attach(PPortDevice periph);
	void detach();		// Peripheral no longer usable
}

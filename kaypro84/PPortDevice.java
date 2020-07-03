// Copyright (c) 2020 Douglas Miller <durgadas311@gmail.com>

public interface PPortDevice {
	void refresh();		// poke any passive inputs
	boolean ready();	// ready for output?
	void outputs(int val);	// outputs have changed
}

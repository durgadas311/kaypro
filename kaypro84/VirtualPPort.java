// Copyright (c) 2017 Douglas Miller <durgadas311@gmail.com>

public interface VirtualPPort {
	int available();	// Num bytes available from Port
	int take();		// Get byte from Port
}

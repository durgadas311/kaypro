// Copyright (c) 2017 Douglas Miller <durgadas311@gmail.com>

public interface InterruptController {
	int readDataBus(); // return -1 if no interrupt pending (for this device).
}

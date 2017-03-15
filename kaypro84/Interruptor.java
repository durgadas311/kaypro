// Copyright (c) 2017 Douglas Miller <durgadas311@gmail.com>

public interface Interruptor {
	enum Model { UNKNOWN,
			K2X,	// aka 2/84
			K84,	// aka 4/84
			K4X,
			KROBIE,
			K10,
			K10X,	// aka "10 W/MODEM and CLOCK"
			K2XX,	// aka "2X W/MODEM and CLOCK"
			K12X,
			K84E,	// K2X + 256K RAM, RTC
			K10E,	// K10 + 256K RAM, RTC
	};
	int registerINT(int irq);
	void raiseINT(int irq, int src);
	void lowerINT(int irq, int src);
	void blockInts(int mask);
	void unblockInts(int mask);
	void setNMI(boolean state);	// As implemented by Kaypro
	void triggerNMI();		// Not used/available for Kaypro
	void addClockListener(ClockListener lstn);
	void addIntrController(InterruptController ctrl);
	void waitCPU();
	boolean isTracing();
	void startTracing();
	void stopTracing();
	Model getModel();
}

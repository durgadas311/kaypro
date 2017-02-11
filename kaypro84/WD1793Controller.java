// Copyright (c) 2017 Douglas Miller <durgadas311@gmail.com>

// The interface used by a WD1797 to assert signals to the disk controller board.
public interface WD1797Controller {
	void raisedIntrq();
	void raisedDrq();
	void loweredIntrq();
	void loweredDrq();
	void loadedHead(boolean load);
	boolean doubleDensity();
	int getClockPeriod();
	GenericFloppyDrive getCurDrive();
}

// Copyright (c) 2017 Douglas Miller <durgadas311@gmail.com>

import java.util.Arrays;
import java.util.Vector;
import java.util.Properties;
import java.awt.event.*;
import javax.swing.*;

public class ParallelPrinter
		implements IODevice, GppListener, VirtualPPort {
	static final int ctrl_PRSTB_c = 0x08;
	static final int ctrl_PRBSY_c = 0x40;	// "1" == "Busy"

	private int data;
	private boolean strobe;
	private boolean busy;

	public ParallelPrinter(Properties props, SystemPort gpio) {
		strobe = false; // actually, must follow GPIO...
		gpio.addGppListener(this);
		// gpio.addGppSource(this); // TODO: create this interface
		// TODO: scan properties for attached device
		reset();
	}

	public int getBaseAddress() { return 0x18; }
	public int getNumPorts() { return 4; }

	public void reset() {
		data = 0;
		busy = false;
	}

	public int in(int addr) {
		// not possible
		return 0;
	}

	public void out(int addr, int val) {
		data = val;
	}

	public String getDeviceName() {
		return "ParallelPrinter";
	}

	public int interestedBits() {
		return ctrl_PRSTB_c;
	}

	// TODO: create this interface...
	public int gppRead(int val) {
		return (val & ~ctrl_PRBSY_c) | (busy ? ctrl_PRBSY_c : 0);
	}

	public void gppNewValue(int gpio) {
		// Must only latch strobe, attached device resets it...
		if ((gpio & ctrl_PRSTB_c) == 0) {
			strobe = true;
			// TODO: activate strobe signal to attached device...
		}
	}

	public int available() {
		return (strobe ? 1 : 0);
	}

	public int take() {
		int val = data;
		strobe = false;
		return val;
	}

	public String dumpDebug() {
		String ret = String.format(
			"DAT=%02x\n" +
			"STB=%s BSY=%s\n",
			data,
			Boolean.toString(strobe), Boolean.toString(busy));
		return ret;
	}
}

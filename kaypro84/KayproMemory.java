// Copyright (c) 2017 Douglas Miller <durgadas311@gmail.com>

import java.util.Properties;

public class KayproMemory extends KayproRoms implements Memory, GppListener {
	SystemPort gpp;
	// One single bank of 64K, plus ROMs...
	private byte[] mem;
	private boolean rom;

	public KayproMemory(Properties props, SystemPort gpio) {
		super(props);
		gpp = gpio;
		// rely entirely on notifications for 'rom' value.
		gpp.addGppListener(this);
		mem = new byte[65536];
	}

	public int read(int address) {
		address &= 0xffff; // necessary?
		if (rom && address < 0x8000) {
			if (address <= monMask) {
				return mon[address] & 0xff;
			}
			return 0;
		}
		return mem[address & 0xffff] & 0xff;
	}
	public void write(int address, int value) {
		if (rom && address < 0x8000) {
			// TODO: what did the Kaypro do in this case?
			return;
		}
		mem[address & 0xffff] = (byte)(value & 0xff);
	}

	public void reset() {}

	public int interestedBits() { return 0x80; }
	public void gppNewValue(int gpio) {
		rom = ((gpio & 0x80) != 0);
	}
}

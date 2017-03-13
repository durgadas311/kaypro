// Copyright (c) 2017 Douglas Miller <durgadas311@gmail.com>

public class GenericFloppyDrive implements GenericDiskDrive {

	public enum DriveType {
		FDD_NULL,
		FDD_5_25_SS_ST,
		FDD_5_25_SS_DT,
		FDD_5_25_DS_ST,
		FDD_5_25_DS_DT,
		FDD_8_SS,
		FDD_8_DS,
	};

	private int numTracks_m;
	private int numHeads_m;
	private int driveRpm_m;
	private int mediaSize_m;
	private int rawSDBytesPerTrack_m;
	private long ticksPerSec_m;
	private long ticksPerRev_m;
	private long ticksPerIndex_m;
	private long ticksPerSector_m; // 0 == soft sectored
	private long ticksPerByte;
	private long cycleCount_m;
	private long indexCharPos;
	private long sectorCharPos;
	private int currSector_m; // always 0 if soft sectored
	private boolean indexPulse_m;

	private GenericFloppyDisk disk_m;
	private int headSel_m;
	private int track_m;
	private boolean motor_m;
	private boolean head_m;
	private String name;

	public GenericFloppyDrive(DriveType type, String name) {
		this.name = name;
		disk_m = null;
		// Can this change on-the-fly?
		ticksPerSec_m = 2048000; // TODO: abstract this

		if (type == DriveType.FDD_5_25_DS_ST || type == DriveType.FDD_5_25_DS_DT || type == DriveType.FDD_8_DS) {
			numHeads_m = 2;
		} else {
			numHeads_m = 1;
		}
		if (type == DriveType.FDD_8_SS || type == DriveType.FDD_8_DS) {
			numTracks_m = 77;
			mediaSize_m = 8;
			driveRpm_m = 360;
			rawSDBytesPerTrack_m = 6400;
		} else {
			mediaSize_m = 5;
			driveRpm_m = 300;
			rawSDBytesPerTrack_m = 3200;

			if (type == DriveType.FDD_5_25_SS_DT || type == DriveType.FDD_5_25_DS_DT || type == DriveType.FDD_8_DS) {
				numTracks_m = 80;
			} else {
				numTracks_m = 40;
			}
		}
		cycleCount_m = 0;
		ticksPerRev_m = (ticksPerSec_m * 60) / driveRpm_m;
		// The index jacket hole is about 10 degrees wide on 8" disk...
		// Assuming media hole is about 1/2 = 4740 cycles (H89).
		// The index jacket hole is about 12-15 degrees wide on 5" disk...
		// Assuming media hole is about 1/2 = 6800-7900 cycles.
		// Approximating 5 degrees all media types should be fine.
		ticksPerIndex_m = (ticksPerRev_m / 360) * 5;
		ticksPerSector_m = 0; // soft sectored until we know different
		headSel_m = 0;
		track_m = 0;
		motor_m = (mediaSize_m == 8);
		head_m = (mediaSize_m == 5);
	}

	static public GenericFloppyDrive getInstance(String type, String name) {
		DriveType etype;

		if (type.equals("FDD_5_25_SS_ST")) {
			etype = DriveType.FDD_5_25_SS_ST;
		} else if (type.equals("FDD_5_25_SS_DT")) {
			etype = DriveType.FDD_5_25_SS_DT;
		} else if (type.equals("FDD_5_25_DS_ST")) {
			etype = DriveType.FDD_5_25_DS_ST;
		} else if (type.equals("FDD_5_25_DS_DT")) {
			etype = DriveType.FDD_5_25_DS_DT;
		} else if (type.equals("FDD_5_25_DS_QT")) {
			// TODO: DriveTec two-speed, 192-tpi drives...
			return null;
		} else if (type.equals("FDD_8_SS")) {
			etype = DriveType.FDD_8_SS;
		} else if (type.equals("FDD_8_DS")) {
			etype = DriveType.FDD_8_DS;
		} else {
			return null;
		}
		return new GenericFloppyDrive(etype, name.replaceAll(" ", "_"));
	}

	public void insertDisk(GenericFloppyDisk disk) {
		if (disk_m != null) {
			disk_m.eject("replaced");
		}
		if (disk == null) {
			disk_m = null;
			return;
		}
		if (getMediaSize() != disk.mediaSize()) {
			System.err.format("Media wrong size for drive: %s\n",
					disk.getMediaName());
			return;
		}
		disk_m = disk;
		int hs = disk_m.hardSectored();
		ticksPerByte = ticksPerRev_m / disk_m.trackLen();
		if (hs <= 0) {
			ticksPerSector_m = 0;
			return;
		}
		// The rest only applies to hard-sectored diskettes
		ticksPerSector_m = ticksPerRev_m / hs;
	}

	public boolean getTrackZero() {
		return track_m == 0;
	}

	public void step(boolean directionIn) {
		if (directionIn) {
			// In... towards hub, ++track
			if (track_m < numTracks_m - 1) {
				++track_m;
			}
		} else {
			// Out... away from hub, --track
			if (track_m > 0) {
				--track_m;
			}
		}
	}

	public void selectSide(int side) {
		headSel_m = side % numHeads_m;
	}

	// negative data is "missing clock" detection.
	public int readData(boolean dd, int track, int side, int sector,
								int inSector) {
		int data = 0;
		boolean verify = (sector < 0xf0);
		if (side < 0) {
			side = headSel_m;
		}

		if (disk_m == null) {
			return GenericFloppyFormat.ERROR;
		}
		if (dd != disk_m.doubleDensity()) {
			return GenericFloppyFormat.ERROR;
		}
		if (verify && (track_m != track || headSel_m != side)) {
			// keep silent as this happens when checking "half track" mode.
			//System.err.format("mismatch trk %d:%d sid %d:%d\n", track_m, track,
			//	headSel_m, side);
			return GenericFloppyFormat.ERROR;
		}
		// override FDC track/side with our own - it's the real one
		if (currSector_m > 0) {
			sector = currSector_m - 1;
		}
		data = disk_m.readData(track_m, headSel_m, sector, inSector);
		if (data == GenericFloppyFormat.NO_DATA) {
			// failures?
		}
		return data;
	}

	int writeData(boolean dd, int track, int side, int sector,
					int inSector, int data, boolean dataReady) {
		int result = GenericFloppyFormat.ERROR;
		boolean verify = (sector < 0xf0);
		if (side < 0) {
			side = headSel_m;
		}

		if (disk_m == null) {
			return GenericFloppyFormat.ERROR;
		}
		if (sector == 0xff) {
			// pass density hint to diskette...
			if (!dd) {
				sector &= ~1;
			}
		} else if (dd != disk_m.doubleDensity()) {
			return GenericFloppyFormat.ERROR;
		}
		if (verify && (track_m != track || headSel_m != side)) {
			return GenericFloppyFormat.ERROR;
		}

		// override FDC track/side with our own - it's the real one
		if (currSector_m > 0) {
			sector = currSector_m - 1;
		}
		result = disk_m.writeData(track_m, headSel_m, sector,
				inSector, data, dataReady);
		if (result == GenericFloppyFormat.ERROR) {
			// failures?
		}
		return result;
	}

	public void addTicks(int cycleCount, long clk) {
		if (disk_m == null || !motor_m) {
			return;
		}
		cycleCount_m += cycleCount;
		cycleCount_m %= ticksPerRev_m;
		indexPulse_m = (cycleCount_m < ticksPerIndex_m);
		indexCharPos = cycleCount_m / ticksPerByte;
		if (ticksPerSector_m == 0) {
			return;
		}
		long hsc = (cycleCount_m - (ticksPerSector_m / 2));
		if (hsc < 0) {
			hsc += ticksPerRev_m;
		}
		// Problem, index pulse is in the middle of the "last" sector,
		// so we need to avoid splitting sector data between end and
		// beginning of track. But, we only use the ticks to compute sector number,
		// so placement of data on disk/buffer is not tied to that.
		int hsi = (int)(hsc % ticksPerSector_m);
		if (!indexPulse_m) {
			indexPulse_m = (hsi < ticksPerIndex_m);
		}
		currSector_m = (int)(hsc / ticksPerSector_m) + 1; // 1 - N
		sectorCharPos = hsi / ticksPerByte;
	}

	public long getCharPos(boolean doubleDensity) {
		// if disk_m == null || !motor_m then cycleCount_m won't be updating
		// and so CharPos also does not update.  Callers checks this.
		long p = indexCharPos;
		if (disk_m == null) {
			return p;
		}
		if (doubleDensity && !disk_m.doubleDensity()) {
			p *= 2;
		}
		if (!doubleDensity && disk_m.doubleDensity()) {
			p /= 2;
		}
		return p;
	}

	public long getSectorPos(boolean doubleDensity) {
		// For soft-sectored disks, returns an un-changing number.
		long p = sectorCharPos;
		if (disk_m == null) {
			return p;
		}
		if (doubleDensity && !disk_m.doubleDensity()) {
			p *= 2;
		}
		if (!doubleDensity && disk_m.doubleDensity()) {
			p /= 2;
		}
		return p;
	}

	// Caller of this must not inspect sector number!
	// Use readData(..., 0xfd, ...) for that.
	// (Except hard-sectored controllers)
	public int[] readAddress() {
		if (disk_m == null || !motor_m) {
			return null;
		}
		// For now, just report what we think is there.
		// TODO: consult media to see if it knows.
		int[] ret = new int[3];
		ret[0] = track_m;
		if (currSector_m > 0) {
			// Hard sectored disks are always 0-based?
			ret[1] = currSector_m - 1;
		} else {
			ret[1] = 0;
		}
		ret[2] = headSel_m;
		return ret;
	}

	public void headLoad(boolean load) {
		if (mediaSize_m == 8) {
			head_m = load;
		}
	}

	public void motor(boolean on) {
		if (mediaSize_m == 5) {
			motor_m = on;
		}
	}

	public boolean isReady() {
		return motor_m && disk_m != null && disk_m.isReady();
	}

	public boolean isWriteProtect() {
		return disk_m == null || disk_m.checkWriteProtect();
	}

	public String getMediaName() {
		return disk_m != null ? disk_m.getMediaName() : "";
	}

	public boolean getIndexPulse() { return indexPulse_m; }
	public int getRawBytesPerTrack() { return rawSDBytesPerTrack_m; }

	public int getNumTracks() { return numTracks_m; }
	public int getNumHeads() { return numHeads_m; }
	public int getMediaSize() { return mediaSize_m; }
	public boolean isRemovable() { return true; }

	public String getDriveName() {
		return name;
	}
}

// Copyright 2017 Douglas Miller <durgadas311@gmail.com>
import java.io.*;
import javax.swing.*;

public class vdiff {
	static JFrame frame;

	public static void main(String[] args) {
		if (args.length != 2) {
			System.err.format("Usage: vdiff <file1> <file2>\n");
			return;
		}
		RandomAccessFile f1;
		RandomAccessFile f2;
		try {
			f1 = new RandomAccessFile(args[0], "r");
			f2 = new RandomAccessFile(args[1], "r");
		} catch (Exception ee) {
			System.err.format("%s\n", ee.getMessage());
			return;
		}
		frame = new VisualDiff(f1, f2);
	}
}

// Copyright 2017 Douglas Miller <durgadas311@gmail.com>
import java.io.*;
import java.awt.*;
import java.util.Arrays;
import javax.swing.*;

public class VisualDiff extends JFrame {
	private RandomAccessFile file1;
	private RandomAccessFile file2;
	private long maxLen;
	private int boxHorz;
	private int boxVert;
	private long curStart;
	private long curLen;
	private int[] boxes;

	public VisualDiff(RandomAccessFile f1, RandomAccessFile f2) {
		super("Visual Binary Diff");
		file1 = f1;
		file2 = f2;
		long l1 = 0, l2 = 0;
		try {
			l1 = f1.length();
			l2 = f2.length();
		} catch (Exception ee) {
		}
		if (l1 > l2) {
			maxLen = l1;
		} else {
			maxLen = l2;
		}
		// TODO: add menus...
		boxHorz = 16;
		boxVert = 10;
		boxes = new int[boxHorz * boxVert];
		Arrays.fill(boxes, 0);
		curStart = 0;
		curLen = maxLen;
		computeDiff();

		add(new DiffPanel());
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		pack();
		setVisible(true);
		repaint();
	}

	private void computeDiff() {
		int n = boxHorz * boxVert;
		long bytes = (curLen + n - 1) / n;
		byte[] buf1 = new byte[(int)bytes];
		byte[] buf2 = new byte[(int)bytes];
		long pos = curStart;
		int box = 0;
		while (pos < curStart + curLen) {
			try {
				file1.read(buf1);
				file2.read(buf2);
				if (Arrays.equals(buf1, buf2)) {
					boxes[box] = 1;
				} else {
					boxes[box] = 2;
				}
			} catch (Exception ee) {
				boxes[box] = -1;
			}
			++box;
			pos += bytes;
		}
	}

	class DiffPanel extends JPanel {
		public DiffPanel() {
			setOpaque(true);
			setPreferredSize(new Dimension(1024, 640));
		}

		public void paint(Graphics g) {
			super.paint(g);
			Graphics2D g2d = (Graphics2D)g;
			for (int by = 0; by < boxVert; ++by) {
				for (int bx = 0; bx < boxHorz; ++bx) {
					switch(boxes[by * boxHorz + bx]) {
					case -1:
						g2d.setColor(Color.red);
						break;
					case 1:
						g2d.setColor(Color.green);
						break;
					case 2:
						g2d.setColor(Color.yellow);
						break;
					default:
						g2d.setColor(Color.black);
						break;
					}
					g2d.fillRect(bx * 64, by * 64, 64, 64);
				}
			}
		}
	}
}

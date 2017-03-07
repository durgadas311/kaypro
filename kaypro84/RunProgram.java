// Copyright (c) 2011,2017 Douglas Miller

import java.io.*;
import java.util.Arrays;

public class RunProgram implements Runnable {
	private static boolean _cygwin;
	private static String[] _shell;
	private static boolean _windows;

	public Process proc = null;
	public Exception excp = null;

	private InputStream stdin;

	static {
		_cygwin = false;
		_windows = (System.getProperty("os.name").indexOf("Windows") >= 0);
		if (_windows) {
			File shell = new File("c:\\cygwin64\\bin\\bash.exe");
			if (!shell.exists()) {
				shell = new File("c:\\cygwin32\\bin\\bash.exe");
			}
			if (!shell.exists()) {
				shell = new File("c:\\cygwin\\bin\\bash.exe");
			}
			if (shell.exists()) {
				_shell = new String[]{ shell.getAbsolutePath(),
						"--login", "-i", "-c" };
				_cygwin = true;
				_windows = false; // for all intents and purposes?
			} else {
				_shell = new String[]{ "cmd.exe", "/c" };
			}
		} else {
			String sh = System.getenv("SHELL");
			if (sh == null) {
				// what else to do?
				_shell = new String[]{ "sh", "-c" };
			} else {
				_shell = new String[]{ sh, "-c" };
			}
		}
	}

	public static boolean isWindows() { return _windows; }

	// start command and return handle
	public RunProgram(String cmd, InputStream in, boolean merge) {
		stdin = in;
		try {
			String[] args = Arrays.copyOf(_shell, _shell.length + 1);
			args[_shell.length] = cmd;
			ProcessBuilder pcmd = new ProcessBuilder(args);
			pcmd.redirectErrorStream(merge);
			proc = pcmd.start();
			Thread t = new Thread(this);
			t.start();
		} catch(Exception ee) {
			excp = ee;
		}
	}

	// This thread reads the "UART" and sends to program stdin
	public void run() {
		while (true) {
			try {
				int c = stdin.read();
				proc.getOutputStream().write(c);
				proc.getOutputStream().flush();
			} catch (Exception ee) {
				ee.printStackTrace();
				break;
			}
		}
	}
}

// Copyright (c) 2026 Douglas Miller
import java.awt.event.*;

public interface Keyboard extends PasteListener, KeyListener {
	void setPasteRate(int cps, int cr);
	void paste(String s);
}

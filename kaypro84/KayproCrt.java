// Copyright (c) 2017 Douglas Miller <durgadas311@gmail.com>

import java.awt.*;

public abstract class KayproCrt extends JPanel
		implements IODevice, ScreenDumper {
	abstract void setPasteListener(PasteListener lstn);
}

# kaypro

Kaypro simulator and other related Kaypro items.

This includes the Emergency Debug Monitor, which is designed to (temporarily) replace
the system's boot ROM and allow debugging/diagnosing of issues using a serial port.
See [Emergency ROM documentation](rom/doc/monitor.pdf).

The simulator should not require building from source. The JAR file, and related files,
are generally available [here](http://sebhc.durgadas.com/kaypro/).

-   kaypro84/ - simulator source for all Kaypro models (not just /84)

-   rom/ - Emergency Monitor ROM sourse code. for diagnosing real Kaypros, also memory test.

-   sound/ - files used to recreate Kaypro keyboard "beep"

-   configs - simulator config files for various models

-   disks - Kaypro disk images addapted for use with simulator

-   doc - misc info on Kaypro software/hardware

-   images - a collection of snapshots of my 2X and other Kaypro hardware

-   kermit - Kermit, with configuration for Kaypro

-   kicad - Schematics (ram256K modification, Kaypro-10 WD1002 interface)

-   cpm - CP/M 3 source code for ram256K mod

-   urom - copy of Kaypro UROM source code

-   util - works in progress

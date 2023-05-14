# Makefile for Kaypro custom ROMs.
# "monitor" is a simple, serial-port-based, debug monitor

all: ../bin/monitor.bin

../bin/monitor.bin: monitor.asm
	zmac --dri -i -8 -c -s -n --od . --oo cim,lst monitor.asm
	cp monitor.cim $@
	cp monitor.lst ../prn

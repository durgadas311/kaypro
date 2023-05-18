# Makefile for Kaypro custom ROMs.
# "monitor" is a simple, serial-port-based, debug monitor

DOCS = ../doc/monitor.pdf
BINS = ../bin/monitor.bin ../bin/memtest.bin
all: $(BINS)

../bin/%.bin: %.asm
	zmac --dri -i -8 -c -s -n --od . --oo cim,lst $*.asm
	cp $*.cim $@
	cp $*.lst ../prn

ship: all
	rsync -Wuv $(BINS) $(DOCS) durgadas.com:/var/www/html/sebhc/kaypro

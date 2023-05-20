# Makefile for Kaypro custom ROMs.
# "monitor" is a simple, serial-port-based, debug monitor
#
# To flash 28C64B using minipro:
#	minipro -p "AT28C64B" -s -w monitor.bin 
# read-back for verify, etc.
#	minipro -p "AT28C64B" -r junk

DOCS = ../doc/monitor.pdf
BINS = ../bin/monitor.bin ../bin/mon2k.bin ../bin/memtest.bin
all: $(BINS)

mon2k.asm: monitor.asm
	sed -e '/^rom2k/s/0/-1/' $< >$@

../bin/%.bin: %.asm
	zmac --dri -i -8 -c -s -n --od . --oo cim,lst $*.asm
	cp $*.cim $@
	cp $*.lst ../prn

ship: all
	rsync -Wuv $(BINS) $(DOCS) durgadas.com:/var/www/html/sebhc/kaypro

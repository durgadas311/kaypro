# Make Kaypro "UROM" 81-478

export CPMDrive_D = $(PWD)
export CPMDefault = d:

all: 81-478.rom

ROMREL = \
	urom.rel \
	sgnon.rel \
	hxlate.rel \
	sets.rel \
	getbuf.rel \
	lines.rel \
	pixel.rel \
	chario.rel \
	newcio.rel \
	bufmgr.rel \
	iss.rel \
	cdisp.rel \
	intini.rel \
	select.rel \
	video.rel \
	lrw.rel \
	bootsys.rel \
	winio.rel \
	flpyio.rel \
	devinit.rel \
	kbdini.rel \
	diskinit.rel

%.rel: %.mac
	vcpm m80 d:=d:$?

rels: $(ROMREL)

# Not working...
#	zmac --od . -z -i -c -s -n --rel $?
#	ld80 -O bin -o $@ -P 0 -D 0xf748 $(ROMREL)

81-478.rom: $(ROMREL)
	vcpm urom

clean:
	rm -f *.lst *.rel

syncdown:
	unix2cpm -s ~/git/kaypro/urom/*.mac ~/git/kaypro/urom/*.lib .

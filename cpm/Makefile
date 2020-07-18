# Assumes PWD = CPMDrive_D

export CPMDrive_D = $(PWD)
export CPMDefault = d:

SRCS = $(wildcard *.asm)
RELS = $(subst .asm,.rel,$(SRCS))

BASE = mbios3kp.rel centr.rel crt.rel serial.rel keybd.rel \
	getdp3kp.rel end.rel scb.rel

# TODO: make work with setup30...
K10DRVS = -d a:50,b:51,c:33
K10MODS = -m "33=dds,mdd,mds"
K2XDRVS = -d a:33,b:34
K2XMODS = -m "33=dds,mdd,mds;34=dds,mdd,mds"
DSO = -p def,a:

all: c3k2x.sys c3k10.sys

%.rel: %.asm
	vcpm rmac "$?" '$$SZLA'

ldcpm3.com: ldcpm3.asm
	vcpm mac ldcpm3.asm '$$SZLA'
	vcpm hexcom ldcpm3

b3k2x.spr: $(BASE) fdc3kp.rel lptbl2x.rel
	vcpm link "b3k2x=mbios3kp,fdc3kp,crt,keybd,centr,serial,end,lptbl2x,getdp3kp,scb[b,os,nr]"
#	setup30 $(K2XDRVS) $(K2XMODS) $(DSO) $@

b3k10.spr: $(BASE) win3kp.rel fdc3kp.rel lptbl10.rel
	vcpm link "b3k10=mbios3kp,win3kp,fdc3kp,crt,keybd,centr,serial,end,lptbl10,getdp3kp,scb[b,os,nr]"
#	setup30 $(K10DRVS) $(K10MODS) $(DSO) $@

c3%.sys: b3%.spr
	cp $? bnkbios3.spr
	cp gc.$*.dat gencpm.dat
	vcpm gencpm a d
	mv cpm3.sys $@

.PRECIOUS: %.rel

syncdown:
	unix2cpm -s ~/git/kaypro/cpm/*.asm .

syncup:
#	rsync -Wurv --existing . ~/git/MmsCpm3/sys/kaypro/bin/.
#	rsync -Wurv --existing . ~/git/MmsCpm3/sys/kaypro/prn/.
#	rsync -Wuv gc.*.dat ~/git/MmsCpm3/sys/kaypro/bld/

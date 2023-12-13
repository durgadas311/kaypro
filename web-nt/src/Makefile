# Build for WEB-NT disassembled source

all: web-ii.com web-10.com

web-%.com: web.%.cim osovl.%.cim
	cat web.$*.cim osovl.$*.cim >$@

web.ii.cim: web.asm
	zmac --dri -i -8 -c -s -n --od . --oo cim,lst $<
	mv web.cim $@
	mv web.lst web.ii.lst

web.10.cim: web.asm
	zmac -DK10 --dri -i -8 -c -s -n --od . --oo cim,lst $<
	mv web.cim $@
	mv web.lst web.10.lst

osovl.ii.cim: osovl.asm
	zmac --dri -i -8 -c -s -n --od . --oo cim,lst $<
	mv osovl.cim $@
	mv osovl.lst osovl.ii.lst

osovl.10.cim: osovl.asm
	zmac -DK10 --dri -i -8 -c -s -n --od . --oo cim,lst $<
	mv osovl.cim $@
	mv osovl.lst osovl.10.lst

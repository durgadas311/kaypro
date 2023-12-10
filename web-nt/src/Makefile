# Build for WEB-NT disassembled source

all: web-ii.com web-10.com

web-%.com: web-%.cim osovl-%.cim
	cat web-$*.cim osovl-$*.cim >$@

web-%.cim: web-%.asm
	zmac --dri -i -8 -c -s -n --od . --oo cim,lst $<

osovl-%.cim: osovl-%.asm
	zmac --dri -i -8 -c -s -n --od . --oo cim,lst $<

; serial-port ROM monitor/boot for debugging Kaypro.
; Uses "aux serial" a.k.a "Serial Printer" port.

VERN	equ	027h	; ROM version

rom2k	equ	0

 if rom2k
romsiz	equ	0800h	; space for 2716 ROM
 else
romsiz	equ	1000h	; minimum space for ROM
 endif

	maclib	z80

false	equ	0
true	equ	not false

	$*macro

CR	equ	13
LF	equ	10
CTLC	equ	3
BEL	equ	7
TAB	equ	9
BS	equ	8
ESC	equ	27
TRM	equ	0
DEL	equ	127

; WD1943 at 5.0688MHz...
B9600	equ	0eh
B300	equ	05h
; */84 (and 10) sysport drive select
DS0	equ	0010b
DS1	equ	0001b
DSNONE	equ	0011b	; also mask
K84MTR	equ	00010000b	; */84 (10) MOTOR control, 1=ON
K83PPS	equ	00010000b	; */83 ParPrt strobe (normally 0)
K84CCG	equ	01000000b	; */84 (10) CharGen A12
K83MTR	equ	01000000b	; */83 MOTOR control, 1=OFF

sio1	equ	04h	; "serial data", "keyboard"
sio2	equ	0ch	; "serial printer", "modem"
brd1	equ	00h
brd2	equ	08h

sioA	equ	00h	; offsets
sioB	equ	01h

sioD	equ	00h	; offsets
sioC	equ	02h

; Choose Z80SIO port to use...
condat	equ	sio1+sioA+sioD
conctl	equ	sio1+sioA+sioC
conbrr	equ	brd1

kbddat	equ	sio1+sioB+sioD
kbdctl	equ	sio1+sioB+sioC
kbdbrr	equ	0ch	; */83 uses WD1943, else hardwired to 300 baud

crtctl	equ	1ch	; */84 and 10 only
crtdat	equ	1dh	; */84 and 10 only
crtram	equ	1fh	; also accesses CRTC

sysp84	equ	14h	; sysport on */84 (and 10). */83 have nothing here.

fpysts	equ	10h
fpycmd	equ	10h
fpytrk	equ	11h
fpysec	equ	12h
fpydat	equ	13h

hdddat	equ	80h
hdderr	equ	81h
hddcnt	equ	82h
hddsec	equ	83h
hddclo	equ	84h
hddchi	equ	85h
hddsdh	equ	86h
hddcmd	equ	87h

stack	equ	00000h	; stack at top of memory (wrapped)

; Defined entry points:
; 0003: conout, C=char
; 000B: hexout, A=value
; 0013: msgprt, HL=string (NUL)
; 001B: crlf
; 0023: (reserved)
; 002B: (reserved)
; 0033:	sample I/O port C, initial val B, A=max (returns DE)
; 003B: dump samples 8000H to DE

; Start of ROM code
	org	00000h
reset:	jmp	init
	jmp	conout	; 0003: conout, C=char
	db	0ffh,0ffh

rst1:	jmp	swtrap
	jmp	hexout	; 000B:
	db	0ffh,0ffh

rst2:	jmp	swtrap
	jmp	msgprt	; 0013:
	db	0ffh,0ffh

rst3:	jmp	swtrap
	jmp	crlf	; 001B:
	db	0ffh,0ffh

rst4:	jmp	swtrap
	jmp	swtrap	; 0023:
	db	0ffh,0ffh

rst5:	jmp	swtrap
	jmp	swtrap	; 002B:
	db	0ffh,0ffh

rst6:	jmp	swtrap
	jmp	xsamp1	; 0033: sample a port
	db	0ffh,0ffh

rst7:	jmp	swtrap
	jmp	ysamp	; 003B: dump samples
	db	0ffh,0ffh

	; NMI needed for FLPY testing

swt:	db	CR,LF,'*** RST ',TRM

swtrap:	di		; try to recover return address...
	pop	d	; should be caller of RST...
	lxi	sp,stack
	push	d	; not needed?
	lxi	h,swt
	call	msgprt
	pop	d
	call	taddr
	call	crlf
	jmp	debug

	rept	0066h-$
	db	0ffh
	endm
 if $ <> 0066h
	.error	'NMI overflow'
 endif
nmi:	ret

sioini:	db	18h	; reset
	db	4,044h	; 16x, 1s, Np
	db	3,0c1h	; 8b, RxEn
	db	5,0eah	; DTR, 8b, TxEn, RTS
	db	1,000h	;
siolen	equ	$-sioini

; ROM start point - initialize everything
; We know we have 64K RAM...
init:	di
	lxi	sp,stack

	; init serial port
	mvi	a,B9600
	out	conbrr
	lxi	h,sioini
	mvi	c,conctl
	mvi	b,siolen
	outir

	lxi	h,signon
	call	msgprt

	call	proginit
	jmp	debug

belout:
	mvi	c,BEL
; Output char to console
; C=char
conout:
	in	conctl
	ani	00000100b
	jrz	conout
	mov	a,c
	out	condat
	ret

prompt:	db	CR,LF,': ',TRM

; Get char from console
; Returns: A=char, stripped
conin:	push	h
ci2:	lxi	h,0
ci0:	in	conctl		; 11
	ani	00000001b	;  7
	jrnz	ci1		;  7
	dcx	h		;  6
	mov	a,l		;  4
	ora	h		;  4
	jrnz	ci0		; 12 = 51 (12.75uS) (~0.8 sec)
	call	progress	; on */83 (20.4uS or ~1.3 sec)
	jr	ci2
ci1:	in	condat
	ani	07fh
	pop	h
	ret

; Get char from console, toupper and echo
conine:
	call	conin
	call	toupper
	push	psw
	mov	c,a
	call	conout
	pop	psw
	ret

signon:	db	CR,LF,'Kaypro'
 if rom2k
	db	'-II'
 endif
	db	' Monitor v'
vernum:	db	(VERN SHR 4)+'0','.',(VERN AND 0fh)+'0'
	db	CR,LF,TRM

errm:	db	CR,LF,BEL,'?',TRM

*********************************************************
**  Debug mode
*********************************************************

debug:
cilp:	lxi	sp,stack
	lxi	h,cilp		;setup return address
	push	h
	lxi	h,prompt	;prompt for a command
	call	msgprt
	call	linein		;wait for command line to be entered
	call	progoff		; turn off progress indicators
	lxi	d,line
	call	char		;get first character
	rz			;ignore line if it is empty
	lxi	h,comnds	;search table for command character
	mvi	b,ncmnds	;(number of commands)
cci0:	cmp	m		;search command table
	inx	h
	jrz	gotocmd		;command was found, execute it
	inx	h		;step past routine address
	inx	h
	djnz	cci0		;loop untill all valid commands are checked
error:	lxi	h,errm		;if command unknown, beep and re-prompt
	jmp	msgprt

gotocmd:
	push	d		;save command line buffer pointer
	mov	e,m		;get command routine address
	inx	h
	mov	d,m		;DE = routine address
	xchg			;HL = routine address
	pop	d		;restore buffer pointer
	pchl			;jump to command routine

; All commands are started with DE=next char in line buffer
comnds:
	db	'?'
	dw	Qcomnd
	db	'D'
	dw	Dcomnd
	db	'S'
	dw	Scomnd
	db	'G'
	dw	Gcomnd
	db	'M'
	dw	Mcomnd
	db	'F'
	dw	Fcomnd
	db	'I'
	dw	Icomnd
	db	'O'
	dw	Ocomnd
	db	'H'
	dw	Hcomnd
	db	'N'
	dw	Ncomnd
	db	'T'
	dw	Tcomnd
	db	'V'
	dw	Vcomnd
ncmnds	equ	($-comnds)/3

*********************************************************
**  Command subroutines
*********************************************************

menu:
	db	CR,LF,'D <start> <end> - display memory in HEX'
	db	CR,LF,'S <start> - set/view memory'
	db	CR,LF,'    (CR) = skip fwd, ''-'' = skip bkwd, ''.'' = done'
	db	CR,LF,'G <start> - go to address'
	db	CR,LF,'F <start> <end> <data> - fill memory'
	db	CR,LF,'M <start> <end> <dest> - Move data'
	db	CR,LF,'I <port> [num] - Input from port'
	db	CR,LF,'O <port> <value> [...] - Output to port'
	db	CR,LF,'H - Hexload program'
	db	CR,LF,'N <hw> - iNitialize hardware (KB83'
 if not rom2k
	db		', KB84, CRTC, HDD'
 endif
	db		')'
	db	CR,LF,'T <hw> - Test hardware'
	db	CR,LF,'  (KBD'
 if not rom2k
	db		', CRTC, VRT, CRTR, CRTF, HDD, HDRD'
 endif
	db		', FDRD, FLPY)'
	db	CR,LF,'V - Show ROM version'
	db	CR,LF,'^C aborts command entry'
	db	TRM

Qcomnd:
	lxi	h,menu
	call	msgprt
	ret

Mcomnd:	call	getaddr
	jc	error
	bit	7,b
	jnz	error
	shld	addr0
	call	getaddr
	jc	error
	bit	7,b
	jnz	error
	shld	addr1
	call	getaddr
	jc	error
	bit	7,b
	jnz	error
	xchg
	lbcd	addr0
	lhld	addr1
	ora	a
	dsbc	b
	jc	error
	inx	h
	mov	c,l
	mov	b,h
	push	d
	xchg
	dad	b
	pop	d
	jc	error
	lhld	addr1
	call	check
	jc	mc0
	lhld	addr0
	call	check
	jnc	mc0
	lhld	addr1
	xchg
	dad	b
	dcx	h
	xchg
	lddr
	ret
mc0:	lhld	addr0
	ldir
	ret
Fcomnd:
	call	getaddr ;get address to start at
	jc	error	;error if non-hex character
	bit	7,b	;test for no address (different from 0000)
	jnz	error	;error if no address was entered
	shld	addr0	;save starting address
	call	getaddr ;get stop address
	jc	error	;error if non-hex character
	bit	7,b	;test for no entry
	jnz	error	;error if no stop address
	shld	addr1	;save stop address
	call	getaddr ;get fill data
	jc	error	;error if non-hex character
	bit	7,b	;test for no entry
	jnz	error	;error if no fill data
	mov	a,h
	ora	a
	jnz	error
	mov	c,l	;(C)=fill data
	lhld	addr1	;get stop address
	lded	addr0	;get start address
fc0:	mov	a,c	;
	stax	d	;put byte in memory
	inx	d	;step to next byte
	mov	a,d	;
	ora	e	;if we reach 0000, stop. (don't wrap around)
	rz		;
	call	check	;test for past stop address
	rc	;quit if past stop address
	jr	fc0

Dcomnd:		;display memory
	call	getaddr ;get address to start at
	jc	error	;error if non-hex character
	bit	7,b	;test for no address (different from 0000)
	jnz	error	;error if no address was entered
	shld	addr0	;save starting address
	call	getaddr ;get stop address
	jc	error	;error if non-hex character
	bit	7,b	;test for no entry
	jnz	error	;error if no stop address
	lded	addr0	;get start address into (DE)
dis0:	call	crlf	;start on new line
	call	taddr	;print current address
	call	space	;delimit it from data
	mvi	b,16	;display 16 bytes on each line
dis1:	ldax	d	;get byte to display
	inx	d	;step to next byte
	call	hexout	;display this byte in HEX
	call	space	;delimit it from others
	mov	a,d
	ora	e	;if we reach 0000, stop. (don't wrap around)
	jrz	dis2
	call	check	;test for past stop address
	jrc	dis2	;quit if past stop address
	djnz	dis1	;else do next byte on this line
dis2:	call	space	;delimit it from data
	call	space
	lded	addr0
	mvi	b,16	;display 16 bytes on each line
dis3:	ldax	d	;get byte to display
	inx	d	;step to next byte
	mvi	c,'.'
	cpi	' '
	jrc	dis4
	cpi	'~'+1
	jrnc	dis4
	mov	c,a
dis4:	call	conout
	mov	a,d
	ora	e	;if we reach 0000, stop. (don't wrap around)
	rz
	call	check	;test for past stop address
	rc	;quit if past stop address
	djnz	dis3	;else do next byte on this line
	sded	addr0
	jr	dis0	;when line is finished, start another

Scomnd: 		;substitute (set) memory
	call	getaddr ;get address to start substitution at
	jc	error	;error if non-hex character
	bit	7,b	;test for no entry
	jnz	error	;error if no address
	xchg		;put address in (DE)
sb1:	call	crlf	;start on new line
	call	taddr	;print address
	call	space	;and delimit it
	ldax	d	;get current value of byte
	call	hexout	;and display it
	call	space	;delimit it from user's (posible) entry
	mvi	b,0	;zero accumilator for user's entry
sb2:	call	conine	;get user's first character
	cpi	CR	;if CR then skip to next byte
	jrz	foward
	cpi	' '	;or if Space then skip to next
	jrz	foward
	cpi	'-'	;if Minus then step back to previous address
	jrz	bakwrd
	cpi	'.'	;if Period then stop substitution
	rz
	call	hexcon	;if none of the above, should be HEX digit
	jrc	error0	;error if not
	jr	sb3	;start accumilating HEX digits
sb0:	call	hexcon	;test for HEX digit
	jrc	error1	;error if not HEX
sb3:	slar	b	;roll accumilator to receive new digit
	slar	b
	slar	b
	slar	b
	ora	b	;merge in new digit
	mov	b,a
sb4:	call	conine	;get next character
	cpi	CR	;if CR then put existing byte into memory
	jrz	putbyte ;  and step to next.
	cpi	'.'
	rz
	cpi	del	;if DEL then restart at same address
	jrz	sb1
	jr	sb0	;else continue entering hex digits
putbyte:
	mov	a,b	;store accumilated byte in memory
	stax	d
foward:
	inx	d	;step to next location
	jr	sb1	;and allow substitution there

bakwrd:
	dcx	d	;move address backward one location
	jr	sb1

error0:	call	belout	;user's entry was not valid, beep and continue
	jr	sb2
error1:	call	belout	;same as above but for different section of routine
	jr	sb4

Gcomnd: 		;jump to address given by user
	call	getaddr ;get address to jump to
	jc	error	;error if non-hex character
	bit	7,b	;test for no entry
	jnz	error	;error if no address entered
	call	crlf	;on new line,
	mvi	c,'G'	;display "GO aaaa?" to ask
	call	conout	;user to verify that we should
	mvi	c,'O'	;jump to this address (in case user
	call	conout	;made a mistake we should not blindly
	call	space	;commit suicide)
	xchg
	call	taddr
	call	space
	mvi	c,'?'
	call	conout
	call	conine	;wait for user to type "Y" to
	cpi	'Y'	;indicate that we should jump.
	rnz		;abort if response was not "Y"
	call	crlf	; visual feedback
	xchg
	pchl		;else jump to address

inpms:	db	CR,LF,'Input ',TRM
Icomnd:
	call	getaddr ;get port address, ignore extra MSDs
	jc	error	;error if non-hex character
	bit	7,b	;test for no entry
	jnz	error	;error if no address entered
	push	h	; save port
	call	getaddr	; hex number of inputs to do
	jc	error
	bit	7,b
	jrz	ic0
	lxi	h,1
ic0:
	xthl		; save count
	push	h	; re-save port
	lxi	h,inpms
	call	msgprt
	pop	h
	push	h
	mov	a,l
	call	hexout
	call	space
	mvi	c,'='
	call	conout
	; "Input XX ="
	pop	b	; port to BC
	pop	h	; count to HL (L)
	mvi	h,16-3
	mvi	b,0	; safety
	push	b	; C gets trashed by conout
ic1:
	call	space
	pop	b
	push	b
	inp	a
	call	hexout
	dcr	l	; assume <= 256
	jrz	ic2
	dcr	h	; col count
	jrnz	ic1
	call	crlf
	mvi	h,16
	jr	ic1
ic2:
	pop	b	; fix stack
	call	crlf
	ret

; TODO: no feedback?
Ocomnd:
	call	getaddr ;get port address, ignore extra MSDs
	jc	error	;error if non-hex character
	bit	7,b	;test for no entry
	jnz	error	;error if no address entered
	mvi	h,0	; safety
	push	h	; save port
	call	getaddr ;get value, ignore extra MSDs
	jc	error	;error if non-hex character
	bit	7,b	;test for no entry
	jnz	error	;error if no value entered
	call	crlf
oc0:		; L has byte to output...
	pop	b	; port
	push	b
	outp	l
	call	getaddr ;get value, ignore extra MSDs
	jc	error	;error if non-hex character
			;NOTE: some output has been sent
	bit	7,b	;test for no entry
	jrz	oc0	;still more to send
	pop	h	; discard port
	ret

skb:	call	char
	rz		;end of buffer/line before a character was found (ZR)
	cpi	' '	;skip all leading spaces
	rnz		;if not space, then done (NZ)
	jr	skb	;else if space, loop untill not space

Ncomnd:
	call	skb	; skip blanks
	jz	error	; required param
	; this may need refinement
	dcx	d
	lxi	h,kb83
	call	strcmp
	jrz	nkb83
 if not rom2k
	lxi	h,kb84
	call	strcmp
	jrz	nkb84
	lxi	h,crtc
	call	strcmp
	jrz	ncrtc
	lxi	h,hdd
	call	strcmp
	jrz	nhdd
 endif
	jmp	error

kb83:	db	'KB83',TRM
 if not rom2k
kb84:	db	'KB84',TRM
crtc:	db	'CRTC',TRM
crtr:	db	'CRTR',TRM
crtf:	db	'CRTF',TRM
vrt:	db	'VRT',TRM
hdd:	db	'HDD',TRM
hdrd:	db	'HDRD',TRM
 endif
fdrd:	db	'FDRD',TRM
flpy:	db	'FLPY',TRM
kbd:	db	'KBD',TRM

nkb83:	mvi	a,B300
	out	kbdbrr	; */83 baud gen for SIO1 ch B
nkb84:	lxi	h,sioini
	mvi	c,kbdctl
	mvi	b,siolen
	outir
	ret

 if not rom2k
ncrtc:	lxi	h,crtini
	mvi	c,crtdat	; */84 CRTC 6545 data port
	mvi	b,16
	xra	a	; start with reg 00
nc0:	dcr	c
	outp	a	; select reg
	inr	a	; ++reg
	inr	c	;
	outi
	jrnz	nc0
	mvi	a,31	; R31 enables CRTC
	out	crtctl
	ret

crtini:	db	6ah,50h,56h,99h,19h,0ah,19h,19h,78h,0fh,60h,0fh,00h,00h,00h,00h

nhdd:	in	sysp84
	setb	1,a
	out	sysp84	; MR on (if not already)
	; need 50mS... 200000 cycles or 7693 loops
	lxi	h,10000
nh0:	dcx	h	;  6
	mov	a,h	;  4
	ora	a	;  4
	jrnz	nh0	; 12 = 26 cycles
	call	crlf
	in	sysp84
	res	1,a
	out	sysp84	; MR off
	mvi	c,hddcmd
	mvi	b,0	; assume starting status
	jmp	thdd1
 endif

; if match, return DE after last match.
; if no match, return original DE.
strcmp:	push	d
	xra	a
sc0:	cmp	m	; TRM?
	jrz	sc9	; A = 0
	ldax	d
	sub	m
	jrnz	sc8	; A is NZ
	inx	h
	inx	d
	jr	sc0
sc9:	inx	sp	; non-destructive POP
	inx	sp
	xra	a	; A=0 and ZR
	ret
sc8:	pop	d	; restore orig location
	ora	a
	ret

Tcomnd:
	call	skb	; skip blanks
	jz	error	; required param
	; this may need refinement
	dcx	d
	lxi	h,kbd
	call	strcmp
	jz	tkbd
 if not rom2k
	lxi	h,crtc
	call	strcmp
	jrz	tcrtc
	lxi	h,vrt
	call	strcmp
	jz	tvrt
	lxi	h,crtr
	call	strcmp
	jz	tcrtr
	lxi	h,crtf
	call	strcmp
	jz	tcrtf
	lxi	h,hdd
	call	strcmp
	jz	thdd
	lxi	h,hdrd
	call	strcmp
	jz	thdrd
 endif
	lxi	h,fdrd
	call	strcmp
	jz	tfdrd
	lxi	h,flpy
	call	strcmp
	jz	tflpy
	jmp	error

 if not rom2k
tcrtc:	lxi	h,waitm
	call	msgprt
	mvi	b,5	; count
	mvi	e,80h	; compare
tc5:	mvi	a,31
	out	crtctl	; select reg
tc0:	in	crtctl
	ani	80h
	cmp	e
	jrz	tc9
	in	conctl
	ani	00000001b
	jrnz	tc6
	mov	a,e
	ora	a
	jrnz	tc0
	in	crtram	; clear Update
	jr	tc5
tc6:	in	condat
	lxi	h,abrtm
	call	msgprt
	ret
tc9:	mov	a,e
	xri	80h
	mov	e,a
	jrnz	tc8
	lxi	h,updtm
	call	msgprt
	in	crtram	; clear Update
	djnz	tc5
	ret
tc8:	call	space
	djnz	tc0
	ret
 endif

tkbd:	lxi	h,waitm
	call	msgprt
tk0:	in	kbdctl
	ani	00000001b
	jrnz	tk1
	in	conctl
	ani	00000001b
	jrz	tk0
	in	condat
	lxi	h,abrtm
	call	msgprt
	ret
tk1:	in	kbddat
	call	hexout
	call	space
	jr	tk0

waitm:	db	CR,LF,'Wait... ',TRM
abrtm:	db	'Abort',TRM
 if not rom2k
updtm:	db	'Update',TRM

tvrt:	mvi	a,10	; we don't need many samples
	sta	addr1
	call	crlf
	mvi	c,crtctl
	inp	b
	; TODO: reset Update bit? optionally?
	call	xsamp
	jmp	ysamp

pass:	db	'Passed',TRM
fail:	db	'Failed ',TRM

tcrtr:	; test read/write of CRTC cursor register pair
	call	crlf
	lxi	h,0
	mvi	c,crtdat
tr0:	mvi	a,14	; R14 = cursor hi
	out	crtctl
	outp	h
	inr	a
	out	crtctl
	outp	l
	dcr	a
	out	crtctl
	inp	d
	inr	a
	out	crtctl
	inp	e
	; now compare HL:DE
	mov	a,l
	cmp	e
	jrnz	tr9
	mov	a,h
	cmp	d
	jrnz	tr9
	inx	h
	mov	a,h
	ani	3fh
	mov	h,a
	ora	l
	jrnz	tr0
	lxi	h,pass
	call	msgprt
	ret
tr9:	push	d
	push	h
	lxi	h,fail
	call	msgprt
	pop	d
	call	taddr
	call	space
	pop	d
	call	taddr
	ret

; Fill video RAM will value
tcrtf:
	mvi	a,' '
	sta	addr0	; default to blanks
	xra	a
	sta	addr1	; default to no attributes
	call	getaddr ;get optional fill byte
	jc	error	;error if non-hex character
	bit	7,b	;test for no entry
	jrnz	tcfX
	mov	a,l
	sta	addr0
	call	getaddr ;get optional attr byte
	jc	error	;error if non-hex character
	bit	7,b	;test for no entry
	jrnz	tcfX
	mov	a,l
	sta	addr1
tcfX:
	mvi	b,18	; hi byte of addr reg
	mvi	c,19	; lo byte of addr reg
	lxi	h,80*25
	lxi	d,0
	mvi	a,1fh
	out	crtctl	; clear update bit
tcf0:	in	crtctl
	rlc
	jrnc	tcf0
	mov	a,b
	out	crtctl
	mov	a,d
	out	crtdat
	mov	a,c
	out	crtctl
	mov	a,e
	out	crtdat
	mvi	a,1fh
	out	crtctl	; clear update bit
tcf1:	in	crtctl
	rlc
	jrnc	tcf1
	lda	addr0
	out	crtram
	inx	d
tcf2:	in	crtctl
	rlc
	jrnc	tcf2
	mov	a,b
	out	crtctl
	mov	a,d
	ori	08h	; attr RAM
	out	crtdat
	mov	a,c
	out	crtctl
	mov	a,e
	out	crtdat
	mvi	a,1fh
	out	crtctl	; clear update bit
tcf3:	in	crtctl
	rlc
	jrnc	tcf3
	lda	addr1
	out	crtram
	dcx	h
	mov	a,h
	ora	l
	jrnz	tcf0
	ret

; user must have set other registers as needed
thdd:	; issue command, wait...
	mvi	a,90h
	sta	addr0	; default: self test
	xra	a
	sta	addr1	; default: 256 samples
	call	getaddr ;get optional command
	jc	error	;error if non-hex character
	bit	7,b	;test for no entry
	jrnz	thY
	mov	a,h
	ora	a
	jnz	error
	shld	addr0	;save command
	call	getaddr ;get sample count
	jc	error	;error if non-hex character
	bit	7,b	;test for no entry
	jnz	thY
	mov	a,h
	ora	a
	jnz	error
	shld	addr1	;save count
thY:	call	crlf
	mvi	c,hddcmd
	inp	b
	lda	addr0
	out	hddcmd
thdd1:	call	xsamp
th1:	call	ysamp	; dump results from 8000h..DE
	in	hdderr	; also print final error status
	jmp	hexout

; user setup registers and issue READ command
thdrd:	call	crlf
	lxi	h,8000h
	lxi	b,hdddat	; B=0 (256)
	in	hddcmd
	ani	00001000b	; DRQ
	jrz	thr9
	inir
	inir
thr9:	xchg
	jmp	taddr
 endif

; read a sector from the floppy.
; user must turn on motors, select drive,
; set side, set DDEN, and step to track.
; data stored in 8000h
tfdrd:	xra	a
	sta	addr0
	call	getaddr ;get optional sector
	jc	error	;error if non-hex character
	bit	7,b	;test for no entry
	jrnz	tfrX
	mov	a,h
	ora	a
	jnz	error
	shld	addr0	; allow some rediculous values
tfrX:			; (also, side 1 uses: 0A..13)
	call	crlf
	lda	addr0
	out	fpysec
	lxi	h,8000h
	lxi	b,fpydat	; B=0
	mvi	a,88h	; read sector, side compare(?)
	out	fpycmd
tfr0:	hlt
	ini
	jrnz	tfr0
tfr1:	hlt
	ini
	jrnz	tfr1
	hlt	; wait for done
	in	fpysts
	call	hexout
	ret

tflpy:	; user must motor on and select drive (and side)
	mvi	a,0d0h
	sta	addr0	; default: force intr
	xra	a
	sta	addr1	; default: 256 samples
	call	getaddr ;get optional command
	jc	error	;error if non-hex character
	bit	7,b	;test for no entry
	jrnz	tfX
	mov	a,h
	ora	a
	jnz	error
	shld	addr0	;save command
	call	getaddr ;get sample count
	jc	error	;error if non-hex character
	bit	7,b	;test for no entry
	jnz	tfX
	mov	a,h
	ora	a
	jnz	error
	shld	addr1	;save count
tfX:
	call	crlf
	mvi	c,fpysts
	inp	b
	lda	addr0	; FDC command
	out	fpycmd
	call	xsamp	; gather samples
	jmp	ysamp	; dump samples

Vcomnd:
	lxi	h,signon
	jmp	msgprt

; B = checksum
getbyte:
	call	conine	; trashes C
	call	hexcon
	rc
	rlc
	rlc
	rlc
	rlc
	mov	e,a
	call	conine	; trashes C
	call	hexcon
	rc
	ora	e
	; update checksum...
	mov	e,a
	add	b
	mov	b,a
	mov	a,e
	ora	a
	ret

; Uses:
;	E' = error indicator (used?)
;	E = scratch (getbyte)
;	D = count (per line)
;	B = checksum (per line)
;	C = scratch (conine)
;	HL = dest (per line)
Hcomnd:
	; TODO: clear error flag
hc2:	call	crlf
hc0:	call	conine
	cpi	CTLC
	rz
	cpi	':'	; start of record
	jrnz	hc0
	mvi	b,0	; init checksum 0
	call	getbyte	; count
	jrc	hc8
	mov	d,a
	exaf	; save copy of count
	call	getbyte	; addr hi
	jrc	hc8
	mov	h,a
	call	getbyte	; addr lo
	jrc	hc8
	mov	l,a
	call	getbyte	; record type (ignored)
	jrc	hc8
	inr	d	; +1 for checksum byte
	; TODO: range check HL... ?
hc1:	call	getbyte
	jrc	hc8
	dcr	d
	jrz	hc7
	mov	m,a
	inx	h
	jr	hc1
hc7:	mov	a,b
	ora	a
	jrnz	hc8
	exaf
	ora	a
	jrnz	hc2
	; TODO: what to do with entry addr?
	; TODO: check error flag
	jmp	crlf
hc8:	; TODO: set error flag
	mvi	c,'!'
	call	conout
	jr	hc0

*********************************************************
**  Utility subroutines
*********************************************************

; take samples from port C, storing changes in 8000H
; B = initial value of port (may be faked).
; samples are 3 bytes each, new port value and 16-bit iteration count.
; returns DE pointing +1 after last sample.
xsamp1:	sta	addr1
; addr1 = max num samples (0=256)
xsamp:
	lxi	h,0
	lxi	d,8000h
xs0:	inp	a	; 12
	cmp	b	;  4
	jrnz	xs4	;  7
xs5:	inx	h	;  6
	mov	a,h	;  4
	ora	l	;  4
	jrnz	xs0	; 12 = 49 = 12.25uS (19.6uS)
	dcx	h	; show as FFFF
	mvi	a,1
	sta	addr1	; force last sample
	mov	a,b	; current register value
xs4:	xchg		;  4
	mov	m,a	;  7
	inx	h	;  6
	mov	m,e	;  7
	inx	h	;  6
	mov	m,d	;  7
	inx	h	;  6
	xchg		;  4
	mov	b,a	;  4
	lda	addr1	; 13
	dcr	a	;  4
	sta	addr1	; 13
	jrnz	xs5	; 12 = 93 = 23.25uS (37.2uS)
	ret

; print out samples from 8000h to DE
ysamp:
	lxi	h,8000h
ys2:	mov	a,h
	cmp	d
	jrnz	ys3
	mov	a,l
	cmp	e
	rz
ys3:	mov	a,m
	inx	h
	call	hexout
	call	space
	mov	b,m
	inx	h
	mov	a,m
	inx	h
	call	hexout
	mov	a,b
	call	hexout
	call	crlf
	jr	ys2

taddr:	mov	a,d	;display (DE) at console in HEX
	call	hexout	;print HI byte in HEX
	mov	a,e	;now do LO byte
hexout:	push	psw	;output (A) to console in HEX
	rlc		;get HI digit in usable (LO) position
	rlc
	rlc
	rlc
	call	nible	;and display it
	pop	psw	;get LO digit back and display it
nible:	ani	00001111b	;display LO 4 bits of (A) in HEX
	adi	90h	;algorithm to convert 4-bits to ASCII
	daa
	aci	40h
	daa
	mov	c,a	;display ASCII digit
	jmp	conout

space:	mvi	c,' '	;send an ASCII blank to console
	jmp	conout

crlf:	mvi	c,CR	;send Carriage-Return/Line-Feed to console
	call	conout
	mvi	c,LF
	jmp	conout

msgprt:	mov	a,m	;send string to console, terminated by 00
	ora	a
	rz
	mov	c,a
	call	conout
	inx	h
	jr	msgprt

check:	push	h	;non-destuctive compare HL:DE
	ora	a
	dsbc	d
	pop	h
	ret

; Convert letters to upper-case
toupper:
	cpi	'a'
	rc
	cpi	'z'+1
	rnc
	ani	01011111b
	ret

; Read a line of text into 'line'
; End with CR, honor BS
; Reject all non-printing characters, force toupper
linein:	lxi	h,line	;get string of characters from console, ending in CR
li0:	call	conin	;get a character
	cpi	BS	;allow BackSpacing
	jrz	backup
	cpi	CR
	jrz	li1
	cpi	CTLC
	jrz	liZ
	cpi	' '	;ignore other non-print
	jrc	li0
	call	toupper
	mov	m,a	;put character in line nuffer
	inx	h
	mov	c,a
	call	conout	; echo character
	mov	a,l	;else check for pending buffer overflow
	sui	line mod 256
	cpi	64
	rz		;stop if buffer full
	jr	li0	;if not full, keep getting characters

backup:	mov	a,l	;(destructive) BackSpacing
	cpi	line mod 256	;test if at beginning of line
	jrz	li0	;can't backspace past start of line
	mvi	c,bs	;output BS," ",BS to erase character on screen
	call	conout	;and put cursor back one position
	call	space
	mvi	c,bs
	call	conout
	dcx	h	;step buffer pointer back one
	jr	li0	;and continue to get characters

; End line input, A=CR
li1:	mov	m,a	; store CR in buffer
	mvi	c,CR	;display CR so user knows we got it
	jmp	conout	;then return to calling routine

; Abort input
liZ:	mvi	c,'^'
	call	conout
	mvi	c,'C'
	call	conout
	pop	h	; always OK?
	ret		; return to caller's caller (main debug loop)

; Get next character from line buffer.
; DE=current pointer within 'line'
; Returns: ZR=EOL else A=char
char:	mov	a,e	;remove a character from line buffer,
	sui	line mod 256	;testing for no more characters
	sui	64
	rz		;return [ZR] condition if at end of buffer
	ldax	d
	cpi	CR
	rz		;also return [ZR] if at end of line
	inx	d	;else step to next character
	ret		;and return [NZ]

; Get HEX value from line buffer
; Return: CY=error, HL=value, bit7(B)=1 if no input
getaddr:		;extract address from line buffer (delimitted by " ")
	setb	7,b	;flag to detect no address entered
	lxi	h,0
	call	skb
	rz		;end of buffer/line before a character was found
	jr	ga1	;if not space, then start getting HEX digits

ga0:	call	char
	rz
ga1:	call	hexcon	;start assembling digits into 16 bit accumilator
	jrc	chkdlm	;check if valid delimiter before returning error.
	res	7,b	;reset flag
	push	d	;save buffer pointer
	mov	e,a
	mvi	d,0
	dad	h	;shift "accumulator" left 1 digit
	dad	h
	dad	h
	dad	h
	dad	d	;add in new digit
	pop	d	;restore buffer pointer
	jr	ga0	;loop for next digit

chkdlm: cpi	' '	;blank is currently the only valid delimiter
	rz
	stc
	ret

hexcon: 		;convert ASCII character to HEX digit
	cpi	'0'	;must be .GE. "0"
	rc
	cpi	'9'+1	;and be .LE. "9"
	jrc	ok0	;valid numeral.
	cpi	'A'	;or .GE. "A"
	rc
	cpi	'F'+1	;and .LE. "F"
	cmc
	rc		;return [CY] if not valid HEX digit
	sui	'A'-'9'-1	;convert letter
ok0:	sui	'0'	;convert (numeral) to 0-15 in (A)
	ret

; These only work on */84 (and 10) models.
; Have no effect (and does nothing) on */83 models.
proginit:
	xra	a
	stai
 if not rom2k
	in	sysp84
	ani	not DSNONE
	ani	not K84MTR
	ori	DS0
	out	sysp84
 endif
	mvi	a,'A'
	sta	3000h
	ret

progoff:
	ldai
	rnz
	cma
	stai
 if not rom2k
	in	sysp84
	ori	DSNONE
	out	sysp84
 endif
	xra	a
	sta	3000h
	ret

progress:
	ldai
	rnz
 if not rom2k
	in	sysp84
	xri	DSNONE
	out	sysp84
 endif
	lda	3000h
	xri	00000011b
	sta	3000h
	ret

	rept	romsiz-$
	db	0ffh
	endm
 if $ <> romsiz
	.error	'EPROM overflow'
 endif

; RAM used...
	org	0ff00h
addr0:	ds	2
addr1:	ds	2
line:	ds	64

	end

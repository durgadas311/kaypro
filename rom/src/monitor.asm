; serial-port ROM monitor/boot for debugging Kaypro.
; Uses "aux serial" a.k.a "Serial Printer" port.

VERN	equ	020h	; ROM version

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

stack	equ	00000h	; stack at top of memory (wrapped)

; Start of ROM code
	org	00000h
rst0e	equ	$+8
	jmp	init
	db	0ffh,0ffh,0ffh,0ffh,0ffh

rst1e	equ	$+8
rst1:	jmp	swtrap
	db	0ffh,0ffh,0ffh,0ffh,0ffh

rst2e	equ	$+8
rst2:	jmp	swtrap
	db	0ffh,0ffh,0ffh,0ffh,0ffh

rst3e	equ	$+8
rst3:	jmp	swtrap
	db	0ffh,0ffh,0ffh,0ffh,0ffh

rst4e	equ	$+8
rst4:	jmp	swtrap
	db	0ffh,0ffh,0ffh,0ffh,0ffh

rst5e	equ	$+8
rst5:	jmp	swtrap
	db	0ffh,0ffh,0ffh,0ffh,0ffh

rst6e	equ	$+8
rst6:	jmp	swtrap
	db	0ffh,0ffh,0ffh,0ffh,0ffh

rst7e	equ	$+8
rst7:	jmp	swtrap
	db	0ffh,0ffh,0ffh,0ffh,0ffh

	; NMI not a problem?

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
	; TODO: print address, etc...
	jmp	debug

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
	; save registers on stack, for debugger access...
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
	db	CR,LF,'N <hw> - iNitialize hardware (KB83'
 if not rom2k
	db		', KB84, CRTC'
 endif
	db		')'
	db	CR,LF,'T <hw> - Test hardware (KBD'
 if not rom2k
	db		', CRTC, VRT, CRTR'
 endif
	db		', FLPY)'
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
 endif
	jmp	error

kb83:	db	'KB83',TRM
 if not rom2k
kb84:	db	'KB84',TRM
crtc:	db	'CRTC',TRM
crtr:	db	'CRTR',TRM
vrt:	db	'VRT',TRM
 endif
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
	jrz	tkbd
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
 endif
	lxi	h,flpy
	call	strcmp
	jz	tflpy
	jmp	error

 if not rom2k
tcrtc:	lxi	h,waitm
	call	msgprt
	mvi	b,5	; count
	mvi	e,80h	; compare
	mvi	a,31
	out	crtctl	; select reg
tc0:	in	crtctl
	ani	80h
	cmp	e
	jrz	tc9
	in	conctl
	ani	00000001b
	jrz	tc0
	in	condat
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
	djnz	tc0
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
	in	crtctl
	mov	c,a
	; TODO: reset Update bit? optionally?
	lxi	h,0
	lxi	d,8000h
tv0:	in	crtctl	; 11
	cmp	c	;  4
	jrnz	tv4	;  7
tv5:	inx	h	;  6
	mov	a,h	;  4
	ora	l	;  4
	jrnz	tv0	; 12 = 48 = 12uS
	jmp	tf1	; display results
tv4:	xchg
	mov	m,a
	inx	h
	mov	m,e
	inx	h
	mov	m,d
	inx	h
	xchg
	mov	c,a
	lda	addr1
	dcr	a
	sta	addr1
	jz	tf1
	jr	tv5

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
 endif

tflpy:	; user must motor on and select drive (and side)
	mvi	a,0d0h
	sta	addr0	; default: force intr
	xra	a
	sta	addr1	; default: 256 samples
	; TODO: parse optional args
	call	getaddr ;get optional command
	jc	error	;error if non-hex character
	bit	7,b	;test for no entry
	jrnz	tfX
	mov	a,h
	ora	a
	jnz	error
	shld	addr0	;save command
	call	getaddr ;get fill data
	jc	error	;error if non-hex character
	bit	7,b	;test for no entry
	jnz	tfX
	mov	a,h
	ora	a
	jnz	error
	shld	addr1	;save count
tfX:
	call	crlf
	in	fpysts
	mov	c,a
	lda	addr0	; FDC command
	out	fpycmd
	lxi	h,0
	lxi	d,8000h

tf0:	in	fpysts	; 11
	cmp	c	;  4
	jrnz	tf4	;  7
tf5:	inx	h	;  6
	mov	a,h	;  4
	ora	l	;  4
	jrnz	tf0	; 12 = 48 = 12uS
tf1:	; dump 8000h..DE
	lxi	h,8000h
tf2:
	mov	a,h
	cmp	d
	jrnz	tf3
	mov	a,l
	cmp	e
	rz	; user must motor off...
tf3:
	mov	a,m
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
	jr	tf2

; save sample, check for done.
tf4:	xchg
	mov	m,a
	inx	h
	mov	m,e
	inx	h
	mov	m,d
	inx	h
	xchg
	mov	c,a
	lda	addr1
	dcr	a
	sta	addr1
	jrz	tf1
	jr	tf5

Vcomnd:
	lxi	h,signon
	jmp	msgprt

*********************************************************
**  Utility subroutines
*********************************************************

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

print:	mov	a,m	; BDOS func 9 style msgprt
	cpi	'$'
	rz
	mov	c,a
	call	conout
	inx	h
	jr	print

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

; RAM used...
	org	0ff00h
addr0:	ds	2
addr1:	ds	2
line:	ds	64

	end

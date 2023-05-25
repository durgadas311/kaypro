; Emergency Kaypro Memory Test ROM image.
; Bare-bones memory test image, no serial I/O and uses
; no RAM (no stack). Uses drive A LED (*/84 and 10) or
; video ram (*/83) for indicating progress and failure.

VERN	equ	012h	; ROM version

TEST	equ	0

sio1	equ	04h	; "serial data", "keyboard"
brd1	equ	00h

sioA	equ	00h	;
sioD	equ	00h	; data
sioC	equ	02h	; control
condat	equ	sio1+sioA+sioD
conctl	equ	sio1+sioA+sioC
conbrr	equ	brd1
B9600	equ	0eh

romsiz	equ	0800h	; minimum space for ROM
vidram	equ	3000h	; video RAM start in */83 models
ramsta	equ	8000h	; where to start testing RAM

	maclib	z80

false	equ	0
true	equ	not false

const	macro
	local	co0
co0:	in	conctl
	ani	00000100b
	jrz	co0
	endm

space	macro
	const
	mvi	a,' '
	out	condat
	endm

crlf	macro
	const
	mvi	a,CR
	out	condat
	const
	mvi	a,LF
	out	condat
	endm

; A contains byte value - uses I register for temp
hexout	macro
	stai
	const
	ldai
	rlc
	rlc
	rlc
	rlc
	ani	0fh
	adi	90h
	daa
	aci	40h
	daa
	out	condat
	const
	ldai
	ani	0fh
	adi	90h
	daa
	aci	40h
	daa
	out	condat
	endm

; HL points to NUL-term message
msgprt	macro
	local	sg0,sg1
sg0:	mov	a,m
	ora	a
	jrz	sg1
	const
	mov	a,m
	inx	h
	out	condat
	jr	sg0
sg1:
	endm

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

; */84 (and 10) sysport drive select
DS0	equ	0010b
DS1	equ	0001b
DSNONE	equ	0011b	; also mask
MTRON	equ	10000b	; MOTOR control

sysp84	equ	14h	; sysport on */84 (and 10). */83 have nothing here.

; Start of ROM code
	org	00000h
	di	; redundant, really

	; init serial port
	mvi	a,B9600
	out	conbrr
	lxi	h,sioini
	mvi	c,conctl
	mvi	b,siolen
	outir

	lxi	h,signon
	msgprt

	in	sysp84
	ani	not DSNONE
	ani	not MTRON
	ori	DS0	; drive A LED on
	out	sysp84
	mvi	a,'0'
	sta	vidram
	mov	d,a	; pass indicator
	xra	a	; 00 - initial test seed
	; test memory... 8000-FFFF
; A=seed for this pass
mt0:	lxi	h,ramsta
	mov	c,a
	const
	mvi	a,CR
	out	condat
	mov	a,c
	hexout
	mov	a,c	; restore current seed
mt1:	mov	m,a
	adi	1
	daa
	inx	h
	mov	b,a
	mov	a,h
	ora	l
	mov	a,b
	jrnz	mt1
	lxi	h,ramsta
	mov	a,c
mt2:	cmp	m
	jrnz	error
	adi	1
	daa
	inx	h
	mov	b,a
	mov	a,h
	ora	l
	mov	a,b
	jrnz	mt2
	; end of pass - no errors
	in	sysp84
	xri	DSNONE
	out	sysp84	; switch to other drive LED on
	mov	a,d
	adi	1
	cpi	'9'+1
	jrc	pp0
 if TEST
	lxi	h,ramsta
	mov	a,c
	jr	error
 endif
	mvi	a,'0'
pp0:	sta	vidram
	mov	d,a
	mov	a,c
	adi	1
	daa
	jr	mt0

; HL=error addr, C=seed
error:	mov	e,m	; error value
	mov	d,a	; expected value
	crlf
	mov	a,h
	hexout
	mov	a,l
	hexout
	space
	mov	a,d
	hexout
	space
	mov	a,e
	hexout
	lxi	h,errm
	msgprt

	mvi	a,'E'
	sta	vidram
	in	sysp84
	ani	not DSNONE
	ori	DS0	; drive A LED on
	out	sysp84
er0:	lxi	h,50000
er1:	dcx	h	;  6
	mov	a,h	;  4
	ora	l	;  4
	jrnz	er1	; 12 = 26 (6.5uS) 325mS
	in	sysp84
	xri	1
	out	sysp84	; flash drive A LED
	lda	vidram
	xri	17h	; 'E' / 'R'
	sta	vidram
	jr	er0

signon:	db	'Kaypro Emergency Memory Test v'
	db	(VERN SHR 4)+'0','.',(VERN AND 0fh)+'0'
 if TEST
	db	' (DEBUG)'
 endif
	db	CR,LF,TRM

errm:	db	' Error',CR,LF,TRM

sioini:	db	18h	; reset
	db	4,044h	; 16x, 1s, Np
	db	3,0c1h	; 8b, RxEn
	db	5,0eah	; DTR, 8b, TxEn, RTS
	db	1,000h	;
siolen	equ	$-sioini

	rept	romsiz-$
	db	0ffh
	endm

	end

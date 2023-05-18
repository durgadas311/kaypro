; Emergency Kaypro Memory Test ROM image.
; Bare-bones memory test image, no serial I/O and uses
; no RAM (no stack). Uses drive A LED (*/84 and 10) or
; video ram (*/83) for indicating progress and failure.

VERN	equ	011h	; ROM version

TEST	equ	0

romsiz	equ	0800h	; minimum space for ROM
vidram	equ	3000h	; video RAM start in */83 models
ramsta	equ	8000h	; where to start testing RAM

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

; */84 (and 10) sysport drive select
DS0	equ	0010b
DS1	equ	0001b
DSNONE	equ	0011b	; also mask
MTRON	equ	10000b	; MOTOR control

sysp84	equ	14h	; sysport on */84 (and 10). */83 have nothing here.

; Start of ROM code
	org	00000h
	di	; redundant, really

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
mt0:	lxi	h,ramsta
	mov	c,a
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
	jr	error
 endif
	mvi	a,'0'
pp0:	sta	vidram
	mov	d,a
	mov	a,c
	adi	1
	daa
	jr	mt0

error:	mvi	a,'E'
	sta	vidram
	in	sysp84
	ani	not DSNONE
	ori	DS0	; drive A LED on
	out	sysp84
er0:	lxi	h,50000
er1:	dcx	h
	mov	a,h
	ora	l
	jrnz	er1
	in	sysp84
	xri	1
	out	sysp84	; flash drive A LED
	lda	vidram
	xri	17h	; 'E' / 'R'
	sta	vidram
	jr	er0

	db	'Kaypro Emergency Memory Test v'
	db	(VERN SHR 4)+'0','.',(VERN AND 0fh)+'0'
 if TEST
	db	' (DEBUG)'
 endif

	rept	romsiz-$
	db	0ffh
	endm

	end

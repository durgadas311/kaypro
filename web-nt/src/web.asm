; WEB NT startup for Kaypro II (ROM 81-???)
; Sanity check, then patch 0fbacH and overlay CP/M at 0d100H (01b00H bytes).
; CP/M overlay starts at 0300H.
	maclib	z80

	.ifndef	K10
K10	equ	0
	.endif

; Kaypro II, IV system control port
; Bit 7 maps in ROM when "1"
 if K10
sysport	equ	14h
patadr	equ	0ec8fh	; ROM places "call ROM" routine here
savstk	equ	0ed44h	; place where SP is saved for ROM calls
stack	equ	0ed88h	; SP used for ROM calls
bdospg	equ	0dc00h	; expected BDOS page
 else
sysport	equ	1ch
patadr	equ	0fbach	; ROM places "call ROM" routine here
savstk	equ	0fbdch	; place where SP is saved for ROM calls
stack	equ	0fc00h	; SP used for ROM calls
bdospg	equ	0ec00h	; expected BDOS page
 endif

CLR	equ	26
CR	equ	13
LF	equ	10
TAB	equ	9

bdos	equ	5

printf	equ	9


weblen	equ	1b00h	; length of OS extension for WEB NT
webadr	equ	bdospg-weblen

	org	00100h
	lda	bdos+2
	cpi	high bdospg
	rnz
	lxi	d,signon
	mvi	c,printf
	call	bdos
	call	check
	jrz	ok
	lxi	d,bioser
	mvi	c,printf
	call	bdos
	jr	punt

ok:	lxi	h,patch
	lxi	d,patadr
	lxi	b,patchz
	ldir
punt:	lxi	h,osovl
	lxi	d,webadr
	lxi	b,weblen
	ldir
	jmp	webadr

check:	lxi	d,patadr
	lxi	h,refcod
	mvi	b,refcodz
chk0:	ldax	d
	cmp	m
	rnz
	inx	h
	inx	d
	djnz	chk0
	ret

signon:	db	CLR,CR,LF,LF,LF
	db	'Welcome to:',CR,LF,LF
	db	TAB,TAB,'The Web Local Area Network - Version 1.0H',CR,LF,LF
	db	TAB,TAB,'Copyright (c) 1983 Centram Systems Inc.',CR,LF,LF
	db	'$'

bioser:	db	'Cannot patch BIOS, unknown version.',CR,LF,'$'

; code to patch at patadr
; bugfix for CP/M BIOSes that switch ROM before
; changing SP.
patch:	exx
	sspd	savstk
	lxi	sp,stack
	in	sysport
	setb	7,a
	out	sysport
	lxi	d,retadr
	push	d
	exx
	mvi	h,0
	pchl
retadr	equ	patadr+($-patch)
	exaf
	in	sysport
	res	7,a
	out	sysport
	lspd	savstk
	exaf
	ret
patchz	equ	$-patch

; Code to compare to patadr to confirm proper CP/M ROM
refcod:	exx
	in	sysport
	setb	7,a
	out	sysport
	sspd	savstk
	lxi	sp,stack
refcodz	equ	$-refcod

	rept	256-($ and 0ffh)
	db	0
	endm
osovl:	ds	0
	end

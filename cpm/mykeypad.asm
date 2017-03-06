	maclib	z80

numeric		equ	1	; Numeric Keypad codes
standard	equ	0	; 81-292a ROM codes
				; else: return raw code from keyboard

	; TODO: use commandline options to select keypad codes

	org	0100h
	lxi	sp,stack
	; TODO: check for CP/M 3?

	mvi	c,201	; keyboard device
	call	search
	jc	nokbd
	; double check sanity
	ora	a
	jnz	nokbd
	; TODO: more sanity checks?

	; HL -> jmp init
	lxi	d,5*3+4
	dada	d
	mov	e,m
	inx	h
	mov	d,m	; DE = modes table
	lxi	h,4
	dad	d	; HL = keycnv
	xchg
	lxi	h,keypad
	lxi	b,kplen
	ldir
	jmp	cpm 

search:
	lhld	cpm+1
	lxi	d,31*3
	dad	d
	pchl

bs	eq	8
lf	equ	10
vt	equ	11
ff	equ	12
cr	equ	13

keypad:
 if numeric
	; Number Pad conversion
	db	   0,  '0',  '.',    0,    0
	db	 '1',  '2',  '3',   cr,    0
	db	 '4',  '5',  '6',  ',',    0
	db	   0,  '7',  '8',  '9',  '-'
	db	   0,   vt,   lf,   bs,   ff
 else
 if standard
	; As returned by ROM 81-292a
	db	   0, 084h, 091h,    0,    0
	db	085h, 086h, 087h, 090h,    0
	db	088h, 089h, 08ah, 08fh,    0
	db	   0, 08bh, 08ch, 08dh, 08eh
	db	   0, 080h, 081h, 082h, 083h
 else
	; "neutral" - same as raw code from keyboard
	db	   0, 0b1h, 0b2h,    0,    0
	db	0c0h, 0c1h, 0c2h, 0c3h,    0
	db	0d0h, 0d1h, 0d2h, 0d3h,    0
	db	   0, 0e1h, 0e2h, 0e3h, 0e4h
	db	   0, 0f1h, 0f2h, 0f3h, 0f4h
 endif
 endif
kplen	equ	$-keypad

	ds	64
stack:	ds	0

	end

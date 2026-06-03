; Kaypro CP/M 2.2u1 keypad mapping util
	maclib	z80

INIT$PTR	equ	03ah	; location of init tab offset in BIOS
KTAB$OFF	equ	020h	; from INIT tab
SKIP		equ	255	; skip over patch area

cpm	equ	0
bdos	equ	5
deffcb	equ	5ch

; BDOS functions
coninf	equ	1
printf	equ	9

CR	equ	13
LF	equ	10

ctrl$A	equ	1
ctrl$B	equ	2
ctrl$C	equ	3
ctrl$D	equ	4
ctrl$E	equ	5
ctrl$F	equ	6
ctrl$G	equ	7
ctrl$H	equ	8
ctrl$I	equ	9
ctrl$J	equ	10
ctrl$K	equ	11
ctrl$L	equ	12
ctrl$M	equ	13
ctrl$N	equ	14
ctrl$O	equ	15
ctrl$P	equ	16
ctrl$Q	equ	17
ctrl$R	equ	18
ctrl$S	equ	19
ctrl$T	equ	20
ctrl$U	equ	21
ctrl$V	equ	22
ctrl$W	equ	23
ctrl$X	equ	24
ctrl$Y	equ	25
ctrl$Z	equ	26

	org	100h
	lhld	cpm+1
	mvi	l,0
	push	h
	lxi	d,INIT$PTR
	dad	d
	mov	e,m
	inx	h
	mov	d,m	; DE = INIT tab offset
	pop	h
	dad	d	; HL = INIT tab
	lxi	d,KTAB$OFF
	dad	d	; HL = kbdtab
	lxi	d,SKIP	; skip multi-key patch area
	dad	d
	shld	fkeytb

	; check against cold boot values
	lxi	d,cbtab
	call	chktab
	jz	isdef
	; else check against magic wand values
	lxi	d,mwtab
	call	chktab
	jz	ismw
	; else must not be UROM
	lxi	d,unkn
	mvi	c,printf
	call	bdos
	ret

ismw:	lda	deffcb+1
	cpi	'R'	; restore default?
	jnz	alrdy
	jmp	revert

isdef:	lda	deffcb+1
	cpi	'R'
	jz	alrdy
	jmp	setmw

alrdy:	lxi	d,already
	mvi	c,printf
	call	bdos
	ret

; DE = table to compare to
chktab:	lhld	fkeytb
	mvi	b,cbtabz
cbloop:	ldax	d
	cmp	m
	rnz	; NZ
	inx	h
	inx	d
	djnz	cbloop
	ret	; ZR

setmw:	lhld	fkeytb
	xchg		; DE = &cursor up...
	lxi	h,mwtab
	lxi	b,cbtabz
	ldir
	lxi	d,mwset
	mvi	c,printf
	call	bdos
	ret

revert:	lhld	fkeytb
	xchg		; DE = &cursor up...
	lxi	h,cbtab
	lxi	b,cbtabz
	ldir
	lxi	d,restor
	mvi	c,printf
	call	bdos
	ret

unkn:	db	'Unknown system$'
mwset:	db	'Keypad setup for Magic Wand$'
restor:	db	'Keypad set to default$'
already: db	'Keypad already set$'

fkeytb:	dw	0

		;^K  LF  BS  ^L
cbtab:	db	0bh,0ah,08h,0ch	; arrow keys
	db	0f0h,0f1h,0f2h,0f3h
	db	0f4h,0f5h,0f6h,0f7h
	db	0f8h,0f9h,0fah,0fbh
	db	0fch,0fdh
cbtabz	equ	$-cbtab

; Magic Wand mappings
mwtab:	db	ctrl$E	; cursor up
	db	ctrl$X	; cursor down
	db	ctrl$S	; cursor left
	db	ctrl$D	; cursor right
	db	ctrl$P	; [0] - char insert
	db	ctrl$V	; [1] - search/replace
	db	ctrl$W	; [2] - repeat s/r
	db	ctrl$Y	; [3] - char del
	db	ctrl$R	; [4] - block marker
	db	ctrl$O	; [5] - fwd line
	db	ctrl$F	; [6] - fwd page
	db	ctrl$A	; [7] - home
	db	ctrl$N	; [8] - back line
	db	ctrl$G	; [9] - back page
	db	ctrl$T	; [-] - top
	db	ctrl$B	; [,] - bottom
	db	ctrl$Q	; [ENTER] - full insert
	db	ctrl$U	; [.] - line del

	end

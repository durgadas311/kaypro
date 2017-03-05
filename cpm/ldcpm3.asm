vers equ '0b' ; December 22, 1985  12:57  drm  "LDCPM3.ASM"

	maclib Z80

cpm	equ	0
bdos	equ	5
tbuff	equ	80h

msgout	equ	9
reset	equ	13
openf	equ	15
read	equ	20
sdma	equ	26

lf	equ	10
cr	equ	13

	org	100h
LOADER:
; ***** this should be part of COLD BOOT in CPM3LDRK
;	lxi	h,0fd74h
;	lxi	d,00040h
;	lxi	b,16
;	ldir
; *****
	mvi	c,reset
	call	bdos
	MVI	C,openf
	LXI	D,cpm3$sys
	CALL	bdos
	CPI	255
	LXI	D,nofile
	JZ	errmsg
	LXI	D,tbuff
	CALL	dmaset

	CALL	readfile
	LXI	H,tbuff
	LXI	D,topres
	lxi	b,6
	ldir

	CALL	readfile
	MVI	C,msgout
	LXI	D,tbuff
	CALL	bdos

	LDA	reslen
	MOV	d,A
;	LDA	topres
	mvi	e,0
	lxi	h,buffer
	dad	d
	shld	resend
	xchg
	call	loadf
	LDA	bnklen
	ORA	A
	JZ	nobnk
	MOV	d,A
;	LDA	topbnk
	mvi	e,0
	lhld	resend
	dad	d
	shld	bnkend
	xchg
	CALL	loadf
nobnk:
	di

; ***** this should be part of COLD BOOT in CPM3LDRK
	lxi	h,0fd74h
	lxi	d,00040h
	lxi	b,16
	ldir
; *****



	lda	reslen
	mov	b,a		;B=reslen
	mvi	c,0
	lhld	resend
	dcx	h
	lda	topres
	mov	d,a
	mvi	e,0
	dcx	d
	lddr
	lda	bnklen
	ora	a
	jz	nobnk0
	mov	b,a
	mvi	c,0
	lhld	bnkend
	dcx	h
	lda	topbnk
	mov	d,a
	mvi	e,0
	dcx	d
	lddr
nobnk0:
	lhld	cstart
	pchl

loadf: ;ORA	A	;DE = top address (max+1)
       ;MOV	D,A
       ;MVI	E,0
	MOV	A,H
	RAL
	MOV	H,A
read0:	XCHG
	LXI	B,-128
	DAD	B
	XCHG
	PUSH	D
	PUSH	H
	CALL	dmaset
	CALL	readfile
	POP	H
	POP	D
	DCR	H
	JNZ	read0
	RET

dmaset: MVI	C,sdma
	CALL	bdos
	RET

readfile:
	MVI	C,read
	LXI	D,cpm3$sys
	CALL	bdos
	ORA	A
	LXI	D,rderr
	RZ
errmsg: MVI	C,msgout
	CALL	bdos
	jmp	cpm

cpm3$sys:
	DB	0,'CPM3    SYS',0,0,0,0
	DB	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	DB	0,0,0,0

nofile: DB	cr,lf,'error: File not found: CPM3.SYS',cr,lf,'$'

rderr:	DB	cr,lf,'error: Read failure: CPM3.SYS',cr,lf,'$'

topres: db	0
reslen: db	0
topbnk: db	0
bnklen: db	0
cstart: dw	0

resend: dw	0
bnkend: dw	0

buffer: ds	0
	end

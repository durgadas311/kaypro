vers equ '0c' ; March 5, 2017  08:39  drm  "LDCPM3.ASM"

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
; ROM 81-292 uses 0fd74h
; U-ROM 81-478 uses 0fe9ah
; ROM 81-302 uses 0fd5ch
; Identify ROM by...
; we can't map ROM in, we are in low memory.
; can't call ROM, either.
; U-ROM places '2.01' in 0fff8h...
; 81-292 places copyout in 0fde5h (DB 14 CB BF D3 14 ED B0 DB 14 CB FF D3 14 C9)
; 81-302 places copyout in 0f919h (DB 14 CB BF D3 14 ED B0 DB 14 CB FF D3 14 C9)
	call	chkuni
	lxi	h,0fe9ah
	mvi	a,'U'
	jrz	gotrom
	lxi	h,0f919h
	call	chksig
	lxi	h,0fd5ch
	mvi	a,'3'
	jrz	gotrom
	lxi	h,0fde5h
	call	chksig
	lxi	h,0fd74h
	mvi	a,'2'
	jrz	gotrom
	lxi	d,badrom
	mvi	c,msgout
	call	bdos
	jmp	cpm
gotrom:
	shld	romcrt
	sta	romid
	lxi	d,rommsg
	mvi	c,msgout
	call	bdos

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
	lhld	romcrt
	lxi	d,00040h
	lxi	b,16
	ldir
	lda	romid
	stax	d	; ROM identifer char at 0050h
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

chkuni:
	lxi	h,0fff8h
	mov	a,m
	inx	h
	cpi	'2'
	rnz
	mov	a,m
	inx	h
	cpi	'.'
	rnz
	mov	a,m
	inx	h
	cpi	'0'
	rnz
	mov	a,m
	inx	h
	cpi	'1'
	ret

; HL = prospective location
chksig:
	lxi	d,signature
	mvi	b,siglen
chk0:	ldax	d
	cmp	m
	rnz
	inx	h
	inx	d
	djnz	chk0
	xra	a
	ret

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

signature:
	in	014h
	res	7,a
	out	014h
	ldir
	in	014h
	setb	7,a
	out	014h
	ret
siglen	equ	$-signature

badrom:	db	cr,lf,7,'Unknown ROM version!',cr,lf,'$'
rommsg:	db	cr,lf,'Got ROM id '
romid	db	'.',cr,lf,'$'
romcrt	dw	0

buffer: ds	0

	end

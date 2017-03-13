vers equ '0d' ; March 12, 2017  16:02  drm  "LDCPM3.ASM"

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
	lxi	sp,stack
; ***** this should be part of COLD BOOT in CPM3LDRK
;	lxi	h,0fd74h
;	lxi	d,00040h
;	lxi	b,16
;	ldir
; *****
; ROM 81-292 uses 0fd74h
; U-ROM 81-478 uses 0fe9ah
; ROM 81-302 uses 0fd5ch
; ROM 81-326 uses 0f800h
; Identify ROM by...
; we can't map ROM in, we are in low memory.
; can't call ROM, either.
; U-ROM places '2.01' in 0fff8h...
; 81-292 places copyout in 0fde5h (DB 14 CB BF D3 14 ED B0 DB 14 CB FF D3 14 C9)
; 81-302 places copyout in 0f919h (DB 14 CB BF D3 14 ED B0 DB 14 CB FF D3 14 C9)
; 81-326 places copyout in 0f822h (DB 14 CB BF D3 14 ED B0 DB 14 CB FF D3 14 C9)
	call	chkuni
	jz	rom20
	lxi	h,0f822h
	call	chksig
	jz	rom17
	lxi	h,0f919h
	call	chksig
	jz	rom19
	lxi	h,0fde5h
	call	chksig
	jz	romXX
	lxi	d,badrom
	mvi	c,msgout
	call	bdos
	jmp	cpm
gotrom:
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
	; Before running OS, patch logical-physical drive table.
	call	setlpd
	;
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

rom20:
	lxi	h,0fe9ah
	shld	romcrt
	mvi	a,'U'
	sta	romid
	lda	0fff7h
	cpi	0ffh	; floppy-only
	lxi	h,lpdfpy	; floppy only
	jrz	romZZ$1
	lda	0fff4h	; drive A
	ani	00001100b
	; common code
romZZ$0:
	lxi	h,lpdwin0	; win, floppy
	jrz	romZZ$1
	lxi	h,lpdwin1	; floppy, win
romZZ$1:
	shld	lptbl
	jmp	gotrom

rom17:	; 81-326, version 1.7R
	lxi	h,0f800h
	shld	romcrt
	mvi	a,'2'	; correct?
	jr	romXX$0	; floppy-only

rom19:	; 81-302c, 81-277, 81-188, version series 1.9
	lxi	h,0fd5ch
	shld	romcrt
	mvi	a,'3'
	sta	romid
	; get floppy/win determinination
	; 0f700h: cur dsk type, 0=win, (ff) floppy
	; 0f701h: drive A type...
	; 0f702h: cur SPT?
	lda	0f701h
	ora	a
	jr	romZZ$0

romXX:	; 81-292a, no visible version - floppy-only
	lxi	h,0fd74h
	shld	romcrt
	mvi	a,'2'
romXX$0:
	sta	romid
	lxi	h,lpdfpy	; floppy only
	shld	lptbl
	jmp	gotrom

setlpd:
	; locate lptbl... update it
	lhld	cstart	; assume this is BIOS base
	lxi	d,100	; offset to logical-physical drive table
	dad	d
	mov	e,m
	inx	h
	mov	d,m
	lhld	lptbl
	mov	a,h
	ora	l
	rz
	lxi	b,3	; TODO: allow more drives?
	ldir
	ret

cpm3$sys:
	DB	0,'CPM3    SYS',0,0,0,0
	DB	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	DB	0,0,0,0

topres: db	0
reslen: db	0
topbnk: db	0
bnklen: db	0
cstart: dw	0

resend: dw	0
bnkend: dw	0

; This code is located in high RAM for certain ROM versions
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

badrom:	db	7,'Unknown ROM version!',cr,lf,'$'
rommsg:	db	'LDCPM3 vers 3.10'
	dw	vers
	db	' - Got ROM id '
romid:	db	'.',cr,lf,'$'
romcrt:	dw	0
lptbl:	dw	0

lpdwin0:	db	50,51,33
lpdwin1:	db	33,50,51
lpdfpy:		db	33,34,35

nofile: DB	cr,lf,'error: File not found: CPM3.SYS',cr,lf,'$'

rderr:	DB	cr,lf,'error: Read failure: CPM3.SYS',cr,lf,'$'

	ds	64
stack:	ds	0

buffer: ds	0

	end

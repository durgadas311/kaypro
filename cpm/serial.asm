vers equ '0f' ; July 15, 2020  17:47  drm  "SIO3KP.ASM"
;********************************************************
; Z80-SIO I/O module for CP/M plus on the KAYPRO	*
; Copyright (C) 1985 Douglas Miller			*
;********************************************************
	maclib Z80

	extrn	@ctbl

false	equ	0
true	equ	not false

dbase	equ	200	;base for all char I/O devices
dev0	equ	002	;first device, rel. to base
ndev	equ	3
 
sio1	equ	004h	;z80-sio/0
sio2	equ	00ch	;another sio

dce	equ	sio2+0	;auxiliary printer
dte	equ	sio1+0	;terminal equip.
modem	equ	sio2+1	;modem

	cseg	;common memory, other parts in banked.
	dw	thread
	db	dbase+dev0,ndev

	jmp	intsio
	jmp	instsio
	jmp	inputsio
	jmp	outstsio
	jmp	outputsio
	dw	strsio
	dw	tblsio
	dw	modsio

strsio: db	'KAYPRO ',0,'Z80-SIO handler ',0,'v3.10'
	dw	vers
	db	'$'

; 7=DTR, 6=, 5=CTS, 4=sync : 3=DCD, 2=, 1=RTS, 0=
;		mask      xor       flags     port
modsio: db	00100000b,10100010b,00110100b,dce
	db	00101000b,10101010b,00110100b,dte
	db	00101000b,10101010b,00110100b,modem
; flags: IxBBSSPP I=no-init, BB=bits/char, SS=stop bits, PP=parity
; xor:   DxXXXxRx D=DTR, T=xor RR0, R=RTS
; mask:  xxAAAxxx AAA=and RR0 (CTS, DCD)
; (((RR0 ^ XXX) & AAA) & 00111000) must be zero for "ready"
; NOTE: DCE (serial printer) has no handshake outputs, and only CTS in.
; pins:   2   3   4   5   6   8   15   17   20  (DB-25)
; DCE:   RxD TxD                            CTS
; DTE:   TxD RxD RTS CTS +5V DCD  TxC  RxC  DTR

thread	equ	$

	dseg	;banked memory.
tblsio: 	;initial values only, copied by BIOS to its table.
	db	'DCE   ',00001111b,14 ;I/O, soft-baud, no protocal, 9600
	db	'DTE   ',00001111b,14 ;I/O, soft-baud, no protocal, 9600
	db	'MODEM ',00001011b,6  ;I/O, hard-baud, no protocal, 300
				      ; all serial
; preserves B (device number)
vector: mov	a,b	;device number
	sui	dev0
	add	a
	add	a	;*4
	mov	e,a
	mvi	d,0
	lxi	h,modsio+3
	dad	d	; HL = &modsio[dev].port
	ret

intsio:
	call	vector	; HL = &modsio[dev].port
	dcx	h	; &modsio[dev].flags byte
is1:	bit	7,m	; no init?
	rnz
	mov	a,b	; do this before we destroy B
	add	a
	add	a
	add	a	;*8
	mov	c,a
	mvi	b,0
	xchg
	lxi	h,@ctbl+6
	dad	b
	push	h	; save @ctbl[x]
	xchg		; restore &modsio[dev].flags
	mov	a,m
	ani	00110000b	; bits per char
	rlc			; -bb-----
	mov	e,a	; Tx image
	setb	3,e		; Tx Enable
	rlc			; bb------
	ori	00000001b	; Rx Enable
	mov	d,a	; Rx image
	mov	a,m
	ani	00001111b	; stop bits, parity
	ori	01000000b	; 16x clock
	mov	b,a	; WR4 image
	dcx	h		; XOR byte
	mov	a,m		;
	ani	10000010b	; DTR, RTS state
	ora	e
	mov	e,a		; Tx control, with RTS/DTR
	inx	h		; flags
	inx	h		; port
	mov	c,m		; base (data) port
	inr	c
	inr	c		; ctrl port is +2
	mvi	a,4
	outp	a
	outp	b	; WR4
	inr	a
	outp	a
	outp	e	; WR5
	mvi	a,3
	outp	a
	outp	d	; WR3
; init baud rate
	mov	c,m	; base port
	res	2,c	; xlate to baud rate port
	pop	h	; HL = &@ctbl[dev].flags
	bit	2,m	; soft baud?
	rz
	inx	h	; @ctbl[dev].baud
	mov	a,m	; 0; 1,2,3..15
	ora	a
	rz		; no baud set
	; convert to WD1943 baud code (skip 2000 baud)
	cpi	10	; 1,2,3..15
	jrnc	is0
	dcr	a	; 0,1,2,3,4,5,6,7,8; 10,11,12,13,14,15
is0:	outp	a
	ret

inputsio:
inp0:	call	instsio		; returns HL = &modsio[dev].port, C = cmd port
	jrz	inp0			; wait for character ready
	mov	c,m
	inp	a			; get data
	ani	7Fh			; mask parity
	ret

instsio:
	call	vector		; HL = &modsio[dev].port
ins0:	mov	c,m
	inr	c
	inr	c
	xra	a
	outp	a     
	inp	a			; read from status port
	ani	1			; isolate RxRdy
	rz				; return with zero
	ori	true
	ret

outputsio:
	mov	a,c
	push	psw
outp0:	call	outstsio	; returns HL = &modsio[dev].mask, C = cmd port
	jrz	outp0		; wait for TxEmpty, HL->mask
	pop	psw
	dcr	c
	dcr	c		; data port
	outp	a		; send data
	ret

outstsio:
	call	vector
os0:	mov	c,m		; &modsio[dev].port
	dcx	h
	dcx	h		; &modsio[dev].xor
	inr	c
	inr	c
	mvi	a,00010000b	;reset ext/status change
	outp	a
	inp	a
	xra	m 
	dcx	h		; &modsio[dev].mask
	ana	m		; [ZR] = ready
	ani	00111000b
	jrnz	nrdy
	inp	a
	ani	04h		; test xmit holding register empty
	rz			;
	ori	true
	ret			; return true if ready

nrdy:	xra	a
	ret

; This translation is done in code.
;speed$table: ;  DTE,DCE using WD1943 chip
;0	db	0ffh		;no baud rate
;1	db	0	      ;50
;2	db	1	      ;75
;3	db	2	      ;110
;4	db	3	      ;134.5
;5	db	4	      ;150
;6	db	5	      ;300
;7	db	6	      ;600
;8	db	7	      ;1200
;9	db	8	      ;1800
;;	db	9		;2000 - not defined by CP/M
;10	db	10	      ;2400
;11	db	11	      ;3600
;12	db	12	      ;4800
;13	db	13	      ;7200
;14	db	14	      ;9600
;15	db	15	      ;19200

	end

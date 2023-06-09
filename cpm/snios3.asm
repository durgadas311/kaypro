; SNIOS for fictitious CPNetDevice
;
	maclib	z80

	public	NTWKIN, NTWKST, CNFTBL, SNDMSG, RCVMSG, NTWKER, NTWKBT, CFGTBL

	cseg
;	Slave Configuration Table
CFGTBL:
	ds	1		; network status byte
	ds	1		; slave processor ID number
	ds	2		; A:	Disk device	+2
	ds	2		; B:	"
	ds	2		; C:	"
	ds	2		; D:	"
	ds	2		; E:	"
	ds	2		; F:	"
	ds	2		; G:	"
	ds	2		; H:	"
	ds	2		; I:	"
	ds	2		; J:	"
	ds	2		; K:	"
	ds	2		; L:	"
	ds	2		; M:	"
	ds	2		; N:	"
	ds	2		; O:	"
	ds	2		; P:	"

	ds	2		; console device	+34

	ds	2		; list device:		+36...
	ds	1		;	buffer index	+2
	db	0		;	FMT		+3
	db	0		;	DID		+4
	db	0ffh		;	SID (CP/NOS must still initialize)
	db	5		;	FNC		+6
	db	0		;	SIZ		+7
	ds	1		;	MSG(0)	List number	+8
	ds	128		;	MSG(1) ... MSG(128)	+9...

ioport:	db	038h	; possibly configured here...

;	Network Status Byte Equates
;
active		equ	0001$0000b	; slave logged in on network
rcverr		equ	0000$0010b	; error in received message
senderr 	equ	0000$0001b	; unable to send message

;	Utility Procedures
;
;	Network Initialization
NTWKIN:
	lxix	CFGTBL
	mvi	a,active
	stx	a,+0 ; network status byte
	lda	ioport
	mov	c,a
	inr	c	; status port
	xra	a
	outp	a
	dcr	c
	inp	a
	stx	a,+1 ; our slave (client) ID
	xra	a
	sta	CFGTBL+36+7
	ret

;	Network Status
NTWKST:
	lda	CFGTBL+0
	mov	b,a
	ani	not (rcverr+senderr)
	sta	CFGTBL+0
	mov	a,b
	ret

;	Return Configuration Table Address
;	Still need this for BDOS func 69
CNFTBL:
	lxi	h,CFGTBL
	ret

;	Send Message on Network
SNDMSG:			; BC = message addr
	mov	h,b
	mov	l,c	; HL = message address
	push	h
	popix
	lda	CFGTBL+1
	stx	a,+2	; Set Slave ID in header
	lda	ioport
	mov	c,a
	mvi	b,5	; length of header
	outir
	ldx	b,+4	; msg siz field (-1)
	inr	b	; might be 0, but that means 256
	outir
	inr	c	; status port
	inp	a	;
	ani	02h	; cmd overrun
	rz
	mvi	a,0ffh
	ret

;	Receive Message from Network
RCVMSG:			; BC = message addr
	mov	h,b
	mov	l,c	; HL = message address
	push	h
	popix
	lda	ioport
	mov	c,a
	inr	c	; status port
rcvwait:
	inp	a
	ani	01h	; data ready
	jz	rcvwait
	dcr	c	; data port
	mvi	b,5	; header length
	inir
	; Could compare SLVID with "LDX r,1" and ignore messages.
	; But this "hardware" is point-to-point (connection oriented)
	; so the only messages we see are intended for us.
	ldx	b,+4	; msg siz
	inr	b
	inir
	inr	c	; status port
	inp	a
	ani	04h	; rsp overrun
	rz
	mvi	a,0ffh
NTWKER:
	ret

NTWKBT:	; NETWORK WARM START
	lda	ioport
	mov	c,a
	xra	a	; Future hardware might expect data
	outp	a
	inp	a	; this is our Slave ID, but we already have it
	ret

	end

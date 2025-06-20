; ULCOPS.COM: workstation node
;
; Send:
;	wait for network activity to subside (Rx to stop for XXX mS)
;	and for DCD to turn on.
;
;	send message, bounce DTR 3 times when done.
;

wboot	equ	0
iobyte	equ	3
usrdsk	equ	4
bdos	equ	5
unkn1	equ	8
unkn2	equ	40h
deffcb	equ	5ch
defdma	equ	80h

; 18*STX, XX, XX, NID, [NID,] XX, {eom}		// ACK?
; 18*STX, XX, XX, NID, [NID,] XX, XX MSG... CKS {eom}
	org	00100h
; cold start
L0100:	lxi	sp,L20de	;; 0100: 31 de 20    1. 
	xra	a		;; 0103: af          .
	lxi	h,L1ff1		;; 0104: 21 f1 1f    ...
	mvi	c,35		;; 0107: 0e 23       .#
	call	fill		;; 0109: cd 04 1d    ...
	lxi	h,L1e9c		;; 010c: 21 9c 1e    ...
	mvi	c,34		;; 010f: 0e 22       ."
	call	fill		;; 0111: cd 04 1d    ...
	lxi	h,L01cf		;; 0114: 21 cf 01    ...
	lxi	d,L1ffa		;; 0117: 11 fa 1f    ...
	lxi	b,3		;; 011a: 01 03 00    ...
	ldir			;; 011d: ed b0       ..
	lxi	h,L1ebe		;; 011f: 21 be 1e    ...
	mvi	c,50		;; 0122: 0e 32       .2
	call	fill		;; 0124: cd 04 1d    ...
	mvi	a,064h		;; 0127: 3e 64       >d
	sta	L1ec5		;; 0129: 32 c5 1e    2..
	lxi	h,000a7h	;; 012c: 21 a7 00    ...
	shld	L1ec6		;; 012f: 22 c6 1e    "..
	mvi	a,001h		;; 0132: 3e 01       >.
	sta	L1e9e		;; 0134: 32 9e 1e    2..
	inr	a		;; 0137: 3c          <
	sta	L1ea0		;; 0138: 32 a0 1e    2..
	nop			;; 013b: 00          .
	nop			;; 013c: 00          .
	mvi	a,080h		;; 013d: 3e 80       >.
	sta	L1f6f		;; 013f: 32 6f 1f    2o.
	lhld	wboot+1		;; 0142: 2a 01 00    *..
	shld	L2034		;; 0145: 22 34 20    "4 
	lxi	d,7		;; 0148: 11 07 00    ...
	dad	d		;; 014b: 19          .
	shld	L035c+1		;; 014c: 22 5d 03    "].
	dcx	h		;; 014f: 2b          +
	dcx	h		;; 0150: 2b          +
	dcx	h		;; 0151: 2b          +
	dcx	h		;; 0152: 2b          +
	shld	L0dd1+1		;; 0153: 22 d2 0d    "..
	lxi	d,39		;; 0156: 11 27 00    .'.
	dad	d		;; 0159: 19          .
	shld	L1dbc+1		;; 015a: 22 bd 1d    "..
	lhld	bdos+1		;; 015d: 2a 06 00    *..
	shld	L0ce2+1		;; 0160: 22 e3 0c    "..
	lhld	L2034	; BIOS wboot (BIOS+3)
	lxi	d,0f203h; -0dfdh (-0e00+3)
	dad	d		;; 0169: 19          .
	push	h	; BDOS entry
	inx	h		;; 016b: 23          #
	inx	h		;; 016c: 23          #
	inx	h		;; 016d: 23          #
	lxi	d,L0206	; new permanent error subroutine
	mov	m,e		;; 0171: 73          s
	inx	h		;; 0172: 23          #
	mov	m,d		;; 0173: 72          r
	inx	h		;; 0174: 23          #
	lxi	d,L020a	; select error subroutine
	mov	m,e		;; 0178: 73          s
	inx	h		;; 0179: 23          #
	mov	m,d		;; 017a: 72          r
	inx	h		;; 017b: 23          #
	lxi	d,L020e	; ro disk error subroutine
	mov	m,e		;; 017f: 73          s
	inx	h		;; 0180: 23          #
	mov	m,d		;; 0181: 72          r
	inx	h		;; 0182: 23          #
	lxi	d,L0212	; ro file error subroutine
	mov	m,e		;; 0186: 73          s
	inx	h		;; 0187: 23          #
	mov	m,d		;; 0188: 72          r
	lxi	d,0619h		;; 0189: 11 19 06    ...
	dad	d		;; 018c: 19          .
	xra	a		;; 018d: af          .
	mov	m,a		;; 018e: 77          w
	pop	h	; BDOS entry
	lxi	d,0dd3h		;; 0190: 11 d3 0d    ...
	dad	d		;; 0193: 19          .
	shld	L0cc4+2	; searcha in bdos
	lxi	d,17		;; 0197: 11 11 00    ...
	dad	d		;; 019a: 19          .
	shld	L0d0e+1	; dcnt?
	shld	L0ccd+1		;; 019e: 22 ce 0c    "..
	inx	h		;; 01a1: 23          #
	shld	L0d14+1		;; 01a2: 22 15 0d    "..
	shld	L0cd3+1		;; 01a5: 22 d4 0c    "..
	; fixup conin hookd
	lhld	L035c+1		;; 01a8: 2a 5d 03    *].
	shld	L202d		;; 01ab: 22 2d 20    "- 
	mov	a,m		;; 01ae: 7e          ~
	sta	L035c+1		;; 01af: 32 5d 03    2].
	inx	h		;; 01b2: 23          #
	mov	a,m		;; 01b3: 7e          ~
	sta	L035c+2		;; 01b4: 32 5e 03    2^.
	lxi	d,L0315		;; 01b7: 11 15 03    ...
	mov	m,d		;; 01ba: 72          r
	dcx	h		;; 01bb: 2b          +
	mov	m,e		;; 01bc: 73          s

	mvi	a,020h		;; 01bd: 3e 20       > 
	sta	L203e		;; 01bf: 32 3e 20    2> 
	sta	L2062		;; 01c2: 32 62 20    2b 
	sta	L2086		;; 01c5: 32 86 20    2. 
	xra	a		;; 01c8: af          .
	sta	L20aa		;; 01c9: 32 aa 20    2. 
	jmp	L0370		;; 01cc: c3 70 03    .p.

L01cf:	db	'COM'

; NDOS entry?
L01d2:	sspd	L2024		;; 01d2: ed 73 24 20 .s$ 
	lxi	sp,L210e	;; 01d6: 31 0e 21    1..
	jr	L0218		;; 01d9: 18 3d       .=

L01db:	push	psw		;; 01db: f5          .
	push	h		;; 01dc: e5          .
	push	b		;; 01dd: c5          .
	push	d		;; 01de: d5          .
	lda	L1da1		;; 01df: 3a a1 1d    :..
	ana	a		;; 01e2: a7          .
	jrz	L01fb		;; 01e3: 28 16       (.
	lxi	h,9		;; 01e5: 21 09 00    ...
	dad	d		;; 01e8: 19          .
	mov	a,m		;; 01e9: 7e          ~
	ani	07fh		;; 01ea: e6 7f       ..
	cpi	044h		;; 01ec: fe 44       .D
	jrnz	L01fb		;; 01ee: 20 0b        .
	mov	a,c		;; 01f0: 79          y
	cpi	00fh		;; 01f1: fe 0f       ..
	jz	L02b2		;; 01f3: ca b2 02    ...
	cpi	010h		;; 01f6: fe 10       ..
	jz	L02e7		;; 01f8: ca e7 02    ...
L01fb:	pop	d		;; 01fb: d1          .
	pop	b		;; 01fc: c1          .
	pop	h		;; 01fd: e1          .
	pop	psw		;; 01fe: f1          .
	jmp	L0cab		;; 01ff: c3 ab 0c    ...

L0202:	ret			;; 0202: c9          .

; for func 98 - a node GUID
; these must form a unique identifier... who does that?
L0203:	dw	100h	; base addr?
L0205:	db	06fh	; page reloc?

L0206:	mvi	a,0e1h		;; 0206: 3e e1       >.
	jr	L0214		;; 0208: 18 0a       ..

L020a:	mvi	a,0f2h		;; 020a: 3e f2       >.
	jr	L0214		;; 020c: 18 06       ..

L020e:	mvi	a,0f3h		;; 020e: 3e f3       >.
	jr	L0214		;; 0210: 18 02       ..

L0212:	mvi	a,0f4h		;; 0212: 3e f4       >.
L0214:	sta	L026e		;; 0214: 32 6e 02    2n.
	ret			;; 0217: c9          .

; NDOS function call begin...
L0218:	call	L0b3c		;; 0218: cd 3c 0b    .<.
	push	psw		;; 021b: f5          .
	cpi	0e1h		;; 021c: fe e1       ..
	jrz	L0232		;; 021e: 28 12       (.
	cpi	0f2h		;; 0220: fe f2       ..
	jrz	L0237		;; 0222: 28 13       (.
	cpi	0f3h		;; 0224: fe f3       ..
	jrz	L023c		;; 0226: 28 14       (.
	cpi	0f4h		;; 0228: fe f4       ..
	jrz	L0241		;; 022a: 28 15       (.
L022c:	pop	psw		;; 022c: f1          .
	lspd	L2024		;; 022d: ed 7b 24 20 .{$ 
	ret			;; 0231: c9          .

L0232:	lxi	d,L0288		;; 0232: 11 88 02    ...
	jr	L0244		;; 0235: 18 0d       ..

L0237:	lxi	d,L0293		;; 0237: 11 93 02    ...
	jr	L0244		;; 023a: 18 08       ..

L023c:	lxi	d,L029a		;; 023c: 11 9a 02    ...
	jr	L0244		;; 023f: 18 03       ..

L0241:	lxi	d,L02a4		;; 0241: 11 a4 02    ...
L0244:	push	d		;; 0244: d5          .
	lda	L0282		;; 0245: 3a 82 02    :..
	adi	040h		;; 0248: c6 40       .@
	sta	L0282		;; 024a: 32 82 02    2..
	lxi	d,L026f		;; 024d: 11 6f 02    .o.
	mvi	c,009h		;; 0250: 0e 09       ..
	call	L0cab		;; 0252: cd ab 0c    ...
	pop	d		;; 0255: d1          .
	mvi	c,009h		;; 0256: 0e 09       ..
	call	L0cab		;; 0258: cd ab 0c    ...
	mvi	c,001h		;; 025b: 0e 01       ..
	call	L0cab		;; 025d: cd ab 0c    ...
	cpi	003h		;; 0260: fe 03       ..
	jrnz	L022c		;; 0262: 20 c8        .
	xra	a		;; 0264: af          .
	sta	L1db9		;; 0265: 32 b9 1d    2..
	call	L0527		;; 0268: cd 27 05    .'.
	jmp	L0379		;; 026b: c3 79 03    .y.

L026e:	db	0
L026f:	db	0dh,0ah,7,'? BDOS Error on '
L0282:	db	'x: - $'
L0288:	db	'Bad Sector$'
L0293:	db	'Select$'
L029a:	db	'Drive R/O$'
L02a4:	db	'File R/O$'

	; orphan
	pop	d		;; 02ad: d1          .
	pop	b		;; 02ae: c1          .
	pop	h		;; 02af: e1          .
	pop	psw		;; 02b0: f1          .
	ret			;; 02b1: c9          .

L02b2:	pop	d		;; 02b2: d1          .
	push	d		;; 02b3: d5          .
	mvi	c,00fh		;; 02b4: 0e 0f       ..
	call	L0cab		;; 02b6: cd ab 0c    ...
	inr	a		;; 02b9: 3c          <
	jz	L01fb		;; 02ba: ca fb 01    ...
	pop	h		;; 02bd: e1          .
	push	h		;; 02be: e5          .
	lxi	d,4		;; 02bf: 11 04 00    ...
	dad	d		;; 02c2: 19          .
	mov	a,m		;; 02c3: 7e          ~
	ani	080h		;; 02c4: e6 80       ..
	jrz	L02cf		;; 02c6: 28 07       (.
L02c8:	mvi	a,001h		;; 02c8: 3e 01       >.
	sta	L1de3		;; 02ca: 32 e3 1d    2..
	jr	L0305		;; 02cd: 18 36       .6

L02cf:	lda	L1de4		;; 02cf: 3a e4 1d    :..
	cpi	05ah		;; 02d2: fe 5a       .Z
	jrnz	L02c8		;; 02d4: 20 f2        .
	mov	a,m		;; 02d6: 7e          ~
	ori	080h		;; 02d7: f6 80       ..
	mov	m,a		;; 02d9: 77          w
	pop	d		;; 02da: d1          .
	push	d		;; 02db: d5          .
	mvi	c,01eh		;; 02dc: 0e 1e       ..
	call	L0cab		;; 02de: cd ab 0c    ...
	xra	a		;; 02e1: af          .
	sta	L1de3		;; 02e2: 32 e3 1d    2..
	jr	L0305		;; 02e5: 18 1e       ..

L02e7:	lda	L1de3		;; 02e7: 3a e3 1d    :..
	ana	a		;; 02ea: a7          .
	jrnz	L0305		;; 02eb: 20 18        .
	pop	d		;; 02ed: d1          .
	push	d		;; 02ee: d5          .
	mvi	c,010h		;; 02ef: 0e 10       ..
	call	L0cab		;; 02f1: cd ab 0c    ...
	pop	h		;; 02f4: e1          .
	push	h		;; 02f5: e5          .
	lxi	d,4		;; 02f6: 11 04 00    ...
	dad	d		;; 02f9: 19          .
	mov	a,m		;; 02fa: 7e          ~
	ani	07fh		;; 02fb: e6 7f       ..
	mov	m,a		;; 02fd: 77          w
	pop	d		;; 02fe: d1          .
	push	d		;; 02ff: d5          .
	mvi	c,01eh		;; 0300: 0e 1e       ..
	call	L0cab		;; 0302: cd ab 0c    ...
L0305:	pop	d		;; 0305: d1          .
	pop	b		;; 0306: c1          .
	pop	h		;; 0307: e1          .
	pop	psw		;; 0308: f1          .
	xra	a		;; 0309: af          .
	ret			;; 030a: c9          .

; heartbeat/randomizer/tick
L030b:	push	psw		;; 030b: f5          .	; 11
	lda	L1474		;; 030c: 3a 74 14    :t.; 13
	dcr	a		;; 030f: 3d          =	; 4
	sta	L1474		;; 0310: 32 74 14    2t.; 13
	pop	psw		;; 0313: f1          .	; 10
	ret			;; 0314: c9          .	; 10 = 61

; conin hook (BIOS intercept)
L0315:	sspd	L2026		;; 0315: ed 73 26 20 .s& 
	lxi	sp,L2136	;; 0319: 31 36 21    16.
	call	L030b	; --L1474
	push	psw		;; 031f: f5          .
	lda	L1db7		;; 0320: 3a b7 1d    :..
	ana	a		;; 0323: a7          .
	jrnz	L034a		;; 0324: 20 24        $
	lda	L1ec8		;; 0326: 3a c8 1e    :..
	cpi	00ah		;; 0329: fe 0a       ..
	jrz	L034a		;; 032b: 28 1d       (.
	cpi	006h		;; 032d: fe 06       ..
	jrz	L034a		;; 032f: 28 19       (.
	cpi	001h		;; 0331: fe 01       ..
	jrz	L034a		;; 0333: 28 15       (.
	lda	L1b95		;; 0335: 3a 95 1b    :..
	ana	a		;; 0338: a7          .
	jrnz	L034a		;; 0339: 20 0f        .
	push	b		;; 033b: c5          .
	push	d		;; 033c: d5          .
	push	h		;; 033d: e5          .
L033e:	mvi	c,063h	; console status check, with net hooks
	call	L0b3c		;; 0340: cd 3c 0b    .<.
	cpi	0ffh		;; 0343: fe ff       ..
	jrnz	L033e		;; 0345: 20 f7        .
	pop	h		;; 0347: e1          .
	pop	d		;; 0348: d1          .
	pop	b		;; 0349: c1          .
L034a:	pop	psw		;; 034a: f1          .
	push	b		;; 034b: c5          .
	push	d		;; 034c: d5          .
	push	h		;; 034d: e5          .
	lda	L1b95	; break char?
	ana	a		;; 0351: a7          .
	jrz	L035c	; conin?
	push	psw		;; 0354: f5          .
	xra	a		;; 0355: af          .
	sta	L1b95		;; 0356: 32 95 1b    2..
	pop	psw		;; 0359: f1          .
	jr	L035f	; return from NDOS?

L035c:	call	00000h	; dyn adr - wboote+7 (bug?) (eventually conin?)
L035f:	pop	h		;; 035f: e1          .
	pop	d		;; 0360: d1          .
	pop	b		;; 0361: c1          .
	lspd	L2026		;; 0362: ed 7b 26 20 .{& 
	ret			;; 0366: c9          .

	; orphan
	push	psw		;; 0367: f5          .
	jmp	L0b4f		;; 0368: c3 4f 0b    .O.

L036b:	mvi	c,00dh		;; 036b: 0e 0d       ..
	call	bdos		;; 036d: cd 05 00    ...
L0370:	lxi	d,L1d0a	; signon banner
	call	msgout		;; 0373: cd 3b 1c    .;.
	call	L191a	; signon tail
	; command loop?
L0379:	xra	a		;; 0379: af          .
	sta	unkn1		;; 037a: 32 08 00    2..
	lda	L1db6		;; 037d: 3a b6 1d    :..
	sta	L1db1		;; 0380: 32 b1 1d    2..
	lda	L1d93		;; 0383: 3a 93 1d    :..
	cpi	0ffh		;; 0386: fe ff       ..
	jrz	L0390		;; 0388: 28 06       (.
	sta	L1da7		;; 038a: 32 a7 1d    2..
	call	L1c0a	; set user no
L0390:	lda	L1d96		;; 0390: 3a 96 1d    :..
	cpi	'0'		;; 0393: fe 30       .0
	jnz	L03df		;; 0395: c2 df 03    ...
	; ???
	lxi	sp,L20de	;; 0398: 31 de 20    1. 
	lda	L1db9		;; 039b: 3a b9 1d    :..
	call	L0527		;; 039e: cd 27 05    .'.
	mov	e,a		;; 03a1: 5f          _
	mvi	c,00eh	; seldsk
	call	bdos		;; 03a4: cd 05 00    ...
	lxi	h,L01d2		;; 03a7: 21 d2 01    ...
	shld	bdos+1		;; 03aa: 22 06 00    "..
	lxi	d,L0379		;; 03ad: 11 79 03    .y.
	lhld	L2034		;; 03b0: 2a 34 20    *4 
	inx	h		;; 03b3: 23          #
	mov	m,e		;; 03b4: 73          s
	inx	h		;; 03b5: 23          #
	mov	m,d		;; 03b6: 72          r
	lhld	L2034		;; 03b7: 2a 34 20    *4 
	shld	wboot+1		;; 03ba: 22 01 00    "..
	lxi	sp,L20de	;; 03bd: 31 de 20    1. 
	xra	a		;; 03c0: af          .
	sta	unkn2+1		;; 03c1: 32 41 00    2A.
	sta	L0a88		;; 03c4: 32 88 0a    2..
	sta	L1de5		;; 03c7: 32 e5 1d    2..
	lxi	d,L1dbf		;; 03ca: 11 bf 1d    ...
	mvi	c,00fh		;; 03cd: 0e 0f       ..
	call	bdos		;; 03cf: cd 05 00    ...
	inr	a		;; 03d2: 3c          <
	sta	L1e9b		;; 03d3: 32 9b 1e    2..
	jr	L03dd		;; 03d6: 18 05       ..

L03d8:	call	L1cfe	; CR/LF
	jr	L0379		;; 03db: 18 9c       ..

L03dd:	jr	L03f9		;; 03dd: 18 1a       ..

L03df:	mvi	a,'0'		;; 03df: 3e 30       >0
	sta	L1d96		;; 03e1: 32 96 1d    2..
	lspd	L1d94		;; 03e4: ed 7b 94 1d .{..
	pop	h		;; 03e8: e1          .
	pop	d		;; 03e9: d1          .
	pop	b		;; 03ea: c1          .
	pop	psw		;; 03eb: f1          .
	ret			;; 03ec: c9          .

L03ed:	db	0dh,0ah,'[XSUB ON]$'

; command loop - prompt and get line
L03f9:	lda	L1d9d		;; 03f9: 3a 9d 1d    :..
	ana	a		;; 03fc: a7          .
	jrz	L0405		;; 03fd: 28 06       (.
	lxi	d,L03ed		;; 03ff: 11 ed 03    ...
	call	msgout		;; 0402: cd 3b 1c    .;.
L0405:	lda	L1db8		;; 0405: 3a b8 1d    :..
	adi	'A'		;; 0408: c6 41       .A
	sta	L1d55		;; 040a: 32 55 1d    2U.
	lda	L1da7		;; 040d: 3a a7 1d    :..
	adi	'0'		;; 0410: c6 30       .0
	sta	L1d57		;; 0412: 32 57 1d    2W.
	lxi	d,L1d52		;; 0415: 11 52 1d    .R.
	call	msgout		;; 0418: cd 3b 1c    .;.
	lda	L1d57		;; 041b: 3a 57 1d    :W.
	cpi	'9'+1		;; 041e: fe 3a       .:
	jrc	L042c		;; 0420: 38 0a       8.
	sui	10		;; 0422: d6 0a       ..
	sta	L1d57		;; 0424: 32 57 1d    2W.
	mvi	e,'1'		;; 0427: 1e 31       .1
	call	L1b9d		;; 0429: cd 9d 1b    ...
L042c:	lxi	d,L1d57		;; 042c: 11 57 1d    .W.
	call	msgout		;; 042f: cd 3b 1c    .;.
	call	L0438		;; 0432: cd 38 04    .8.
	jmp	L0489		;; 0435: c3 89 04    ...

L0438:	lxi	d,defdma	;; 0438: 11 80 00    ...
	call	L1c25		;; 043b: cd 25 1c    .%.
	lxi	h,deffcb	;; 043e: 21 5c 00    .\.
	mvi	a,' '		;; 0441: 3e 20       > 
	mvi	c,32		;; 0443: 0e 20       . 
	call	fill		;; 0445: cd 04 1d    ...
	lxi	h,deffcb+12	;; 0448: 21 68 00    .h.
	mvi	c,4		;; 044b: 0e 04       ..
	xra	a		;; 044d: af          .
	call	fill		;; 044e: cd 04 1d    ...
	lxi	h,deffcb+28	;; 0451: 21 78 00    .x.
	mvi	c,8		;; 0454: 0e 08       ..
	call	fill		;; 0456: cd 04 1d    ...
	sta	deffcb		;; 0459: 32 5c 00    2\.
	sta	deffcb+16	;; 045c: 32 6c 00    2l.
	sta	L1de5		;; 045f: 32 e5 1d    2..
	xra	a		;; 0462: af          .
	sta	L1ff1		;; 0463: 32 f1 1f    2..
	lda	L1d96		;; 0466: 3a 96 1d    :..
	cpi	'1'		;; 0469: fe 31       .1
	jz	L0500		;; 046b: ca 00 05    ...
	xra	a		;; 046e: af          .
	sta	defdma		;; 046f: 32 80 00    2..
	sta	defdma+1	;; 0472: 32 81 00    2..
	ret			;; 0475: c9          .

L0476:	xra	a		;; 0476: af          .
	sta	L1e9b		;; 0477: 32 9b 1e    2..
	dcr	a		;; 047a: 3d          =
	sta	L1de0		;; 047b: 32 e0 1d    2..
	lxi	d,L1dbf		;; 047e: 11 bf 1d    ...
	mvi	c,013h		;; 0481: 0e 13       ..
	call	bdos		;; 0483: cd 05 00    ...
	jmp	L0379		;; 0486: c3 79 03    .y.

L0489:	lxi	d,L1f6f		;; 0489: 11 6f 1f    .o.
	mvi	a,001h		;; 048c: 3e 01       >.
	sta	L1db7		;; 048e: 32 b7 1d    2..
	lda	L1e9b		;; 0491: 3a 9b 1e    :..
	ana	a		;; 0494: a7          .
	jz	L04f9		;; 0495: ca f9 04    ...
	mvi	c,00bh		;; 0498: 0e 0b       ..
	call	bdos		;; 049a: cd 05 00    ...
	ana	a		;; 049d: a7          .
	jrnz	L0476		;; 049e: 20 d6        .
	call	L04a6		;; 04a0: cd a6 04    ...
	jmp	L04fc		;; 04a3: c3 fc 04    ...

L04a6:	lda	L1de0		;; 04a6: 3a e0 1d    :..
	inr	a		;; 04a9: 3c          <
	jrnz	L04bb		;; 04aa: 20 0f        .
	lxi	d,L1dbf		;; 04ac: 11 bf 1d    ...
	mvi	c,023h		;; 04af: 0e 23       .#
	call	L04f5		;; 04b1: cd f5 04    ...
	lda	L1de0		;; 04b4: 3a e0 1d    :..
	dcr	a		;; 04b7: 3d          =
	sta	L1de0		;; 04b8: 32 e0 1d    2..
L04bb:	lxi	d,L1f70		;; 04bb: 11 70 1f    .p.
	mvi	c,01ah		;; 04be: 0e 1a       ..
	call	L04f5		;; 04c0: cd f5 04    ...
	lxi	d,L1dbf		;; 04c3: 11 bf 1d    ...
	mvi	c,021h		;; 04c6: 0e 21       ..
	call	L04f5		;; 04c8: cd f5 04    ...
	lda	L1de0		;; 04cb: 3a e0 1d    :..
	dcr	a		;; 04ce: 3d          =
	sta	L1de0		;; 04cf: 32 e0 1d    2..
	inr	a		;; 04d2: 3c          <
	jrnz	L04e0		;; 04d3: 20 0b        .
	sta	L1e9b		;; 04d5: 32 9b 1e    2..
	lxi	d,L1dbf		;; 04d8: 11 bf 1d    ...
	mvi	c,013h		;; 04db: 0e 13       ..
	call	L04f5		;; 04dd: cd f5 04    ...
L04e0:	lxi	h,L1f71		;; 04e0: 21 71 1f    .q.
	mvi	d,000h		;; 04e3: 16 00       ..
	lda	L1f70		;; 04e5: 3a 70 1f    :p.
	mov	e,a		;; 04e8: 5f          _
	dad	d		;; 04e9: 19          .
	xra	a		;; 04ea: af          .
	mov	m,a		;; 04eb: 77          w
	mvi	a,024h		;; 04ec: 3e 24       >$
	inx	h		;; 04ee: 23          #
	mov	m,a		;; 04ef: 77          w
	lxi	d,L1f71		;; 04f0: 11 71 1f    .q.
	mvi	c,009h		;; 04f3: 0e 09       ..
L04f5:	push	psw		;; 04f5: f5          .
	jmp	L0bb3		;; 04f6: c3 b3 0b    ...

L04f9:	call	L1c62		;; 04f9: cd 62 1c    .b.
L04fc:	xra	a		;; 04fc: af          .
	sta	L1db7		;; 04fd: 32 b7 1d    2..
L0500:	call	L1cfe		;; 0500: cd fe 1c    ...
	lxi	h,L1f70		;; 0503: 21 70 1f    .p.
	mov	a,m		;; 0506: 7e          ~
	ana	a		;; 0507: a7          .
	jz	L03dd		;; 0508: ca dd 03    ...
	push	psw		;; 050b: f5          .
	cpi	002h		;; 050c: fe 02       ..
	jrnz	L0538		;; 050e: 20 28        (
	inx	h		;; 0510: 23          #
	inx	h		;; 0511: 23          #
	mov	a,m		;; 0512: 7e          ~
	cpi	03ah		;; 0513: fe 3a       .:
	jrnz	L0538		;; 0515: 20 21        .
	dcx	h		;; 0517: 2b          +
	mov	a,m		;; 0518: 7e          ~
	sui	041h		;; 0519: d6 41       .A
	sta	L1db9		;; 051b: 32 b9 1d    2..
	call	L0527		;; 051e: cd 27 05    .'.
	jmp	L0379		;; 0521: c3 79 03    .y.

L0524:	lda	L1db9		;; 0524: 3a b9 1d    :..
L0527:	push	psw		;; 0527: f5          .
	mov	b,a		;; 0528: 47          G
	lda	L1da7		;; 0529: 3a a7 1d    :..
	ral			;; 052c: 17          .
	ral			;; 052d: 17          .
	ral			;; 052e: 17          .
	ral			;; 052f: 17          .
	ani	0f0h		;; 0530: e6 f0       ..
	ora	b		;; 0532: b0          .
	sta	usrdsk		;; 0533: 32 04 00    2..
	pop	psw		;; 0536: f1          .
	ret			;; 0537: c9          .

L0538:	pop	psw		;; 0538: f1          .
	mov	e,a		;; 0539: 5f          _
	mvi	d,000h		;; 053a: 16 00       ..
	lxi	h,L1f71		;; 053c: 21 71 1f    .q.
	dad	d		;; 053f: 19          .
	mvi	m,00dh		;; 0540: 36 0d       6.
	lxi	h,L1f71		;; 0542: 21 71 1f    .q.
L0545:	mov	a,m		;; 0545: 7e          ~
	cpi	' '		;; 0546: fe 20       . 
	jrc	L0554		;; 0548: 38 0a       8.
	cpi	'a'		;; 054a: fe 61       .a
	jrc	L0550		;; 054c: 38 02       8.
	ani	0dfh		;; 054e: e6 df       ..
L0550:	mov	m,a		;; 0550: 77          w
	inx	h		;; 0551: 23          #
	jr	L0545		;; 0552: 18 f1       ..

L0554:	lxi	h,L1ff2		;; 0554: 21 f2 1f    ...
	mvi	a,' '		;; 0557: 3e 20       > 
	mvi	c,8		;; 0559: 0e 08       ..
	call	fill		;; 055b: cd 04 1d    ...
	lxi	h,L1ffd		;; 055e: 21 fd 1f    ...
	xra	a		;; 0561: af          .
	mvi	c,23		;; 0562: 0e 17       ..
	call	fill		;; 0564: cd 04 1d    ...
	lxi	h,L1f71		;; 0567: 21 71 1f    .q.
	mov	a,m		;; 056a: 7e          ~
	cpi	056h		;; 056b: fe 56       .V
	jrnz	L0577		;; 056d: 20 08        .
	dcx	h		;; 056f: 2b          +
	mov	a,m		;; 0570: 7e          ~
	cpi	001h		;; 0571: fe 01       ..
	jz	L173d		;; 0573: ca 3d 17    .=.
	inx	h		;; 0576: 23          #
L0577:	mvi	a,'$'		;; 0577: 3e 24       >$
	sta	L1746		;; 0579: 32 46 17    2F.
	lxi	b,L1ff2		;; 057c: 01 f2 1f    ...
L057f:	mov	a,m		;; 057f: 7e          ~
	cpi	' '		;; 0580: fe 20       . 
	jrnz	L0587		;; 0582: 20 03        .
	inx	h		;; 0584: 23          #
	jr	L057f		;; 0585: 18 f8       ..

L0587:	cpi	'A'		;; 0587: fe 41       .A
	jc	L1aac		;; 0589: da ac 1a    ...
	mvi	e,009h		;; 058c: 1e 09       ..
L058e:	mov	a,m		;; 058e: 7e          ~
	cpi	'0'		;; 058f: fe 30       .0
	jrc	L059f		;; 0591: 38 0c       8.
	dcr	e		;; 0593: 1d          .
	jrz	L059b		;; 0594: 28 05       (.
	stax	b		;; 0596: 02          .
	inx	h		;; 0597: 23          #
	inx	b		;; 0598: 03          .
	jr	L058e		;; 0599: 18 f3       ..

L059b:	inr	e		;; 059b: 1c          .
	inx	h		;; 059c: 23          #
	jr	L058e		;; 059d: 18 ef       ..

L059f:	mvi	e,000h		;; 059f: 1e 00       ..
	lxi	b,defdma+1	;; 05a1: 01 81 00    ...
L05a4:	mov	a,m		;; 05a4: 7e          ~
	cpi	00dh		;; 05a5: fe 0d       ..
	jrz	L05af		;; 05a7: 28 06       (.
	stax	b		;; 05a9: 02          .
	inx	h		;; 05aa: 23          #
	inr	e		;; 05ab: 1c          .
	inx	b		;; 05ac: 03          .
	jr	L05a4		;; 05ad: 18 f5       ..

L05af:	xra	a		;; 05af: af          .
	stax	b		;; 05b0: 02          .
	lxi	h,defdma	;; 05b1: 21 80 00    ...
	mov	m,e		;; 05b4: 73          s
	lxi	h,defdma+1	;; 05b5: 21 81 00    ...
	call	L05ef		;; 05b8: cd ef 05    ...
	push	h		;; 05bb: e5          .
	lxi	h,L1de5		;; 05bc: 21 e5 1d    ...
	lxi	d,deffcb	;; 05bf: 11 5c 00    .\.
	lxi	b,16		;; 05c2: 01 10 00    ...
	ldir			;; 05c5: ed b0       ..
	pop	h		;; 05c7: e1          .
	mov	a,m		;; 05c8: 7e          ~
	ana	a		;; 05c9: a7          .
	jz	L068a		;; 05ca: ca 8a 06    ...
	inx	h		;; 05cd: 23          #
	push	h		;; 05ce: e5          .
	lxi	h,L1de5		;; 05cf: 21 e5 1d    ...
	mvi	a,' '		;; 05d2: 3e 20       > 
	mvi	c,16		;; 05d4: 0e 10       ..
	call	fill		;; 05d6: cd 04 1d    ...
	xra	a		;; 05d9: af          .
	sta	L1de5		;; 05da: 32 e5 1d    2..
	pop	h		;; 05dd: e1          .
	call	L05ef		;; 05de: cd ef 05    ...
	lxi	h,L1de5		;; 05e1: 21 e5 1d    ...
	lxi	d,deffcb+16	;; 05e4: 11 6c 00    .l.
	lxi	b,16		;; 05e7: 01 10 00    ...
	ldir			;; 05ea: ed b0       ..
	jmp	L068a		;; 05ec: c3 8a 06    ...

L05ef:	push	h		;; 05ef: e5          .
	lxi	h,L1de5		;; 05f0: 21 e5 1d    ...
	mvi	a,' '		;; 05f3: 3e 20       > 
	mvi	c,12		;; 05f5: 0e 0c       ..
	call	fill		;; 05f7: cd 04 1d    ...
	lxi	h,L1df1		;; 05fa: 21 f1 1d    ...
	xra	a		;; 05fd: af          .
	mvi	c,4		;; 05fe: 0e 04       ..
	call	fill		;; 0600: cd 04 1d    ...
	sta	L1de5		;; 0603: 32 e5 1d    2..
	pop	h		;; 0606: e1          .
	mov	a,m		;; 0607: 7e          ~
	cpi	020h		;; 0608: fe 20       . 
	jnz	L0610		;; 060a: c2 10 06    ...
	inx	h		;; 060d: 23          #
	jr	L05ef		;; 060e: 18 df       ..

L0610:	ana	a		;; 0610: a7          .
	rz			;; 0611: c8          .
	inx	h		;; 0612: 23          #
	mov	a,m		;; 0613: 7e          ~
	cpi	':'		;; 0614: fe 3a       .:
	jrnz	L0622		;; 0616: 20 0a        .
	dcx	h		;; 0618: 2b          +
	mov	a,m		;; 0619: 7e          ~
	sui	'@'		;; 061a: d6 40       .@
	sta	L1de5		;; 061c: 32 e5 1d    2..
	inx	h		;; 061f: 23          #
	inx	h		;; 0620: 23          #
	inx	h		;; 0621: 23          #
L0622:	lxi	b,L1de6		;; 0622: 01 e6 1d    ...
	dcx	h		;; 0625: 2b          +
	mvi	e,009h		;; 0626: 1e 09       ..
L0628:	mov	a,m		;; 0628: 7e          ~
	cpi	02ah		;; 0629: fe 2a       .*
	jrz	L064d		;; 062b: 28 20       ( 
	cpi	024h		;; 062d: fe 24       .$
	jrz	L0641		;; 062f: 28 10       (.
	cpi	030h		;; 0631: fe 30       .0
	jrc	L0656		;; 0633: 38 21       8.
	cpi	05bh		;; 0635: fe 5b       .[
	jrz	L0656		;; 0637: 28 1d       (.
	cpi	03bh		;; 0639: fe 3b       .;
	jrc	L0641		;; 063b: 38 04       8.
	cpi	03fh		;; 063d: fe 3f       .?
	jrc	L0656		;; 063f: 38 15       8.
L0641:	dcr	e		;; 0641: 1d          .
	jrz	L0649		;; 0642: 28 05       (.
	stax	b		;; 0644: 02          .
	inx	h		;; 0645: 23          #
	inx	b		;; 0646: 03          .
	jr	L0628		;; 0647: 18 df       ..

L0649:	inr	e		;; 0649: 1c          .
	inx	h		;; 064a: 23          #
	jr	L0628		;; 064b: 18 db       ..

L064d:	mvi	a,03fh		;; 064d: 3e 3f       >?
L064f:	dcr	e		;; 064f: 1d          .
	jrz	L0649		;; 0650: 28 f7       (.
	stax	b		;; 0652: 02          .
	inx	b		;; 0653: 03          .
	jr	L064f		;; 0654: 18 f9       ..

L0656:	cpi	02eh		;; 0656: fe 2e       ..
	rnz			;; 0658: c0          .
	lxi	b,L1dee		;; 0659: 01 ee 1d    ...
	inx	h		;; 065c: 23          #
	mvi	e,004h		;; 065d: 1e 04       ..
L065f:	mov	a,m		;; 065f: 7e          ~
	cpi	02ah		;; 0660: fe 2a       .*
	jrz	L0681		;; 0662: 28 1d       (.
	cpi	024h		;; 0664: fe 24       .$
	jrz	L0675		;; 0666: 28 0d       (.
	cpi	030h		;; 0668: fe 30       .0
	rc			;; 066a: d8          .
	cpi	05bh		;; 066b: fe 5b       .[
	rz			;; 066d: c8          .
	cpi	03ah		;; 066e: fe 3a       .:
	jrc	L0675		;; 0670: 38 03       8.
	cpi	03fh		;; 0672: fe 3f       .?
	rc			;; 0674: d8          .
L0675:	dcr	e		;; 0675: 1d          .
	jrz	L067d		;; 0676: 28 05       (.
	stax	b		;; 0678: 02          .
	inx	h		;; 0679: 23          #
	inx	b		;; 067a: 03          .
	jr	L065f		;; 067b: 18 e2       ..

L067d:	inr	e		;; 067d: 1c          .
	inx	h		;; 067e: 23          #
	jr	L065f		;; 067f: 18 de       ..

L0681:	mvi	a,03fh		;; 0681: 3e 3f       >?
L0683:	dcr	e		;; 0683: 1d          .
	jrz	L067d		;; 0684: 28 f7       (.
	stax	b		;; 0686: 02          .
	inx	b		;; 0687: 03          .
	jr	L0683		;; 0688: 18 f9       ..

L068a:	lxi	h,L1ff2		;; 068a: 21 f2 1f    ...
	mov	a,m		;; 068d: 7e          ~
	cpi	04ch		;; 068e: fe 4c       .L
	jz	L096d		;; 0690: ca 6d 09    .m.
	push	psw		;; 0693: f5          .
	lda	L1db1		;; 0694: 3a b1 1d    :..
	ani	001h		;; 0697: e6 01       ..
	jz	L06f5		;; 0699: ca f5 06    ...
	pop	psw		;; 069c: f1          .
	cpi	041h		;; 069d: fe 41       .A
	jz	L0709		;; 069f: ca 09 07    ...
	cpi	043h		;; 06a2: fe 43       .C
	jz	L0832		;; 06a4: ca 32 08    .2.
	cpi	044h		;; 06a7: fe 44       .D
	jz	L0882		;; 06a9: ca 82 08    ...
	cpi	045h		;; 06ac: fe 45       .E
	jz	L08ae		;; 06ae: ca ae 08    ...
	cpi	046h		;; 06b1: fe 46       .F
	jz	L08ce		;; 06b3: ca ce 08    ...
	cpi	047h		;; 06b6: fe 47       .G
	jz	L0926		;; 06b8: ca 26 09    .&.
	cpi	048h		;; 06bb: fe 48       .H
	jz	L0940		;; 06bd: ca 40 09    .@.
	cpi	049h		;; 06c0: fe 49       .I
	jz	L0961		;; 06c2: ca 61 09    .a.
	cpi	04fh		;; 06c5: fe 4f       .O
	jz	L09ea		;; 06c7: ca ea 09    ...
	cpi	050h		;; 06ca: fe 50       .P
	jz	L0a0a		;; 06cc: ca 0a 0a    ...
	cpi	051h		;; 06cf: fe 51       .Q
	jz	L0a40		;; 06d1: ca 40 0a    .@.
	cpi	052h		;; 06d4: fe 52       .R
	jz	L0a89		;; 06d6: ca 89 0a    ...
	cpi	053h		;; 06d9: fe 53       .S
	jz	L15a2		;; 06db: ca a2 15    ...
	cpi	054h		;; 06de: fe 54       .T
	jz	L169e		;; 06e0: ca 9e 16    ...
	cpi	055h		;; 06e3: fe 55       .U
	jz	L16fc		;; 06e5: ca fc 16    ...
	cpi	057h		;; 06e8: fe 57       .W
	jz	L174c		;; 06ea: ca 4c 17    .L.
	cpi	058h		;; 06ed: fe 58       .X
	jz	L1778		;; 06ef: ca 78 17    .x.
	jmp	L17b2		;; 06f2: c3 b2 17    ...

L06f5:	lxi	d,L06fb		;; 06f5: 11 fb 06    ...
	jmp	L0761		;; 06f8: c3 61 07    .a.

L06fb:	db	'?Login please$'
L0709:	inx	h		;; 0709: 23          #
	mov	a,m		;; 070a: 7e          ~
	cpi	053h		;; 070b: fe 53       .S
	jnz	L17b2		;; 070d: c2 b2 17    ...
	inx	h		;; 0710: 23          #
	mov	a,m		;; 0711: 7e          ~
	cpi	053h		;; 0712: fe 53       .S
	jrz	L0719		;; 0714: 28 03       (.
	jmp	L17b2		;; 0716: c3 b2 17    ...

L0719:	lxi	h,L1f74		;; 0719: 21 74 1f    .t.
	lxi	d,L082e		;; 071c: 11 2e 08    ...
	call	L1794		;; 071f: cd 94 17    ...
	lda	deffcb		;; 0722: 3a 5c 00    :\.
	ana	a		;; 0725: a7          .
	jrz	L0767		;; 0726: 28 3f       (?
	ani	0f0h		;; 0728: e6 f0       ..
	jrnz	L0767		;; 072a: 20 3b        ;
	lda	deffcb		;; 072c: 3a 5c 00    :\.
	call	L0de0		;; 072f: cd e0 0d    ...
	lda	deffcb+16	;; 0732: 3a 6c 00    :l.
	mov	m,a		;; 0735: 77          w
	inx	h		;; 0736: 23          #
	lda	deffcb+17	;; 0737: 3a 6d 00    :m.
	push	h		;; 073a: e5          .
	lxi	h,L1d2d		;; 073b: 21 2d 1d    .-.
	cmp	m		;; 073e: be          .
	pop	h		;; 073f: e1          .
	jrz	L0746		;; 0740: 28 04       (.
	cpi	' '		;; 0742: fe 20       . 
	jrnz	L074a		;; 0744: 20 04        .
L0746:	mvi	a,'0'		;; 0746: 3e 30       >0
	jr	L0753		;; 0748: 18 09       ..

L074a:	push	psw		;; 074a: f5          .
	lda	deffcb+16	;; 074b: 3a 6c 00    :l.
	ana	a		;; 074e: a7          .
	jz	L1af3		;; 074f: ca f3 1a    ...
	pop	psw		;; 0752: f1          .
L0753:	sui	030h		;; 0753: d6 30       .0
	mov	m,a		;; 0755: 77          w
	lda	deffcb		;; 0756: 3a 5c 00    :\.
	adi	040h		;; 0759: c6 40       .@
	sta	L0822		;; 075b: 32 22 08    2".
	lxi	d,L081b		;; 075e: 11 1b 08    ...
L0761:	call	msgout		;; 0761: cd 3b 1c    .;.
	jmp	L03d8		;; 0764: c3 d8 03    ...

L0767:	lda	deffcb+1	;; 0767: 3a 5d 00    :].
	cpi	' '		;; 076a: fe 20       . 
	jz	L0804		;; 076c: ca 04 08    ...
	cpi	'L'		;; 076f: fe 4c       .L
	jnz	L0804		;; 0771: c2 04 08    ...
	lda	deffcb+4	;; 0774: 3a 60 00    :`.
	cpi	':'		;; 0777: fe 3a       .:
	jnz	L0804		;; 0779: c2 04 08    ...
	lxi	h,deffcb+16	;; 077c: 21 6c 00    .l.
	mov	a,m		;; 077f: 7e          ~
	ana	a		;; 0780: a7          .
	jrnz	L0788		;; 0781: 20 05        .
	lda	L1db8		;; 0783: 3a b8 1d    :..
	inr	a		;; 0786: 3c          <
	mov	m,a		;; 0787: 77          w
L0788:	lxi	d,L07df		;; 0788: 11 df 07    ...
	lxi	b,16		;; 078b: 01 10 00    ...
	ldir			;; 078e: ed b0       ..
	lxi	h,L07ef		;; 0790: 21 ef 07    ...
	mvi	c,18		;; 0793: 0e 12       ..
	xra	a		;; 0795: af          .
	call	fill		;; 0796: cd 04 1d    ...
	sta	L0803		;; 0799: 32 03 08    2..
	lxi	d,L07df		;; 079c: 11 df 07    ...
	mvi	c,011h		;; 079f: 0e 11       ..
	call	bdos		;; 07a1: cd 05 00    ...
	inr	a		;; 07a4: 3c          <
	jrnz	L07cc		;; 07a5: 20 25        %
	lxi	d,L07df		;; 07a7: 11 df 07    ...
	mvi	c,016h		;; 07aa: 0e 16       ..
	call	bdos		;; 07ac: cd 05 00    ...
	inr	a		;; 07af: 3c          <
	jrz	L07c7		;; 07b0: 28 15       (.
	lxi	d,L07c1		;; 07b2: 11 c1 07    ...
	call	msgout		;; 07b5: cd 3b 1c    .;.
	lxi	h,L07df		;; 07b8: 21 df 07    ...
	call	L1b3c		;; 07bb: cd 3c 1b    .<.
	jmp	L03d8		;; 07be: c3 d8 03    ...

L07c1:	db	'LST:=$'
L07c7:	lxi	d,L09e1		;; 07c7: 11 e1 09    ...
	jr	L07cc+1		;; 07ca: 18 01       ..

L07cc:	lxi	d,L1d7d		;; 07cc: 11 7d 1d    .}.
	call	msgout		;; 07cf: cd 3b 1c    .;.
	lxi	h,L07df		;; 07d2: 21 df 07    ...
	call	L1b3c		;; 07d5: cd 3c 1b    .<.
	xra	a		;; 07d8: af          .
	sta	L07e0		;; 07d9: 32 e0 07    2..
	jmp	L03d8		;; 07dc: c3 d8 03    ...

L07df:	db	0
L07e0:	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
L07ef:	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
L0803:	db	0
L0804:	lxi	d,L080a		;; 0804: 11 0a 08    ...
	jmp	L0761		;; 0807: c3 61 07    .a.

L080a:	db	'?Bad logical dev$'
L081b:	db	'Device '
L0822:	db	'X: assigned$'
L082e:	db	'IGN '
L0832:	inx	h		;; 0832: 23          #
	mov	a,m		;; 0833: 7e          ~
	cpi	04fh		;; 0834: fe 4f       .O
	jrz	L083b		;; 0836: 28 03       (.
	jmp	L17b2		;; 0838: c3 b2 17    ...

L083b:	inx	h		;; 083b: 23          #
	mov	a,m		;; 083c: 7e          ~
	cpi	052h		;; 083d: fe 52       .R
	jrz	L0848		;; 083f: 28 07       (.
	cpi	050h		;; 0841: fe 50       .P
	jrz	L0863		;; 0843: 28 1e       (.
	jmp	L17b2		;; 0845: c3 b2 17    ...

L0848:	lxi	h,L1f74		;; 0848: 21 74 1f    .t.
	lxi	d,L0854		;; 084b: 11 54 08    .T.
	call	L1794		;; 084e: cd 94 17    ...
	jmp	L089d		;; 0851: c3 9d 08    ...

L0854:	dw	L2045
L0856:	lxi	d,L1ff2		;; 0856: 11 f2 1f    ...
	lxi	b,8		;; 0859: 01 08 00    ...
	ldir			;; 085c: ed b0       ..
	jmp	L17b2		;; 085e: c3 b2 17    ...

L0861:	dw	L2059
L0863:	lxi	h,L1f74		;; 0863: 21 74 1f    .t.
	lxi	d,L0861		;; 0866: 11 61 08    .a.
	call	L1794		;; 0869: cd 94 17    ...
	lda	deffcb+17	;; 086c: 3a 6d 00    :m.
	cpi	020h		;; 086f: fe 20       . 
	jz	L1af3		;; 0871: ca f3 1a    ...
	lxi	h,L087a		;; 0874: 21 7a 08    .z.
	jmp	L0856		;; 0877: c3 56 08    .V.

L087a:	db	'PIP     '

L0882:	inx	h		;; 0882: 23          #
	mov	a,m		;; 0883: 7e          ~
	cpi	'I'		;; 0884: fe 49       .I
	jz	L0894		;; 0886: ca 94 08    ...
	jmp	L17b2		;; 0889: c3 b2 17    ...

L088c:	db	'RECTORY '

L0894:	lxi	h,L1f73		;; 0894: 21 73 1f    .s.
	lxi	d,L088c		;; 0897: 11 8c 08    ...
	call	L1794		;; 089a: cd 94 17    ...
L089d:	lxi	h,L08a3		;; 089d: 21 a3 08    ...
	jmp	L0856		;; 08a0: c3 56 08    .V.

L08a3:	db	'UTIL    IT '

L08ae:	inx	h		;; 08ae: 23          #
	mov	a,m		;; 08af: 7e          ~
	cpi	'R'		;; 08b0: fe 52       .R
	jz	L08b8		;; 08b2: ca b8 08    ...
	jmp	L17b2		;; 08b5: c3 b2 17    ...

L08b8:	lxi	h,L1f73		;; 08b8: 21 73 1f    .s.
	lxi	d,L08c4		;; 08bb: 11 c4 08    ...
	call	L1794		;; 08be: cd 94 17    ...
	jmp	L089d		;; 08c1: c3 9d 08    ...

L08c4:	db	'ASE '
L08c8:	db	'INISH '
L08ce:	lxi	h,L1f72		;; 08ce: 21 72 1f    .r.
	lxi	d,L08c8		;; 08d1: 11 c8 08    ...
	call	L1794		;; 08d4: cd 94 17    ...
	lda	L07e0		;; 08d7: 3a e0 07    :..
	ana	a		;; 08da: a7          .
	jz	L0379		;; 08db: ca 79 03    .y.
	lxi	b,L0305		;; 08de: 01 05 03    ...
L08e1:	push	b		;; 08e1: c5          .
	mvi	e,01ah		;; 08e2: 1e 1a       ..
	call	bdos		;; 08e4: cd 05 00    ...
	pop	b		;; 08e7: c1          .
	djnz	L08e1		;; 08e8: 10 f7       ..
	mvi	a,07fh		;; 08ea: 3e 7f       >.
	sta	L0803		;; 08ec: 32 03 08    2..
	mvi	e,01ah		;; 08ef: 1e 1a       ..
	mvi	c,005h		;; 08f1: 0e 05       ..
	call	bdos		;; 08f3: cd 05 00    ...
	lxi	d,L07df		;; 08f6: 11 df 07    ...
	mvi	c,010h		;; 08f9: 0e 10       ..
	call	bdos		;; 08fb: cd 05 00    ...
	lxi	d,L0911		;; 08fe: 11 11 09    ...
	call	msgout		;; 0901: cd 3b 1c    .;.
	lxi	h,L07df		;; 0904: 21 df 07    ...
	call	L1b3c		;; 0907: cd 3c 1b    .<.
	xra	a		;; 090a: af          .
	sta	L07e0		;; 090b: 32 e0 07    2..
	jmp	L03d8		;; 090e: c3 d8 03    ...

L0911:	db	'LST: file closed as $'
L0926:	lxi	h,L1f72		;; 0926: 21 72 1f    .r.
	lxi	d,L093d		;; 0929: 11 3d 09    .=.
	call	L1794		;; 092c: cd 94 17    ...
	lxi	h,deffcb	;; 092f: 21 5c 00    .\.
	lxi	d,L1ff1		;; 0932: 11 f1 1f    ...
	lxi	b,9		;; 0935: 01 09 00    ...
	ldir			;; 0938: ed b0       ..
	jmp	L17bc		;; 093a: c3 bc 17    ...

L093d:	db	'ET '
L0940:	lxi	h,L1f72		;; 0940: 21 72 1f    .r.
	lxi	d,L0951		;; 0943: 11 51 09    .Q.
	call	L1794		;; 0946: cd 94 17    ...
	lxi	h,L094f		;; 0949: 21 4f 09    .O.
	jmp	L0856		;; 094c: c3 56 08    .V.

L094f:	db	'OH'
L0951:	db	'ELP   '
L0957:	db	'NITIALIZE '
L0961:	lxi	h,L1f72		;; 0961: 21 72 1f    .r.
	lxi	d,L0957		;; 0964: 11 57 09    .W.
	call	L1794		;; 0967: cd 94 17    ...
	jmp	L036b		;; 096a: c3 6b 03    .k.

L096d:	inx	h		;; 096d: 23          #
	mov	a,m		;; 096e: 7e          ~
	cpi	04fh		;; 096f: fe 4f       .O
	jrz	L097e		;; 0971: 28 0b       (.
	lda	L1db1		;; 0973: 3a b1 1d    :..
	ani	001h		;; 0976: e6 01       ..
	jz	L06f5		;; 0978: ca f5 06    ...
	jmp	L17b2		;; 097b: c3 b2 17    ...

L097e:	inx	h		;; 097e: 23          #
	mov	a,m		;; 097f: 7e          ~
	cpi	047h		;; 0980: fe 47       .G
	jrz	L0995		;; 0982: 28 11       (.
	lda	L1db1		;; 0984: 3a b1 1d    :..
	ani	001h		;; 0987: e6 01       ..
	jz	L06f5		;; 0989: ca f5 06    ...
	mov	a,m		;; 098c: 7e          ~
	cpi	043h		;; 098d: fe 43       .C
	jz	L1768		;; 098f: ca 68 17    .h.
	jmp	L17b2		;; 0992: c3 b2 17    ...

L0995:	lxi	h,L099b		;; 0995: 21 9b 09    ...
	jmp	L0856		;; 0998: c3 56 08    .V.

L099b:	db	'LOG     '
L09a3:	lxi	d,L09a9		;; 09a3: 11 a9 09    ...
	jmp	L0761		;; 09a6: c3 61 07    .a.

L09a9:	db	'?Bad user #$'
L09b5:	xra	a		;; 09b5: af          .
	sta	L1da5		;; 09b6: 32 a5 1d    2..
	sta	L1d9d		;; 09b9: 32 9d 1d    2..
	sta	L1da4		;; 09bc: 32 a4 1d    2..
	sta	L1db1		;; 09bf: 32 b1 1d    2..
	sta	L1db6		;; 09c2: 32 b6 1d    2..
	lxi	h,L1e9c		;; 09c5: 21 9c 1e    ...
	mvi	c,' '		;; 09c8: 0e 20       . 
L09ca:	mov	m,a		;; 09ca: 77          w
	inx	h		;; 09cb: 23          #
	dcr	c		;; 09cc: 0d          .
	jnz	L09ca		;; 09cd: c2 ca 09    ...
	mvi	a,001h		;; 09d0: 3e 01       >.
	sta	L1e9e		;; 09d2: 32 9e 1e    2..
	inr	a		;; 09d5: 3c          <
	sta	L1ea0		;; 09d6: 32 a0 1e    2..
	pop	psw		;; 09d9: f1          .
	ret			;; 09da: c9          .

L09db:	lxi	d,L09e1		;; 09db: 11 e1 09    ...
	jmp	L0761		;; 09de: c3 61 07    .a.

L09e1:	db	'?No room$'
L09ea:	inx	h		;; 09ea: 23          #
	mov	a,m		;; 09eb: 7e          ~
	cpi	056h		;; 09ec: fe 56       .V
	jnz	L17b2		;; 09ee: c2 b2 17    ...
	inx	h		;; 09f1: 23          #
	mov	a,m		;; 09f2: 7e          ~
	cpi	04fh		;; 09f3: fe 4f       .O
	jnz	L17b2		;; 09f5: c2 b2 17    ...
	inx	h		;; 09f8: 23          #
	mov	a,m		;; 09f9: 7e          ~
	cpi	04eh		;; 09fa: fe 4e       .N
	jz	L0a04		;; 09fc: ca 04 0a    ...
	cpi	046h		;; 09ff: fe 46       .F
	jnz	L17b2		;; 0a01: c2 b2 17    ...
L0a04:	sta	L1da6		;; 0a04: 32 a6 1d    2..
	jmp	L03d8		;; 0a07: c3 d8 03    ...

L0a0a:	inx	h		;; 0a0a: 23          #
	mov	a,m		;; 0a0b: 7e          ~
	cpi	052h		;; 0a0c: fe 52       .R
	jz	L0a1a		;; 0a0e: ca 1a 0a    ...
	jmp	L17b2		;; 0a11: c3 b2 17    ...

L0a14:	call	L191a	; signon tail
	jmp	L03dd		;; 0a17: c3 dd 03    ...

L0a1a:	inx	h		;; 0a1a: 23          #
	mov	a,m		;; 0a1b: 7e          ~
	cpi	04fh		;; 0a1c: fe 4f       .O
	jnz	L17b2		;; 0a1e: c2 b2 17    ...
	lxi	h,L1f74		;; 0a21: 21 74 1f    .t.
	lxi	d,L0a2d		;; 0a24: 11 2d 0a    .-.
	call	L1794		;; 0a27: cd 94 17    ...
	jmp	L089d		;; 0a2a: c3 9d 08    ...

L0a2d:	db	'TECT '
L0a32:	lxi	h,L0a38		;; 0a32: 21 38 0a    .8.
	jmp	L0856		;; 0a35: c3 56 08    .V.

L0a38:	db	'QUEUE   '
L0a40:	inx	h		;; 0a40: 23          #
	mov	a,m		;; 0a41: 7e          ~
	cpi	055h		;; 0a42: fe 55       .U
	jz	L0a78		;; 0a44: ca 78 0a    .x.
	cpi	04fh		;; 0a47: fe 4f       .O
	jnz	L17b2		;; 0a49: c2 b2 17    ...
	inx	h		;; 0a4c: 23          #
	mov	a,m		;; 0a4d: 7e          ~
	cpi	04eh		;; 0a4e: fe 4e       .N
	jz	L0a71		;; 0a50: ca 71 0a    .q.
	cpi	046h		;; 0a53: fe 46       .F
	jnz	L17b2		;; 0a55: c2 b2 17    ...
	lda	L203e		;; 0a58: 3a 3e 20    :> 
	cpi	020h		;; 0a5b: fe 20       . 
	jnz	L0a68		;; 0a5d: c2 68 0a    .h.
	mvi	a,001h		;; 0a60: 3e 01       >.
	sta	L1d9e		;; 0a62: 32 9e 1d    2..
	jmp	L0379		;; 0a65: c3 79 03    .y.

L0a68:	lxi	d,L11e2		;; 0a68: 11 e2 11    ...
	call	msgout		;; 0a6b: cd 3b 1c    .;.
	jmp	L0379		;; 0a6e: c3 79 03    .y.

L0a71:	xra	a		;; 0a71: af          .
	sta	L1d9e		;; 0a72: 32 9e 1d    2..
	jmp	L0379		;; 0a75: c3 79 03    .y.

L0a78:	lxi	h,L1f73		;; 0a78: 21 73 1f    .s.
	lxi	d,L0a84		;; 0a7b: 11 84 0a    ...
	call	L1794		;; 0a7e: cd 94 17    ...
	jmp	L0a32		;; 0a81: c3 32 0a    .2.

L0a84:	db	'EUE '
L0a88:	db	0
L0a89:	inx	h		;; 0a89: 23          #
	mov	a,m		;; 0a8a: 7e          ~
	cpi	020h		;; 0a8b: fe 20       . 
	jz	L0a9d		;; 0a8d: ca 9d 0a    ...
	cpi	045h		;; 0a90: fe 45       .E
	jz	L0b21		;; 0a92: ca 21 0b    ...
	cpi	055h		;; 0a95: fe 55       .U
	jz	L0af9		;; 0a97: ca f9 0a    ...
	jmp	L17b2		;; 0a9a: c3 b2 17    ...

L0a9d:	lda	deffcb+1	;; 0a9d: 3a 5d 00    :].
	cpi	020h		;; 0aa0: fe 20       . 
	jz	L1af3		;; 0aa2: ca f3 1a    ...
	lda	deffcb		;; 0aa5: 3a 5c 00    :\.
	sta	L202a		;; 0aa8: 32 2a 20    2* 
	call	L0438		;; 0aab: cd 38 04    .8.
	xra	a		;; 0aae: af          .
	sta	L18b5		;; 0aaf: 32 b5 18    2..
	lda	L202a		;; 0ab2: 3a 2a 20    :* 
	sta	L1ff1		;; 0ab5: 32 f1 1f    2..
	inr	a		;; 0ab8: 3c          <
	sta	L0a88		;; 0ab9: 32 88 0a    2..
L0abc:	lda	L1f70		;; 0abc: 3a 70 1f    :p.
	mov	c,a		;; 0abf: 4f          O
	lxi	h,L1f71		;; 0ac0: 21 71 1f    .q.
L0ac3:	inx	h		;; 0ac3: 23          #
	dcr	c		;; 0ac4: 0d          .
	mov	a,m		;; 0ac5: 7e          ~
	cpi	020h		;; 0ac6: fe 20       . 
	jnz	L0ac3		;; 0ac8: c2 c3 0a    ...
	push	b		;; 0acb: c5          .
	inx	h		;; 0acc: 23          #
	lxi	d,L1f71		;; 0acd: 11 71 1f    .q.
	mvi	b,000h		;; 0ad0: 06 00       ..
	ldir			;; 0ad2: ed b0       ..
	pop	b		;; 0ad4: c1          .
	mov	a,c		;; 0ad5: 79          y
	sta	L1f70		;; 0ad6: 32 70 1f    2p.
	lda	L1f72		;; 0ad9: 3a 72 1f    :r.
	cpi	03ah		;; 0adc: fe 3a       .:
	jnz	L0500		;; 0ade: c2 00 05    ...
	lda	L1f70		;; 0ae1: 3a 70 1f    :p.
	dcr	a		;; 0ae4: 3d          =
	dcr	a		;; 0ae5: 3d          =
	sta	L1f70		;; 0ae6: 32 70 1f    2p.
	mov	c,a		;; 0ae9: 4f          O
	mvi	b,000h		;; 0aea: 06 00       ..
	lxi	h,L1f73		;; 0aec: 21 73 1f    .s.
	lxi	d,L1f71		;; 0aef: 11 71 1f    .q.
	ldir			;; 0af2: ed b0       ..
	jmp	L0500		;; 0af4: c3 00 05    ...

L0af7:	db	'N '
L0af9:	lxi	h,L1f73		;; 0af9: 21 73 1f    .s.
	lxi	d,L0af7		;; 0afc: 11 f7 0a    ...
	call	L1794		;; 0aff: cd 94 17    ...
	lda	deffcb+1	;; 0b02: 3a 5d 00    :].
	cpi	020h		;; 0b05: fe 20       . 
	jz	L1af3		;; 0b07: ca f3 1a    ...
	lda	deffcb		;; 0b0a: 3a 5c 00    :\.
	sta	L202a		;; 0b0d: 32 2a 20    2* 
	call	L0438		;; 0b10: cd 38 04    .8.
	lda	L202a		;; 0b13: 3a 2a 20    :* 
	sta	L1ff1		;; 0b16: 32 f1 1f    2..
	mvi	a,001h		;; 0b19: 3e 01       >.
	sta	L18b5		;; 0b1b: 32 b5 18    2..
	jmp	L0abc		;; 0b1e: c3 bc 0a    ...

L0b21:	inx	h		;; 0b21: 23          #
	mov	a,m		;; 0b22: 7e          ~
	cpi	04eh		;; 0b23: fe 4e       .N
	jz	L0b2f		;; 0b25: ca 2f 0b    ./.
	jmp	L17b2		;; 0b28: c3 b2 17    ...

L0b2b:	db	'AME '

L0b2f:	lxi	h,L1f74		;; 0b2f: 21 74 1f    .t.
	lxi	d,L0b2b		;; 0b32: 11 2b 0b    .+.
	call	L1794		;; 0b35: cd 94 17    ...
	jmp	L089d		;; 0b38: c3 9d 08    ...

	db	0

L0b3c:	call	L030b	; --L1474
	push	psw		;; 0b3f: f5          .
	lda	L1d9e		;; 0b40: 3a 9e 1d    :..
	ana	a		;; 0b43: a7          .
	jnz	L0b4f		;; 0b44: c2 4f 0b    .O.
	lda	L203e		;; 0b47: 3a 3e 20    :> 
	cpi	020h		;; 0b4a: fe 20       . 
	jnz	L195c		;; 0b4c: c2 5c 19    .\.
L0b4f:	xra	a		;; 0b4f: af          .
	sta	L0dcf		;; 0b50: 32 cf 0d    2..
	lda	L1db7		;; 0b53: 3a b7 1d    :..
	; see if anything recv'd
@is02:	in	011h		;; 0b56: db 11       ..
@rxm0:	ani	002h		;; 0b58: e6 02       ..
	jz	L0bb3	; nothing, continue on
@id01:	in	010h		;; 0b5d: db 10       ..
	cpi	002h	; STX
	jnz	L0bb3	; not STX, continue on
	; spontaneous msg arriving?
	push	h		;; 0b64: e5          .
	push	d		;; 0b65: d5          .
	push	b		;; 0b66: c5          .
L0b67:	call	L1340		;; 0b67: cd 40 13    .@.
	cpi	002h	; STX
	jz	L0b67	; gobble all STXs
	lxi	d,512		;; 0b6f: 11 00 02    ...
	sded	@rto0+1		;; 0b72: ed 53 7a 13 .Sz.
	call	L13a8	; A = first char, get message in L2138
	lxi	d,15*512	;; 0b79: 11 00 1e    ...
	sded	@rto0+1		;; 0b7c: ed 53 7a 13 .Sz.
	pop	b		;; 0b80: c1          .
	pop	d		;; 0b81: d1          .
	pop	h		;; 0b82: e1          .
	lda	L2137		;; 0b83: 3a 37 21    :7.
	ana	a		;; 0b86: a7          .
	jnz	L0bb3	; still waiting...
	lda	L1db7		;; 0b8a: 3a b7 1d    :..
	cpi	001h		;; 0b8d: fe 01       ..
	jz	L0b99		;; 0b8f: ca 99 0b    ...
	lda	L1da2		;; 0b92: 3a a2 1d    :..
	ana	a		;; 0b95: a7          .
	jnz	L0ba1		;; 0b96: c2 a1 0b    ...
L0b99:	lda	L2138+7		;; 0b99: 3a 3f 21    :?.
	cpi	004h		;; 0b9c: fe 04       ..
	jz	L1420		;; 0b9e: ca 20 14    . .
L0ba1:	lda	L2138+7		;; 0ba1: 3a 3f 21    :?.
	cpi	066h		;; 0ba4: fe 66       .f
	jz	L0df0		;; 0ba6: ca f0 0d    ...
	cpi	06bh		;; 0ba9: fe 6b       .k
	jz	L0d31		;; 0bab: ca 31 0d    .1.
L0bae:	cpi	064h		;; 0bae: fe 64       .d
	cz	L0e8f		;; 0bb0: cc 8f 0e    ...
; continue after receive? FNC in C
L0bb3:	mov	a,c		;; 0bb3: 79          y
	cpi	063h		;; 0bb4: fe 63       .c
	jz	L0dd0		;; 0bb6: ca d0 0d    ...
	cpi	002h	; convert BDOS fnc 2 into 6
	jrnz	L0bc0		;; 0bbb: 20 03        .
	mvi	a,006h		;; 0bbd: 3e 06       >.
	mov	c,a		;; 0bbf: 4f          O
L0bc0:	sta	L1ec8		;; 0bc0: 32 c8 1e    2..
	sta	L1d9c		;; 0bc3: 32 9c 1d    2..
	mov	a,c		;; 0bc6: 79          y
	cpi	001h		;; 0bc7: fe 01       ..
	jz	L1c4d		;; 0bc9: ca 4d 1c    .M.
	cpi	006h		;; 0bcc: fe 06       ..
	jz	L1b96		;; 0bce: ca 96 1b    ...
	cpi	009h		;; 0bd1: fe 09       ..
	jz	L1c3a		;; 0bd3: ca 3a 1c    .:.
	cpi	00ah		;; 0bd6: fe 0a       ..
	jnz	L0bfb		;; 0bd8: c2 fb 0b    ...
	; BDOS func 10
	lda	L1e9b		;; 0bdb: 3a 9b 1e    :..
	ana	a		;; 0bde: a7          .
	jz	L1c61		;; 0bdf: ca 61 1c    .a.
	lda	L1d9d		;; 0be2: 3a 9d 1d    :..
	ana	a		;; 0be5: a7          .
	jz	L1c61		;; 0be6: ca 61 1c    .a.
	push	d		;; 0be9: d5          .
	call	L04a6		;; 0bea: cd a6 04    ...
	pop	d		;; 0bed: d1          .
	ldax	d		;; 0bee: 1a          .
	mov	c,a		;; 0bef: 4f          O
	mvi	b,000h		;; 0bf0: 06 00       ..
	inx	b		;; 0bf2: 03          .
	inx	d		;; 0bf3: 13          .
	lxi	h,L1f70		;; 0bf4: 21 70 1f    .p.
	ldir			;; 0bf7: ed b0       ..
	pop	psw		;; 0bf9: f1          .
	ret			;; 0bfa: c9          .

; execute BDOS/NDOS function in A - not 1,6,9,10
L0bfb:	cpi	005h		;; 0bfb: fe 05       ..
	jz	L0d82		;; 0bfd: ca 82 0d    ...
	cpi	00eh		;; 0c00: fe 0e       ..
	jz	L0e54		;; 0c02: ca 54 0e    .T.
	cpi	019h		;; 0c05: fe 19       ..
	jz	L0e8a		;; 0c07: ca 8a 0e    ...
	cpi	00fh		;; 0c0a: fe 0f       ..
	jc	L0c14		;; 0c0c: da 14 0c    ...
	cpi	018h		;; 0c0f: fe 18       ..
	jc	L0f58		;; 0c11: da 58 0f    .X.
L0c14:	cpi	01eh		;; 0c14: fe 1e       ..
	jz	L0f58		;; 0c16: ca 58 0f    .X.
	cpi	025h		;; 0c19: fe 25       .%
	jnc	L0c23		;; 0c1b: d2 23 0c    .#.
	cpi	021h		;; 0c1e: fe 21       ..
	jnc	L0f58		;; 0c20: d2 58 0f    .X.
L0c23:	cpi	028h		;; 0c23: fe 28       .(
	jz	L0f58		;; 0c25: ca 58 0f    .X.
	cpi	062h		;; 0c28: fe 62       .b
	jz	L0d27		;; 0c2a: ca 27 0d    .'.
	cpi	064h		;; 0c2d: fe 64       .d
	jz	L1598		;; 0c2f: ca 98 15    ...
	cpi	065h		;; 0c32: fe 65       .e
	jz	L0370		;; 0c34: ca 70 03    .p.
	cpi	066h		;; 0c37: fe 66       .f
	jz	L09b5		;; 0c39: ca b5 09    ...
	cpi	067h		;; 0c3c: fe 67       .g
	jz	L159d		;; 0c3e: ca 9d 15    ...
	cpi	068h		;; 0c41: fe 68       .h
	jz	L1575		;; 0c43: ca 75 15    .u.
	cpi	069h		;; 0c46: fe 69       .i
	jz	L0d22		;; 0c48: ca 22 0d    .".
	cpi	077h		;; 0c4b: fe 77       .w
	jz	L12a0		;; 0c4d: ca a0 12    ...
	cpi	078h		;; 0c50: fe 78       .x
	jz	L132f		;; 0c52: ca 2f 13    ./.
	cpi	07bh		;; 0c55: fe 7b       .{
	jz	L1337		;; 0c57: ca 37 13    .7.
	cpi	07ch		;; 0c5a: fe 7c       .|
	jz	L1493	; send msg
	cpi	07dh		;; 0c5f: fe 7d       .}
	jz	L136c		;; 0c61: ca 6c 13    .l.
	cpi	07eh		;; 0c64: fe 7e       .~
	jz	L0ddf		;; 0c66: ca df 0d    ...
	cpi	07fh		;; 0c69: fe 7f       ..
	jz	L0e4e		;; 0c6b: ca 4e 0e    .N.
	cpi	080h		;; 0c6e: fe 80       ..
	jz	L0dd4		;; 0c70: ca d4 0d    ...
	cpi	081h		;; 0c73: fe 81       ..
	jz	L0dd9		;; 0c75: ca d9 0d    ...
	cpi	01ah		;; 0c78: fe 1a       ..
	jnz	L0c81		;; 0c7a: c2 81 0c    ...
	sded	L1d97		;; 0c7d: ed 53 97 1d .S..
L0c81:	cpi	020h		;; 0c81: fe 20       . 
	jnz	L0caa		;; 0c83: c2 aa 0c    ...
	lda	L1db1		;; 0c86: 3a b1 1d    :..
	ani	002h		;; 0c89: e6 02       ..
	jnz	L0c98		;; 0c8b: c2 98 0c    ...
	lda	L1da7		;; 0c8e: 3a a7 1d    :..
	cmp	e		;; 0c91: bb          .
	jnz	L0ca4		;; 0c92: c2 a4 0c    ...
	jmp	L0caa		;; 0c95: c3 aa 0c    ...

L0c98:	mov	a,e		;; 0c98: 7b          {
	cpi	0ffh		;; 0c99: fe ff       ..
	jz	L0caa		;; 0c9b: ca aa 0c    ...
	sta	L1da7		;; 0c9e: 32 a7 1d    2..
	jmp	L0caa		;; 0ca1: c3 aa 0c    ...

L0ca4:	mov	a,e		;; 0ca4: 7b          {
	cpi	0ffh		;; 0ca5: fe ff       ..
	jnz	L1902		;; 0ca7: c2 02 19    ...
L0caa:	pop	psw		;; 0caa: f1          .
L0cab:	push	h		;; 0cab: e5          .
	push	psw		;; 0cac: f5          .
	lda	L0dcf	; recursing flag?
	ana	a		;; 0cb0: a7          .
	jnz	L0cb8		;; 0cb1: c2 b8 0c    ...
	mov	a,c		;; 0cb4: 79          y
	sta	L1ec8		;; 0cb5: 32 c8 1e    2..
L0cb8:	xra	a		;; 0cb8: af          .
	sta	L0dcf		;; 0cb9: 32 cf 0d    2..
	call	L030b	; --L1474
	mov	a,c		;; 0cbf: 79          y
	cpi	012h	; fnc search next
	jrnz	L0cd6		;; 0cc2: 20 12        .
	; FNC 18 - save things in the BDOS
L0cc4:	sded	00000h	; dyn adr
	lxi	h,13		;; 0cc8: 21 0d 00    ...
	dad	d		;; 0ccb: 19          .
	mov	a,m		;; 0ccc: 7e          ~
L0ccd:	sta	00000h	; dyn adr
	inx	h		;; 0cd0: 23          #
	inx	h		;; 0cd1: 23          #
	mov	a,m		;; 0cd2: 7e          ~
L0cd3:	sta	00001h	; dyn adr
L0cd6:	pop	psw		;; 0cd6: f1          .
	pop	h		;; 0cd7: e1          .
L0cd8:	push	psw		;; 0cd8: f5          .
	mov	a,c		;; 0cd9: 79          y
	sta	L0d21		;; 0cda: 32 21 0d    2..
	pop	psw		;; 0cdd: f1          .
	sded	L0d1f		;; 0cde: ed 53 1f 0d .S..
L0ce2:	call	00000h	; orig bdose
	push	psw		;; 0ce5: f5          .
	lda	L026e		;; 0ce6: 3a 6e 02    :n.
	ana	a		;; 0ce9: a7          .
	jrz	L0cf5		;; 0cea: 28 09       (.
	pop	psw		;; 0cec: f1          .
	lda	L026e		;; 0ced: 3a 6e 02    :n.
	push	psw		;; 0cf0: f5          .
	xra	a		;; 0cf1: af          .
	sta	L026e		;; 0cf2: 32 6e 02    2n.
L0cf5:	pop	psw		;; 0cf5: f1          .
	sta	L1dbb		;; 0cf6: 32 bb 1d    2..
	push	psw		;; 0cf9: f5          .
	push	d		;; 0cfa: d5          .
	push	h		;; 0cfb: e5          .
	lda	L0d21		;; 0cfc: 3a 21 0d    :..
	cpi	011h		;; 0cff: fe 11       ..
	jrz	L0d07		;; 0d01: 28 04       (.
	cpi	012h		;; 0d03: fe 12       ..
	jrnz	L0d18		;; 0d05: 20 11        .
	; FNC 17 - search first
	; FNC 18 - search next
L0d07:	lhld	L0d1f		;; 0d07: 2a 1f 0d    *..
	lxi	d,13		;; 0d0a: 11 0d 00    ...
	dad	d		;; 0d0d: 19          .
L0d0e:	lda	00000h	; dyn adr
	mov	m,a		;; 0d11: 77          w
	inx	h		;; 0d12: 23          #
	inx	h		;; 0d13: 23          #
L0d14:	lda	00001h	; dyn adr
	mov	m,a		;; 0d17: 77          w
L0d18:	call	L030b	; --L1474
	pop	h		;; 0d1b: e1          .
	pop	d		;; 0d1c: d1          .
	pop	psw		;; 0d1d: f1          .
	ret			;; 0d1e: c9          .

L0d1f:	db	0,0
L0d21:	db	0

; func 105 -
L0d22:	lxi	h,L1746		;; 0d22: 21 46 17    .F.
	pop	psw		;; 0d25: f1          .
	ret			;; 0d26: c9          .

; func 98 - get GUID?
L0d27:	lhld	L0203		;; 0d27: 2a 03 02    *..
	lda	L0205		;; 0d2a: 3a 05 02    :..
	add	h		;; 0d2d: 84          .
	mov	h,a		;; 0d2e: 67          g
	pop	psw		;; 0d2f: f1          .
	ret			;; 0d30: c9          .

L0d31:	push	b		;; 0d31: c5          .
	push	d		;; 0d32: d5          .
	push	h		;; 0d33: e5          .
	lxi	h,L1da7		;; 0d34: 21 a7 1d    ...
	lxi	d,L0d6c		;; 0d37: 11 6c 0d    .l.
	lxi	b,13		;; 0d3a: 01 0d 00    ...
	ldir			;; 0d3d: ed b0       ..
	lda	L1db7		;; 0d3f: 3a b7 1d    :..
	sta	L0d79		;; 0d42: 32 79 0d    2y.
	lxi	h,L1ff2		;; 0d45: 21 f2 1f    ...
	lxi	d,L0d7a		;; 0d48: 11 7a 0d    .z.
	lxi	b,8		;; 0d4b: 01 08 00    ...
	ldir			;; 0d4e: ed b0       ..
	lda	L2138+4		;; 0d50: 3a 3c 21    :<.
	sta	L0d63		;; 0d53: 32 63 0d    2c.
	lxi	h,L0d62		;; 0d56: 21 62 0d    .b.
	call	L0f52	; send msg
	pop	h		;; 0d5c: e1          .
	pop	d		;; 0d5d: d1          .
	pop	b		;; 0d5e: c1          .
	jmp	L0bb3		;; 0d5f: c3 b3 0b    ...

; msg to send...
L0d62:	db	0
L0d63:	db	0	; dest node id?
	db	0,0,0,0,0
	db	7dh	; fnc (node status?)
	db	16h	; len
	db	0
L0d6c:	db	0ch,56h,28h,16h,8,0ddh,7eh,1,0cbh,6fh,0c4h,6eh,1ch ; from L1da7
L0d79:	db	3ch						; from L1db7
L0d7a:	db	0ddh,77h,1,2ah,0e4h,29h,8,77h			; from L1ff2

L0d82:	lda	L0dcf		;; 0d82: 3a cf 0d    :..
	ana	a		;; 0d85: a7          .
	jnz	L0caa		;; 0d86: c2 aa 0c    ...
	lda	L07e0		;; 0d89: 3a e0 07    :..
	ana	a		;; 0d8c: a7          .
	jz	L0caa		;; 0d8d: ca aa 0c    ...
	push	b		;; 0d90: c5          .
	push	h		;; 0d91: e5          .
	push	d		;; 0d92: d5          .
	lxi	h,L1e1a		;; 0d93: 21 1a 1e    ...
	lda	L0803		;; 0d96: 3a 03 08    :..
	mov	e,a		;; 0d99: 5f          _
	mvi	d,000h		;; 0d9a: 16 00       ..
	dad	d		;; 0d9c: 19          .
	pop	d		;; 0d9d: d1          .
	push	d		;; 0d9e: d5          .
	mov	a,e		;; 0d9f: 7b          {
	mov	m,a		;; 0da0: 77          w
	lda	L0803		;; 0da1: 3a 03 08    :..
	inr	a		;; 0da4: 3c          <
	sta	L0803		;; 0da5: 32 03 08    2..
	cpi	080h		;; 0da8: fe 80       ..
	jnz	L0dca		;; 0daa: c2 ca 0d    ...
	xra	a		;; 0dad: af          .
	sta	L0803		;; 0dae: 32 03 08    2..
	lxi	d,L1e1a		;; 0db1: 11 1a 1e    ...
	mvi	c,01ah		;; 0db4: 0e 1a       ..
	call	L0cab		;; 0db6: cd ab 0c    ...
	lxi	d,L07df		;; 0db9: 11 df 07    ...
	mvi	c,015h		;; 0dbc: 0e 15       ..
	call	L0cab		;; 0dbe: cd ab 0c    ...
	lded	L1d97		;; 0dc1: ed 5b 97 1d .[..
	mvi	c,01ah		;; 0dc5: 0e 1a       ..
	call	L0cab		;; 0dc7: cd ab 0c    ...
L0dca:	pop	d		;; 0dca: d1          .
	pop	h		;; 0dcb: e1          .
	pop	b		;; 0dcc: c1          .
	pop	psw		;; 0dcd: f1          .
	ret			;; 0dce: c9          .

L0dcf:	db	0

L0dd0:	pop	psw		;; 0dd0: f1          .
L0dd1:	jmp	00000h	; dyn adr - wboote+3 - const

L0dd4:	pop	psw		;; 0dd4: f1          .
	sta	L0dde		;; 0dd5: 32 de 0d    2..
	ret			;; 0dd8: c9          .

L0dd9:	pop	psw		;; 0dd9: f1          .
	lda	L0dde		;; 0dda: 3a de 0d    :..
	ret			;; 0ddd: c9          .

L0dde:	db	0

; func 126 -  return &L1e9c[A]
L0ddf:	pop	psw		;; 0ddf: f1          .
L0de0:	push	d		;; 0de0: d5          .
	ani	00fh		;; 0de1: e6 0f       ..
	sta	L0282		;; 0de3: 32 82 02    2..
	add	a		;; 0de6: 87          .
	mov	e,a		;; 0de7: 5f          _
	mvi	d,000h		;; 0de8: 16 00       ..
	lxi	h,L1e9c		;; 0dea: 21 9c 1e    ...
	dad	d		;; 0ded: 19          .
	pop	d		;; 0dee: d1          .
	ret			;; 0def: c9          .

L0df0:	push	psw		;; 0df0: f5          .
	push	b		;; 0df1: c5          .
	push	d		;; 0df2: d5          .
	push	h		;; 0df3: e5          .
	lxi	h,L203d		;; 0df4: 21 3d 20    .= 
	inx	h		;; 0df7: 23          #
L0df8:	mov	a,m		;; 0df8: 7e          ~
	ana	a		;; 0df9: a7          .
	jz	L0e47		;; 0dfa: ca 47 0e    .G.
	cpi	020h		;; 0dfd: fe 20       . 
	jz	L0e09		;; 0dff: ca 09 0e    ...
	lxi	d,00024h	;; 0e02: 11 24 00    .$.
	dad	d		;; 0e05: 19          .
	jmp	L0df8		;; 0e06: c3 f8 0d    ...

L0e09:	dcx	h		;; 0e09: 2b          +
	shld	L202b		;; 0e0a: 22 2b 20    "+ 
	lda	L2138+5		;; 0e0d: 3a 3d 21    :=.
	sta	L155e		;; 0e10: 32 5e 15    2^.
	lda	L2138+4		;; 0e13: 3a 3c 21    :<.
	lxi	h,@nid0+1	;; 0e16: 21 cf 13    ...
	cmp	m		;; 0e19: be          .
	jnz	L0e1e		;; 0e1a: c2 1e 0e    ...
	xra	a		;; 0e1d: af          .
L0e1e:	push	psw		;; 0e1e: f5          .
	lxi	h,L155d		;; 0e1f: 21 5d 15    .].
	call	L0f52		;; 0e22: cd 52 0f    .R.
	pop	psw		;; 0e25: f1          .
	sta	L2138+25	;; 0e26: 32 51 21    2Q.
	lda	L2138+10	;; 0e29: 3a 42 21    :B.
	sta	L2138+24	;; 0e2c: 32 50 21    2P.
	lda	L2138+28	;; 0e2f: 3a 54 21    :T.
	sta	L2138+23	;; 0e32: 32 4f 21    2O.
	lxi	h,L2138+10	;; 0e35: 21 42 21    .B.
	lded	L202b		;; 0e38: ed 5b 2b 20 .[+ 
	lxi	b,00010h	;; 0e3c: 01 10 00    ...
	ldir			;; 0e3f: ed b0       ..
	mvi	a,00fh		;; 0e41: 3e 0f       >.
	lhld	L202b		;; 0e43: 2a 2b 20    *+ 
	mov	m,a		;; 0e46: 77          w
L0e47:	pop	h		;; 0e47: e1          .
	pop	d		;; 0e48: d1          .
	pop	b		;; 0e49: c1          .
	pop	psw		;; 0e4a: f1          .
	jmp	L0bb3		;; 0e4b: c3 b3 0b    ...

; func 127 - 
L0e4e:	lxi	h,L1f71		;; 0e4e: 21 71 1f    .q.
	jmp	L0e81		;; 0e51: c3 81 0e    ...

L0e54:	lda	L1db8		;; 0e54: 3a b8 1d    :..
	sta	L1dba		;; 0e57: 32 ba 1d    2..
	mov	a,e		;; 0e5a: 7b          {
	ani	00fh		;; 0e5b: e6 0f       ..
	sta	L1db8		;; 0e5d: 32 b8 1d    2..
	sspd	L0e88		;; 0e60: ed 73 88 0e .s..
	lxi	sp,L2126	;; 0e64: 31 26 21    1&.
	inr	a		;; 0e67: 3c          <
	call	L0de0		;; 0e68: cd e0 0d    ...
	inx	h		;; 0e6b: 23          #
	mov	a,m		;; 0e6c: 7e          ~
	ana	a		;; 0e6d: a7          .
	jnz	L0e7d		;; 0e6e: c2 7d 0e    .}.
	dcx	h		;; 0e71: 2b          +
	mov	a,m		;; 0e72: 7e          ~
	dcr	a		;; 0e73: 3d          =
	jm	L0e83		;; 0e74: fa 83 0e    ...
	mov	e,a		;; 0e77: 5f          _
	mvi	c,00eh		;; 0e78: 0e 0e       ..
	call	L0cab		;; 0e7a: cd ab 0c    ...
L0e7d:	lspd	L0e88		;; 0e7d: ed 7b 88 0e .{..
L0e81:	pop	psw		;; 0e81: f1          .
	ret			;; 0e82: c9          .

L0e83:	mov	a,e		;; 0e83: 7b          {
	inr	a		;; 0e84: 3c          <
	jmp	L102e		;; 0e85: c3 2e 10    ...

L0e88:	db	0,0

L0e8a:	pop	psw		;; 0e8a: f1          .
	lda	L1db8		;; 0e8b: 3a b8 1d    :..
	ret			;; 0e8e: c9          .

L0e8f:	push	b		;; 0e8f: c5          .
	push	d		;; 0e90: d5          .
	push	h		;; 0e91: e5          .
	lda	L2138+10		;; 0e92: 3a 42 21    :B.
	cpi	028h		;; 0e95: fe 28       .(
	jrz	L0ea1		;; 0e97: 28 08       (.
	cpi	022h		;; 0e99: fe 22       ."
	jrz	L0ea1		;; 0e9b: 28 04       (.
	cpi	015h		;; 0e9d: fe 15       ..
	jrnz	L0eac		;; 0e9f: 20 0b        .
L0ea1:	lxi	h,L2138+49		;; 0ea1: 21 69 21    .i.
	lxi	d,L1eef		;; 0ea4: 11 ef 1e    ...
	lxi	b,128		;; 0ea7: 01 80 00    ...
	ldir			;; 0eaa: ed b0       ..
L0eac:	lxi	d,L1eef		;; 0eac: 11 ef 1e    ...
	mvi	c,01ah		;; 0eaf: 0e 1a       ..
	call	L0cab		;; 0eb1: cd ab 0c    ...
	lda	L2138+48		;; 0eb4: 3a 68 21    :h.
	mov	e,a		;; 0eb7: 5f          _
	mvi	c,020h		;; 0eb8: 0e 20       . 
	call	L0cab		;; 0eba: cd ab 0c    ...
	lhld	L2138+44		;; 0ebd: 2a 64 21    *d.
	shld	L1de3		;; 0ec0: 22 e3 1d    "..
	xra	a		;; 0ec3: af          .
	sta	L1da1		;; 0ec4: 32 a1 1d    2..
	lda	L2138+44		;; 0ec7: 3a 64 21    :d.
	cpi	0a5h		;; 0eca: fe a5       ..
	jrz	L0ed3		;; 0ecc: 28 05       (.
	mvi	a,001h		;; 0ece: 3e 01       >.
	sta	L1da1		;; 0ed0: 32 a1 1d    2..
L0ed3:	lda	L2138+10		;; 0ed3: 3a 42 21    :B.
	cpi	016h		;; 0ed6: fe 16       ..
	jnz	L0ee3		;; 0ed8: c2 e3 0e    ...
	mvi	c,013h		;; 0edb: 0e 13       ..
	lxi	d,L2138+11		;; 0edd: 11 43 21    .C.
	call	L0cab		;; 0ee0: cd ab 0c    ...
L0ee3:	lda	L2138+10		;; 0ee3: 3a 42 21    :B.
	mov	c,a		;; 0ee6: 4f          O
	lxi	d,L2138+11		;; 0ee7: 11 43 21    .C.
	call	L01db		;; 0eea: cd db 01    ...
	sta	L1eed		;; 0eed: 32 ed 1e    2..
	lda	L1da7		;; 0ef0: 3a a7 1d    :..
	mov	e,a		;; 0ef3: 5f          _
	mvi	c,020h		;; 0ef4: 0e 20       . 
	call	L0cab		;; 0ef6: cd ab 0c    ...
	lxi	h,L2138+11		;; 0ef9: 21 43 21    .C.
	lxi	d,L1ec9		;; 0efc: 11 c9 1e    ...
	lxi	b,00024h	;; 0eff: 01 24 00    .$.
	ldir			;; 0f02: ed b0       ..
	lda	L2138+10		;; 0f04: 3a 42 21    :B.
	cpi	020h		;; 0f07: fe 20       . 
	jnc	L0f12		;; 0f09: d2 12 0f    ...
	lhld	L1de3		;; 0f0c: 2a e3 1d    *..
	shld	L1eea		;; 0f0f: 22 ea 1e    "..
L0f12:	lda	L2138+4		;; 0f12: 3a 3c 21    :<.
	sta	L1ebf		;; 0f15: 32 bf 1e    2..
	mvi	a,065h		;; 0f18: 3e 65       >e
	sta	L1ec5		;; 0f1a: 32 c5 1e    2..
	lxi	h,00027h	;; 0f1d: 21 27 00    .'.
	lda	L2138+10		;; 0f20: 3a 42 21    :B.
	cpi	011h		;; 0f23: fe 11       ..
	jz	L0f37		;; 0f25: ca 37 0f    .7.
	cpi	012h		;; 0f28: fe 12       ..
	jz	L0f37		;; 0f2a: ca 37 0f    .7.
	cpi	014h		;; 0f2d: fe 14       ..
	jz	L0f37		;; 0f2f: ca 37 0f    .7.
	cpi	021h		;; 0f32: fe 21       ..
	jnz	L0f3a		;; 0f34: c2 3a 0f    .:.
L0f37:	lxi	h,000a7h	;; 0f37: 21 a7 00    ...
L0f3a:	shld	L1ec6		;; 0f3a: 22 c6 1e    "..
	lxi	h,L1ebe		;; 0f3d: 21 be 1e    ...
	call	L0f52		;; 0f40: cd 52 0f    .R.
	lded	L1d97		;; 0f43: ed 5b 97 1d .[..
	mvi	c,01ah		;; 0f47: 0e 1a       ..
	call	L0cab		;; 0f49: cd ab 0c    ...
	pop	h		;; 0f4c: e1          .
	pop	d		;; 0f4d: d1          .
	pop	b		;; 0f4e: c1          .
	ret			;; 0f4f: c9          .

L0f50:	db	0,0

L0f52:	mvi	a,001h		;; 0f52: 3e 01       >.
	push	psw		;; 0f54: f5          .
	jmp	L1493	; send msg

L0f58:	push	b		;; 0f58: c5          .
	push	h		;; 0f59: e5          .
	push	d		;; 0f5a: d5          .
	xchg			;; 0f5b: eb          .
	lda	L1d9c		;; 0f5c: 3a 9c 1d    :..
	cpi	011h		;; 0f5f: fe 11       ..
	jnz	L0f6a		;; 0f61: c2 6a 0f    .j.
	shld	L1d9f		;; 0f64: 22 9f 1d    "..
	jmp	L0f72		;; 0f67: c3 72 0f    .r.

L0f6a:	cpi	012h		;; 0f6a: fe 12       ..
	jnz	L0f72		;; 0f6c: c2 72 0f    .r.
	lhld	L1d9f		;; 0f6f: 2a 9f 1d    *..
L0f72:	call	L1c17		;; 0f72: cd 17 1c    ...
	sta	L2033		;; 0f75: 32 33 20    23 
	lda	L1da6		;; 0f78: 3a a6 1d    :..
	cpi	046h		;; 0f7b: fe 46       .F
	jz	L0faa		;; 0f7d: ca aa 0f    ...
	push	h		;; 0f80: e5          .
	push	d		;; 0f81: d5          .
	lxi	d,9		;; 0f82: 11 09 00    ...
	dad	d		;; 0f85: 19          .
	mov	a,m		;; 0f86: 7e          ~
	cpi	04fh		;; 0f87: fe 4f       .O
	jnz	L0fa8		;; 0f89: c2 a8 0f    ...
	inx	h		;; 0f8c: 23          #
	mov	a,m		;; 0f8d: 7e          ~
	cpi	056h		;; 0f8e: fe 56       .V
	jnz	L0fa8		;; 0f90: c2 a8 0f    ...
	mvi	c,020h		;; 0f93: 0e 20       . 
	lda	L2022		;; 0f95: 3a 22 20    :" 
	sta	L2033		;; 0f98: 32 33 20    23 
	mov	e,a		;; 0f9b: 5f          _
	call	L0cd8		;; 0f9c: cd d8 0c    ...
	pop	d		;; 0f9f: d1          .
	pop	h		;; 0fa0: e1          .
	lda	L2023		;; 0fa1: 3a 23 20    :# 
	mov	m,a		;; 0fa4: 77          w
	jmp	L0faa		;; 0fa5: c3 aa 0f    ...

L0fa8:	pop	d		;; 0fa8: d1          .
	pop	h		;; 0fa9: e1          .
L0faa:	mov	a,m		;; 0faa: 7e          ~
	push	psw		;; 0fab: f5          .
	ani	0f0h		;; 0fac: e6 f0       ..
	jz	L0fb6		;; 0fae: ca b6 0f    ...
	pop	psw		;; 0fb1: f1          .
	xra	a		;; 0fb2: af          .
	jmp	L0fb7		;; 0fb3: c3 b7 0f    ...

L0fb6:	pop	psw		;; 0fb6: f1          .
L0fb7:	ani	00fh		;; 0fb7: e6 0f       ..
	ana	a		;; 0fb9: a7          .
	jnz	L0fc1		;; 0fba: c2 c1 0f    ...
	lda	L1db8		;; 0fbd: 3a b8 1d    :..
	inr	a		;; 0fc0: 3c          <
L0fc1:	lxi	d,L1ec9		;; 0fc1: 11 c9 1e    ...
	shld	L0f50		;; 0fc4: 22 50 0f    "P.
	lxi	b,00024h	;; 0fc7: 01 24 00    .$.
	ldir			;; 0fca: ed b0       ..
	sta	L1ec9		;; 0fcc: 32 c9 1e    2..
	call	L0de0		;; 0fcf: cd e0 0d    ...
	mov	a,m		;; 0fd2: 7e          ~
	ana	a		;; 0fd3: a7          .
	jz	L102b		;; 0fd4: ca 2b 10    .+.
	sta	L1ec9		;; 0fd7: 32 c9 1e    2..
	inx	h		;; 0fda: 23          #
	mov	a,m		;; 0fdb: 7e          ~
	ana	a		;; 0fdc: a7          .
	jnz	L1063		;; 0fdd: c2 63 10    .c.
	pop	d		;; 0fe0: d1          .
	lxi	d,L1ec9		;; 0fe1: 11 c9 1e    ...
	lhld	unkn2		;; 0fe4: 2a 40 00    *@.
	shld	L1de3		;; 0fe7: 22 e3 1d    "..
	lda	unkn1		;; 0fea: 3a 08 00    :..
	sta	L1da1		;; 0fed: 32 a1 1d    2..
	pop	h		;; 0ff0: e1          .
	pop	b		;; 0ff1: c1          .
	pop	psw		;; 0ff2: f1          .
	call	L01db		;; 0ff3: cd db 01    ...
	push	d		;; 0ff6: d5          .
	push	b		;; 0ff7: c5          .
	push	h		;; 0ff8: e5          .
	push	psw		;; 0ff9: f5          .
	lda	L1d9c		;; 0ffa: 3a 9c 1d    :..
	cpi	00fh		;; 0ffd: fe 0f       ..
	jrz	L1005		;; 0fff: 28 04       (.
	cpi	010h		;; 1001: fe 10       ..
	jrnz	L100b		;; 1003: 20 06        .
L1005:	lhld	L1de3		;; 1005: 2a e3 1d    *..
	shld	unkn2		;; 1008: 22 40 00    "@.
L100b:	call	L1c0a		;; 100b: cd 0a 1c    ...
	lxi	h,L1eca		;; 100e: 21 ca 1e    ...
	lded	L0f50		;; 1011: ed 5b 50 0f .[P.
	inx	d		;; 1015: 13          .
	lxi	b,00020h	;; 1016: 01 20 00    . .
	lda	L1d9c		;; 1019: 3a 9c 1d    :..
	cpi	020h		;; 101c: fe 20       . 
	jc	L1024		;; 101e: da 24 10    .$.
	lxi	b,00023h	;; 1021: 01 23 00    .#.
L1024:	ldir			;; 1024: ed b0       ..
	pop	psw		;; 1026: f1          .
	pop	h		;; 1027: e1          .
	pop	b		;; 1028: c1          .
	pop	d		;; 1029: d1          .
	ret			;; 102a: c9          .

L102b:	lda	L1ec9		;; 102b: 3a c9 1e    :..
L102e:	adi	040h		;; 102e: c6 40       .@
	sta	L1047		;; 1030: 32 47 10    2G.
	lxi	d,L103f		;; 1033: 11 3f 10    .?.
	call	msgout		;; 1036: cd 3b 1c    .;.
	call	L18ef		;; 1039: cd ef 18    ...
	jmp	L0379		;; 103c: c3 79 03    .y.

L103f:	db	'?Device '
L1047:	db	'X: not assigned - DSK:=A:',0dh,0ah,'$'

L1063:	sta	L1ebf		;; 1063: 32 bf 1e    2..
	lda	L1ec8		;; 1066: 3a c8 1e    :..
	cpi	00fh		;; 1069: fe 0f       ..
	jrnz	L1080		;; 106b: 20 13        .
	lda	unkn1		;; 106d: 3a 08 00    :..
	ana	a		;; 1070: a7          .
	jrz	L1084		;; 1071: 28 11       (.
	lxi	h,61439		;; 1073: 21 ff ef    ...
	shld	@rto0+1		;; 1076: 22 7a 13    "z.
	mvi	a,00fh		;; 1079: 3e 0f       >.
	sta	L11b4+1		;; 107b: 32 b5 11    2..
	jr	L1084		;; 107e: 18 04       ..

L1080:	cpi	010h		;; 1080: fe 10       ..
	jrnz	L10a2		;; 1082: 20 1e        .
L1084:	lhld	unkn2		;; 1084: 2a 40 00    *@.
	shld	L1eea		;; 1087: 22 ea 1e    "..
	lda	unkn1		;; 108a: 3a 08 00    :..
	ana	a		;; 108d: a7          .
	jrnz	L1097		;; 108e: 20 07        .
	mvi	a,0a5h		;; 1090: 3e a5       >.
	sta	L1eea		;; 1092: 32 ea 1e    2..
	jr	L10a2		;; 1095: 18 0b       ..

L1097:	lda	L1eea		;; 1097: 3a ea 1e    :..
	cpi	0a5h		;; 109a: fe a5       ..
	jrz	L10a2		;; 109c: 28 04       (.
	xra	a		;; 109e: af          .
	sta	L1eea		;; 109f: 32 ea 1e    2..
L10a2:	lda	L0dcf		;; 10a2: 3a cf 0d    :..
	ana	a		;; 10a5: a7          .
	jrnz	L10b0		;; 10a6: 20 08        .
	lda	L1db1		;; 10a8: 3a b1 1d    :..
	ani	004h		;; 10ab: e6 04       ..
	jz	L18ea		;; 10ad: ca ea 18    ...
L10b0:	lda	L1ec8		;; 10b0: 3a c8 1e    :..
	cpi	01eh		;; 10b3: fe 1e       ..
	jrnz	L10bf		;; 10b5: 20 08        .
	lda	L1db1		;; 10b7: 3a b1 1d    :..
	cpi	037h		;; 10ba: fe 37       .7
	jnz	L1281		;; 10bc: c2 81 12    ...
L10bf:	lxi	h,00027h	;; 10bf: 21 27 00    .'.
	shld	L1ec6		;; 10c2: 22 c6 1e    "..
	lda	L1ec8		;; 10c5: 3a c8 1e    :..
	sta	L2028		;; 10c8: 32 28 20    2( 
	cpi	028h		;; 10cb: fe 28       .(
	jrz	L10d7		;; 10cd: 28 08       (.
	cpi	022h		;; 10cf: fe 22       ."
	jrz	L10d7		;; 10d1: 28 04       (.
	cpi	015h		;; 10d3: fe 15       ..
	jrnz	L10e8		;; 10d5: 20 11        .
L10d7:	lxi	h,000a7h	;; 10d7: 21 a7 00    ...
	shld	L1ec6		;; 10da: 22 c6 1e    "..
	lhld	L1d97		;; 10dd: 2a 97 1d    *..
	lxi	d,L1eef		;; 10e0: 11 ef 1e    ...
	lxi	b,128		;; 10e3: 01 80 00    ...
	ldir			;; 10e6: ed b0       ..
L10e8:	mvi	a,064h		;; 10e8: 3e 64       >d
	sta	L1ec5		;; 10ea: 32 c5 1e    2..
	lda	L1ec8		;; 10ed: 3a c8 1e    :..
	sta	L20ab		;; 10f0: 32 ab 20    2. 
	lda	L2033		;; 10f3: 3a 33 20    :3 
	sta	L1eee		;; 10f6: 32 ee 1e    2..
	lda	L1c24		;; 10f9: 3a 24 1c    :$.
	ana	a		;; 10fc: a7          .
	jrz	L1103		;; 10fd: 28 04       (.
	xra	a		;; 10ff: af          .
	sta	L1eee		;; 1100: 32 ee 1e    2..
L1103:	xra	a		;; 1103: af          .
	sta	L11e1		;; 1104: 32 e1 11    2..
	lda	L20ab		;; 1107: 3a ab 20    :. 
	sta	L1ec8		;; 110a: 32 c8 1e    2..
	; state 3 - ???
L110d:	lxi	h,L1ebe		;; 110d: 21 be 1e    ...
	di			;; 1110: f3          .
	call	L0f52		;; 1111: cd 52 0f    .R.
L1114:	call	L136d		;; 1114: cd 6d 13    .m.
	ei			;; 1117: fb          .
	lda	L2137		;; 1118: 3a 37 21    :7.
	cpi	001h		;; 111b: fe 01       ..
	jz	L11ad		;; 111d: ca ad 11    ...
	cpi	003h		;; 1120: fe 03       ..
	jrz	L110d		;; 1122: 28 e9       (.
	cpi	002h		;; 1124: fe 02       ..
	jnz	L11e7		;; 1126: c2 e7 11    ...
	; state 2 - ???
	lda	L11e1		;; 1129: 3a e1 11    :..
	adi	005h		;; 112c: c6 05       ..
	sta	L11e1		;; 112e: 32 e1 11    2..
L1131:	xra	a		;; 1131: af          .
	sta	L11bc		;; 1132: 32 bc 11    2..
	lda	L11e1		;; 1135: 3a e1 11    :..
	inr	a		;; 1138: 3c          <
	sta	L11e1		;; 1139: 32 e1 11    2..
	ani	080h		;; 113c: e6 80       ..
	jrz	L110d		;; 113e: 28 cd       (.
	lda	L1da4		;; 1140: 3a a4 1d    :..
	dcr	a		;; 1143: 3d          =
	cpi	0f7h		;; 1144: fe f7       ..
	jz	L114e		;; 1146: ca 4e 11    .N.
	sta	L1da4		;; 1149: 32 a4 1d    2..
	jr	L1103		;; 114c: 18 b5       ..

L114e:	lda	L1da5		;; 114e: 3a a5 1d    :..
	sta	L1da4		;; 1151: 32 a4 1d    2..
	lda	L1ebf		;; 1154: 3a bf 1e    :..
	adi	'0'		;; 1157: c6 30       .0
	sta	L11c4		;; 1159: 32 c4 11    2..
	mvi	a,020h		;; 115c: 3e 20       > 
	sta	L11d1		;; 115e: 32 d1 11    2..
	mvi	a,02dh		;; 1161: 3e 2d       >-
	sta	L11d2		;; 1163: 32 d2 11    2..
	lda	unkn1		;; 1166: 3a 08 00    :..
	ana	a		;; 1169: a7          .
	jrz	L117f		;; 116a: 28 13       (.
	mvi	a,00dh		;; 116c: 3e 0d       >.
	sta	L11d1		;; 116e: 32 d1 11    2..
	mvi	a,024h		;; 1171: 3e 24       >$
	sta	L11d2		;; 1173: 32 d2 11    2..
	lxi	d,L11be		;; 1176: 11 be 11    ...
	call	msgout		;; 1179: cd 3b 1c    .;.
	jmp	L1103		;; 117c: c3 03 11    ...

L117f:	lxi	d,L11be		;; 117f: 11 be 11    ...
	call	msgout		;; 1182: cd 3b 1c    .;.
	mvi	c,001h		;; 1185: 0e 01       ..
	call	L0cab		;; 1187: cd ab 0c    ...
	push	psw		;; 118a: f5          .
	mvi	e,00dh		;; 118b: 1e 0d       ..
	call	L1b9d		;; 118d: cd 9d 1b    ...
	pop	psw		;; 1190: f1          .
	ani	05fh		;; 1191: e6 5f       ._
	cpi	059h		;; 1193: fe 59       .Y
	jz	L1103		;; 1195: ca 03 11    ...
	cpi	04eh		;; 1198: fe 4e       .N
	jrnz	L114e		;; 119a: 20 b2        .
	xra	a		;; 119c: af          .
	sta	L1db9		;; 119d: 32 b9 1d    2..
	call	L0527		;; 11a0: cd 27 05    .'.
	sta	L1e9f		;; 11a3: 32 9f 1e    2..
	inr	a		;; 11a6: 3c          <
	sta	L1e9e		;; 11a7: 32 9e 1e    2..
	jmp	L0379		;; 11aa: c3 79 03    .y.

; state 1 - every 4th call goto L1131, else L1114
L11ad:	lda	L11bc		;; 11ad: 3a bc 11    :..
	inr	a		;; 11b0: 3c          <
	sta	L11bc		;; 11b1: 32 bc 11    2..
L11b4:	ani	003h		;; 11b4: e6 03       ..
	jnz	L1114	; loop back
	jmp	L1131		;; 11b9: c3 31 11    .1.

L11bc:	db	0
L11bd:	db	0
L11be:	db	'?Node '
L11c4:	db	'x unavailable'
L11d1:	db	' '
L11d2:	db	'- Retry(Y/N)? $'
L11e1:	db	0
L11e2:	db	'BUSY$'

L11e7:	lda	L1da5		;; 11e7: 3a a5 1d    :..
	sta	L1da4		;; 11ea: 32 a4 1d    2..
	lda	L2138+7		;; 11ed: 3a 3f 21    :?.
	cpi	064h		;; 11f0: fe 64       .d
	jz	L129a		;; 11f2: ca 9a 12    ...
	cpi	065h		;; 11f5: fe 65       .e
	jnz	L11ad		;; 11f7: c2 ad 11    ...
	xra	a		;; 11fa: af          .
	sta	L11bc		;; 11fb: 32 bc 11    2..
	sta	L11bd		;; 11fe: 32 bd 11    2..
	lda	L2028		;; 1201: 3a 28 20    :( 
	cpi	011h		;; 1204: fe 11       ..
	jrz	L1214		;; 1206: 28 0c       (.
	cpi	012h		;; 1208: fe 12       ..
	jrz	L1214		;; 120a: 28 08       (.
	cpi	014h		;; 120c: fe 14       ..
	jrz	L1214		;; 120e: 28 04       (.
	cpi	021h		;; 1210: fe 21       ..
	jrnz	L1220		;; 1212: 20 0c        .
L1214:	lxi	h,L2138+49		;; 1214: 21 69 21    .i.
	lded	L1d97		;; 1217: ed 5b 97 1d .[..
	lxi	b,128		;; 121b: 01 80 00    ...
	ldir			;; 121e: ed b0       ..
L1220:	lxi	h,L2138+12		;; 1220: 21 44 21    .D.
	lded	L0f50		;; 1223: ed 5b 50 0f .[P.
	inx	d		;; 1227: 13          .
	lxi	b,00020h	;; 1228: 01 20 00    . .
	lda	L2028		;; 122b: 3a 28 20    :( 
	cpi	020h		;; 122e: fe 20       . 
	jc	L1236		;; 1230: da 36 12    .6.
	lxi	b,00023h	;; 1233: 01 23 00    .#.
L1236:	ldir			;; 1236: ed b0       ..
	lda	L2028		;; 1238: 3a 28 20    :( 
	cpi	00fh		;; 123b: fe 0f       ..
	jrnz	L124c		;; 123d: 20 0d        .
	lxi	h,8192		;; 123f: 21 00 20    .. 
	shld	@rto0+1		;; 1242: 22 7a 13    "z.
	mvi	a,003h		;; 1245: 3e 03       >.
	sta	L11b4+1		;; 1247: 32 b5 11    2..
	jr	L1250		;; 124a: 18 04       ..

L124c:	cpi	010h		;; 124c: fe 10       ..
	jrnz	L1256		;; 124e: 20 06        .
L1250:	lhld	L2138+44		;; 1250: 2a 64 21    *d.
	shld	unkn2		;; 1253: 22 40 00    "@.
L1256:	lda	L1db1		;; 1256: 3a b1 1d    :..
	cpi	037h		;; 1259: fe 37       .7
	jrz	L1273		;; 125b: 28 16       (.
	lda	L0dcf		;; 125d: 3a cf 0d    :..
	ana	a		;; 1260: a7          .
	jrnz	L1273		;; 1261: 20 10        .
	lxi	h,L2138+12		;; 1263: 21 44 21    .D.
	mov	a,m		;; 1266: 7e          ~
	ani	080h		;; 1267: e6 80       ..
	jrnz	L1281		;; 1269: 20 16        .
	lxi	h,L2138+22		;; 126b: 21 4e 21    .N.
	mov	a,m		;; 126e: 7e          ~
	ani	080h		;; 126f: e6 80       ..
	jrnz	L1281		;; 1271: 20 0e        .
L1273:	call	L1c0a		;; 1273: cd 0a 1c    ...
	pop	d		;; 1276: d1          .
	pop	h		;; 1277: e1          .
	pop	b		;; 1278: c1          .
	pop	psw		;; 1279: f1          .
	lda	L2138+47		;; 127a: 3a 67 21    :g.
	mov	l,a		;; 127d: 6f          o
	mov	h,b		;; 127e: 60          `
	ret			;; 127f: c9          .

	db	0
L1281:	lxi	d,L128a		;; 1281: 11 8a 12    ...
	call	msgout		;; 1284: cd 3b 1c    .;.
	jmp	L0379		;; 1287: c3 79 03    .y.

L128a:	db	'?File protected$'
L129a:	pop	d		;; 129a: d1          .
	pop	h		;; 129b: e1          .
	pop	b		;; 129c: c1          .
	jmp	L0bae		;; 129d: c3 ae 0b    ...

; func 120 - setup network params
; reconfigure code based on (new) network vector block
L12a0:	lxi	h,netvec		;; 12a0: 21 f5 1d    ...
	mov	a,m	; +0: ctl/sts port
	inx	h		;; 12a4: 23          #
	inx	h		;; 12a5: 23          #
	inx	h		;; 12a6: 23          #
	sta	@is00+1	; input SIO sts port
	sta	@is01+1	; input SIO sts port
	sta	@is02+1	; input SIO sts port
	sta	@is03+1	; input SIO sts port
	sta	@is04+1	; input SIO sts port
	sta	@is05+1	; input SIO sts port
	sta	@oc00+1	; output ctrl port
	sta	@oc01+1	; output ctrl port
	sta	@oc02+1	; output ctrl port
	sta	@oc03+1	; output ctrl port
	sta	@oc04+1	; output ctrl port
	sta	@oc05+1	; output ctrl port
	sta	@is06+1	; input SIO sts port
	sta	@is07+1	; input SIO sts port
	sta	@is08+1	; input SIO sts port
	sta	@is09+1	; input SIO sts port
	inx	h		;; 12d7: 23          #
	mov	a,m	; +4: input data port
	inx	h		;; 12d9: 23          #
	inx	h		;; 12da: 23          #
	sta	@id00+1	; input port+0 (SIO data in)
	sta	@id01+1		;; 12de: 32 5e 0b    2^.
	sta	@id02+1		;; 12e1: 32 71 15    2q.
	sta	@id03+1		;; 12e4: 32 93 13    2..
	sta	@id04+1		;; 12e7: 32 f9 13    2..
	sta	@id05+1		;; 12ea: 32 10 15    2..
	inx	h		;; 12ed: 23          #
	mov	a,m	; +7: output data port
	sta	@od00+1	; output port+0 (SIO data out)
	sta	@od01+1		;; 12f2: 32 08 15    2..
	inx	h		;; 12f5: 23          #
	mov	a,m	; +8: TxE mask
	sta	@txm0+1	; mask for input port+1 (TxE)
	sta	@txm1+1		;; 12fa: 32 03 15    2..
	inx	h		;; 12fd: 23          #
	mov	a,m	; +9: RxA mask
	inx	h		;; 12ff: 23          #
	sta	@rxm0+1	; mask for input port+1 (RxR)
	sta	@rxm1+1		;; 1303: 32 58 13    2X.
	sta	@rxm2+1		;; 1306: 32 6e 15    2n.
	sta	@rxm3+1		;; 1309: 32 81 13    2..
	sta	@rxm4+1		;; 130c: 32 f5 13    2..
	sta	@rxm5+1		;; 130f: 32 0c 15    2..
	inx	h		;; 1312: 23          #
	inx	h		;; 1313: 23          #
	mov	a,m	; +12: node id
	sta	@nid0+1	; node ID, binary
	adi	'0'		;; 1318: c6 30       .0
	sta	L1d2d	; node ID, ASCII
	mvi	a,0eah		;; 131d: 3e ea       >.
	sta	@dtr0+1	; port init for WR5 for DTR
	inx	h		;; 1322: 23          #
	mov	a,m	; +13:
	ana	a		;; 1324: a7          .
	jnz	L132d		;; 1325: c2 2d 13    .-.
	mvi	a,06ah	; port init for WR5 for !DTR
	sta	@dtr0+1		;; 132a: 32 37 15    27.
L132d:	pop	psw		;; 132d: f1          .
	ret			;; 132e: c9          .

L132f:	pop	h		;; 132f: e1          .
	lxi	h,netvec		;; 1330: 21 f5 1d    ...
	ret			;; 1333: c9          .

L1334:	inx	h		;; 1334: 23          #
	mov	a,m		;; 1335: 7e          ~

; Tx(A), A=Rx_timeout(176..255)
L1336:	push	psw		;; 1336: f5          .
L1337:
@is00:	in	011h		;; 1337: db 11       ..
@txm0:	ani	001h		;; 1339: e6 01       ..
	jrz	L1337		;; 133b: 28 fa       (.
	pop	psw		;; 133d: f1          .
@od00:	out	010h		;; 133e: d3 10       ..
L1340:	push	d		;; 1340: d5          .
	lda	L1474		;; 1341: 3a 74 14    :t.
	ori	0b0h		;; 1344: f6 b0       ..
	mov	e,a		;; 1346: 5f          _
	jmp	L1355		;; 1347: c3 55 13    .U.

L134a:	push	d		;; 134a: d5          .
	lda	L1474		;; 134b: 3a 74 14    :t.
	mvi	d,0		;; 134e: 16 00       ..
	ani	020h		;; 1350: e6 20       . 
	ori	001h		;; 1352: f6 01       ..
	mov	e,a	; DE = 1 or 33 (1 or 33 chars)
L1355:	; at 1X, 19.2K/16X = 39uS/char
@is01:	in	011h	; SIO ctl			; 11
@rxm1:	ani	002h	; RxA				; 7
	jrnz	L1366		;; 1359: 20 0b        .	; 7
	call	L030b	; --L1474			; 17 + 61
	dcx	d		;; 135e: 1b          .	; 6
	mov	a,e		;; 135f: 7b          {	; 4
	ana	a		;; 1360: a7          .	; 4
	jrnz	L1355		;; 1361: 20 f2        .	; 12 = 129 @ 4MHz = 32.25uS
	; timeout
	pop	d		;; 1363: d1          .
	stc			;; 1364: 37          7
	ret			;; 1365: c9          .

L1366:
@id00:	in	010h		;; 1366: db 10       ..
	pop	d		;; 1368: d1          .
	stc			;; 1369: 37          7
	cmc			;; 136a: 3f          ?
	ret			;; 136b: c9          .

L136c:	pop	psw		;; 136c: f1          .
L136d:	mvi	a,0ffh		;; 136d: 3e ff       >.
	sta	L13a6		;; 136f: 32 a6 13    2..
L1372:	lda	L13a6		;; 1372: 3a a6 13    :..
	inr	a		;; 1375: 3c          <
	sta	L13a6		;; 1376: 32 a6 13    2..
@rto0:	lxi	d,511		;; 1379: 11 ff 01    ...
L137c:	mvi	c,4		;; 137c: 0e 04       ..
L137e:
@is04:	in	011h		;; 137e: db 11       ..
@rxm3:	ani	002h	; RxA
	jnz	L1392		;; 1382: c2 92 13    ...
	dcr	c		;; 1385: 0d          .
	jnz	L137e		;; 1386: c2 7e 13    .~.
	dcx	d		;; 1389: 1b          .
	mov	a,d		;; 138a: 7a          z
	ana	a		;; 138b: a7          .
	jnz	L137c		;; 138c: c2 7c 13    .|.
	jmp	L1415		;; 138f: c3 15 14    ...

L1392:
@id03:	in	010h		;; 1392: db 10       ..
	cpi	002h	; STX
	jz	L1372		;; 1396: ca 72 13    .r.
	push	psw		;; 1399: f5          .
	lda	L13a6		;; 139a: 3a a6 13    :..
	cpi	003h		;; 139d: fe 03       ..
	jnc	L13a7		;; 139f: d2 a7 13    ...
	pop	psw		;; 13a2: f1          .
	jmp	L136d		;; 13a3: c3 6d 13    .m.

L13a6:	db	0d9h

L13a7:	pop	psw		;; 13a7: f1          .
L13a8:	cpi	040h	; msg hdr type/fmt?
	jz	L13c5		;; 13aa: ca c5 13    ...
	cpi	080h		;; 13ad: fe 80       ..
	jz	L13b9		;; 13af: ca b9 13    ...
	ana	a		;; 13b2: a7          .
	jnz	L136d		;; 13b3: c2 6d 13    .m.
	jmp	L13c5		;; 13b6: c3 c5 13    ...

L13b9:	lxi	h,L2138		;; 13b9: 21 38 21    .8.
	mov	m,a		;; 13bc: 77          w
	inx	h		;; 13bd: 23          #
	call	L1340		;; 13be: cd 40 13    .@.
	mov	m,a		;; 13c1: 77          w
	jmp	L13d3		;; 13c2: c3 d3 13    ...

L13c5:	lxi	h,L2138		;; 13c5: 21 38 21    .8.
	mov	m,a		;; 13c8: 77          w
	inx	h		;; 13c9: 23          #
	call	L1340	; recv char (timeout ret 0)
	mov	m,a		;; 13cd: 77          w
@nid0:	cpi	001h		;; 13ce: fe 01       ..
	jnz	L1410	; msg not for us...
L13d3:	inx	h		;; 13d3: 23          #
	inx	h		;; 13d4: 23          #
	call	L141a	; recv char into *(++HL)
	call	L141a	; recv char into *(++HL)
	inx	h		;; 13db: 23          #
	call	L141a	; recv char into *(++HL)
	lda	L2138		;; 13df: 3a 38 21    :8.
	ani	040h		;; 13e2: e6 40       .@
	jnz	L1408		;; 13e4: c2 08 14    ...
	call	L141a	; recv char into *(++HL)
	mov	c,a	; msg len
	inx	h		;; 13eb: 23          #
	inr	c		;; 13ec: 0c          .
	mvi	e,0	; init chksum
	; recv C bytes, E=chksum
L13ef:	dcr	c		;; 13ef: 0d          .
	jrz	L1401		;; 13f0: 28 0f       (.
L13f2:
@is07:	in	006h		;; 13f2: db 06       ..
@rxm4:	ani	001h	; RxA
	jrz	L13f2		;; 13f6: 28 fa       (.
@id04:	in	004h		;; 13f8: db 04       ..
	inx	h		;; 13fa: 23          #
	mov	m,a	; recv char into *(++HL)
	add	e		;; 13fc: 83          .
	mov	e,a		;; 13fd: 5f          _
	jmp	L13ef		;; 13fe: c3 ef 13    ...

L1401:	call	L141a	; recv char into *(++HL) : chksum
	cmp	e		;; 1404: bb          .
	jnz	L1410	; bad chksum
	; msg rcv success
L1408:	lxi	h,L2138	; msg buf
	xra	a		;; 140b: af          .
L140c:	sta	L2137	; busy flag off?
	ret			;; 140f: c9          .

; message not for us (or corrupt) - skip it
L1410:	mvi	a,001h	; set state and get out of here
	jmp	L140c		;; 1412: c3 0c 14    ...

L1415:	mvi	a,002h	; set state and get out of here
	jmp	L140c		;; 1417: c3 0c 14    ...

L141a:	call	L1340		;; 141a: cd 40 13    .@.
	inx	h		;; 141d: 23          #
	mov	m,a		;; 141e: 77          w
	ret			;; 141f: c9          .

L1420:	push	h		;; 1420: e5          .
	push	d		;; 1421: d5          .
	push	b		;; 1422: c5          .
	lda	L2138+4	; sender node id?
	sta	L155e		;; 1426: 32 5e 15    2^.
	adi	'0'		;; 1429: c6 30       .0
	sta	L145f+16	;; 142b: 32 6f 14    2o.
	lxi	d,L145f	; "Msg from node..."
	mvi	c,009h		;; 1431: 0e 09       ..
	call	L0cab		;; 1433: cd ab 0c    ...
	lda	L2138+8	; msg len
	mov	c,a		;; 1439: 4f          O
	lxi	h,L2138+10	; msg payload (text)
L143d:	dcr	c		;; 143d: 0d          .
	jm	L1450		;; 143e: fa 50 14    .P.
	push	b		;; 1441: c5          .
	mvi	c,002h		;; 1442: 0e 02       ..
	mov	a,m		;; 1444: 7e          ~
	mov	e,a		;; 1445: 5f          _
	push	h		;; 1446: e5          .
	call	L0cab		;; 1447: cd ab 0c    ...
	pop	h		;; 144a: e1          .
	inx	h		;; 144b: 23          #
	pop	b		;; 144c: c1          .
	jmp	L143d		;; 144d: c3 3d 14    .=.

L1450:	call	L1cfe		;; 1450: cd fe 1c    ...
	lxi	h,L155d		;; 1453: 21 5d 15    .].
	call	L0f52		;; 1456: cd 52 0f    .R.
	pop	b		;; 1459: c1          .
	pop	d		;; 145a: d1          .
	pop	h		;; 145b: e1          .
	jmp	L0bb3		;; 145c: c3 b3 0b    ...

L145f:	db	';;Msg from node x -',7,'$'

L1474:	db	0aah

L1475:	call	L1518	; terminate sending (bounce DTR)
	push	d		;; 1478: d5          .
	lda	L1474		;; 1479: 3a 74 14    :t.
	ani	03fh		;; 147c: e6 3f       .?
	inr	a		;; 147e: 3c          <
	mov	d,a		;; 147f: 57          W
L1480:	dcx	d		;; 1480: 1b          .
	call	L030b	; --L1474
	mov	a,d		;; 1484: 7a          z
	ana	a		;; 1485: a7          .
	jrz	L148f		;; 1486: 28 07       (.
	mvi	a,50		;; 1488: 3e 32       >2
L148a:	dcr	a		;; 148a: 3d          =
	jrnz	L148a		;; 148b: 20 fd        .
	jr	L1480		;; 148d: 18 f1       ..

; send msg after waiting for idle line (gobble any input)
L148f:	pop	d		;; 148f: d1          .
	mvi	a,001h		;; 1490: 3e 01       >.
	push	psw		;; 1492: f5          .
; send msg after flushing input

L1493:	lda	L1d2d	; this also seems to flag network as down
	cpi	'0'		;; 1496: fe 30       .0
	jz	L153b	; net not ready
	call	L156b	; flush SIO Rx fifo
L149e:	call	L134a	; wait for Rx (timeout)
	jrnc	L1493	; keep waiting if not idle
	; timeout - truly idle?
	mvi	a,010h	; reset ext status
@oc04:	out	006h		;; 14a5: d3 06       ..
@oc05:	out	006h		;; 14a7: d3 06       ..
@is06:	in	006h		;; 14a9: db 06       ..
	ani	008h	; check DCD
	jz	L149e	; no DCD... loop back and wait again
	; got DCD - now send message
	pop	psw		;; 14b0: f1          .
	; send 18 STX chars - watch for collisions
	mvi	a,002h	; STX?
	mvi	b,18		;; 14b3: 06 12       ..
L14b5:	dcr	b		;; 14b5: 05          .
	jm	L14c7		;; 14b6: fa c7 14    ...
	call	L1336	; send char - CY == ???
	jc	L153b	; net not ready - bounce DTR, print msg
	cpi	002h		;; 14bf: fe 02       ..
	jnz	L1475	; collision detected
	jmp	L14b5		;; 14c4: c3 b5 14    ...

; send header?
L14c7:	mov	a,m		;; 14c7: 7e          ~
	sta	L155c		;; 14c8: 32 5c 15    2\.
	call	L1336	; send A
	call	L1334	; send next *(++HL)
	inx	h		;; 14d1: 23          #
	inx	h		;; 14d2: 23          #
	inx	h		;; 14d3: 23          #
	mov	a,m		;; 14d4: 7e          ~
	ana	a		;; 14d5: a7          .
	jrnz	L14db		;; 14d6: 20 03        .
	lda	@nid0+1	; node ID
L14db:	call	L1336	; send A
	lda	@nid0+1	; node ID
	call	L1336	; send A
	inx	h		;; 14e4: 23          #
	inx	h		;; 14e5: 23          #
	call	L1334	; send next *(++HL)
	lda	L155c		;; 14e9: 3a 5c 15    :\.
	ani	040h		;; 14ec: e6 40       .@
	jnz	L1518	; terminate sending
	call	L1334	; send next *(++HL)
	mov	c,a		;; 14f4: 4f          O
	inx	h		;; 14f5: 23          #
	inr	c		;; 14f6: 0c          .
	mvi	e,000h	; init chksum
L14f9:	dcr	c		;; 14f9: 0d          .
	jrz	L1514		;; 14fa: 28 18       (.
	inx	h		;; 14fc: 23          #
	mov	a,m		;; 14fd: 7e          ~
	add	e		;; 14fe: 83          .
	mov	e,a	; chksum += char
L1500:
@is08:	in	006h		;; 1500: db 06       ..
@txm1:	ani	004h		;; 1502: e6 04       ..
	jrz	L1500		;; 1504: 28 fa       (.
	mov	a,m		;; 1506: 7e          ~
@od01:	out	004h	; Tx byte
L1509:
@is09:	in	006h	; wait for reflection
@rxm5:	ani	001h		;; 150b: e6 01       ..
	jrz	L1509		;; 150d: 28 fa       (.
@id05:	in	004h	; consume Rx, discard.
	jmp	L14f9		;; 1511: c3 f9 14    ...
; done sending message
L1514:	mov	a,e		;; 1514: 7b          {
	call	L1336	; send chksum... where? w/timeout?
	; wait for Tx to idle
L1518:
@is05:	in	006h		;; 1518: db 06       ..
	ani	004h		;; 151a: e6 04       ..
	jrz	L1518		;; 151c: 28 fa       (.
	; bounce DTR three times...
	call	L1524		;; 151e: cd 24 15    .$.
	call	L1524		;; 1521: cd 24 15    .$.
L1524:	mvi	a,005h	; WR5
@oc00:	out	006h		;; 1526: d3 06       ..
	mvi	a,06ah	; DTR off
@oc01:	out	006h		;; 152a: d3 06       ..
	mvi	a,003h		;; 152c: 3e 03       >.
L152e:	dcr	a		;; 152e: 3d          =
	jnz	L152e		;; 152f: c2 2e 15    ...
	mvi	a,005h		;; 1532: 3e 05       >.
@oc02:	out	006h		;; 1534: d3 06       ..
@dtr0:	mvi	a,0eah	; DTR on (maybe)
@oc03:	out	006h		;; 1538: d3 06       ..
	ret			;; 153a: c9          .

; either L1d2d == '0' or failed to see echo
L153b:	call	L1518	; terminate sending
	lxi	d,L154a	; "NET NOT READY"
	call	msgout		;; 1541: cd 3b 1c    .;.
	call	L18ef		;; 1544: cd ef 18    ...
	jmp	L0379		;; 1547: c3 79 03    .y.

L154a:	db	'?NET NOT READY',0dh,0ah,7,'$'
L155c:	db	0
L155d:	db	40h
L155e:	db	0,0,0,0,0,0,67h

	mvi	a,0ffh		;; 1565: 3e ff       >.
L1567:	dcr	a		;; 1567: 3d          =
	jnz	L1567		;; 1568: c2 67 15    .g.
; flush any input chars
L156b:
@is03:	in	011h		;; 156b: db 11       ..
@rxm2:	ani	002h		;; 156d: e6 02       ..
	rz			;; 156f: c8          .
@id02:	in	010h		;; 1570: db 10       ..
	jmp	L156b		;; 1572: c3 6b 15    .k.

L1575:	pop	psw		;; 1575: f1          .
	lspd	L2024		;; 1576: ed 7b 24 20 .{$ 
	push	psw		;; 157a: f5          .
	push	b		;; 157b: c5          .
	push	d		;; 157c: d5          .
	push	h		;; 157d: e5          .
	sspd	L1d94		;; 157e: ed 73 94 1d .s..
	lxi	sp,L20de	;; 1582: 31 de 20    1. 
	mvi	a,'1'		;; 1585: 3e 31       >1
	sta	L1d96		;; 1587: 32 96 1d    2..
	lxi	h,defdma	;; 158a: 21 80 00    ...
	lxi	d,L1f70		;; 158d: 11 70 1f    .p.
	lxi	b,81		;; 1590: 01 51 00    .Q.
	ldir			;; 1593: ed b0       ..
	jmp	L0438		;; 1595: c3 38 04    .8.

L1598:	lxi	h,L1da7		;; 1598: 21 a7 1d    ...
	pop	psw		;; 159b: f1          .
	ret			;; 159c: c9          .

L159d:	lxi	h,L203d		;; 159d: 21 3d 20    .= 
	pop	psw		;; 15a0: f1          .
	ret			;; 15a1: c9          .

L15a2:	inx	h		;; 15a2: 23          #
	mov	a,m		;; 15a3: 7e          ~
	cpi	'A'		;; 15a4: fe 41       .A
	jrz	L15d3		;; 15a6: 28 2b       (+
	cpi	'P'		;; 15a8: fe 50       .P
	jz	L166b		;; 15aa: ca 6b 16    .k.
	cpi	'U'		;; 15ad: fe 55       .U
	jz	L1682		;; 15af: ca 82 16    ...
	cpi	'T'		;; 15b2: fe 54       .T
	jnz	L17b2		;; 15b4: c2 b2 17    ...
	lxi	h,L1f73		;; 15b7: 21 73 1f    .s.
	lxi	d,L15cf		;; 15ba: 11 cf 15    ...
	call	L1794		;; 15bd: cd 94 17    ...
	lxi	d,defdma	;; 15c0: 11 80 00    ...
	call	L1c25		;; 15c3: cd 25 1c    .%.
	call	L1c0a		;; 15c6: cd 0a 1c    ...
	call	L0100		;; 15c9: cd 00 01    ...
	jmp	L0379		;; 15cc: c3 79 03    .y.

L15cf:	db	'ART '
L15d3:	lxi	h,L1f73		;; 15d3: 21 73 1f    .s.
	lxi	d,L1656		;; 15d6: 11 56 16    .V.
	call	L1794		;; 15d9: cd 94 17    ...
	lxi	h,0		;; 15dc: 21 00 00    ...
	lda	deffcb+1	;; 15df: 3a 5d 00    :].
	call	L1659		;; 15e2: cd 59 16    .Y.
	lda	deffcb+2	;; 15e5: 3a 5e 00    :^.
	call	L1659		;; 15e8: cd 59 16    .Y.
	lda	deffcb+3	;; 15eb: 3a 5f 00    :_.
	call	L1659		;; 15ee: cd 59 16    .Y.
	shld	L2031		;; 15f1: 22 31 20    "1 
	lxi	h,deffcb+16	;; 15f4: 21 6c 00    .l.
	lxi	d,deffcb	;; 15f7: 11 5c 00    .\.
	lxi	b,16		;; 15fa: 01 10 00    ...
	ldir			;; 15fd: ed b0       ..
	xra	a		;; 15ff: af          .
	sta	deffcb+32	;; 1600: 32 7c 00    2|.
	lxi	h,L0100		;; 1603: 21 00 01    ...
	shld	L202f		;; 1606: 22 2f 20    "/ 
	lxi	d,deffcb	;; 1609: 11 5c 00    .\.
	mvi	c,013h		;; 160c: 0e 13       ..
	call	bdos		;; 160e: cd 05 00    ...
	lxi	d,deffcb	;; 1611: 11 5c 00    .\.
	mvi	c,016h		;; 1614: 0e 16       ..
	call	bdos		;; 1616: cd 05 00    ...
	inr	a		;; 1619: 3c          <
	jz	L09db		;; 161a: ca db 09    ...
L161d:	lhld	L2031		;; 161d: 2a 31 20    *1 
	mov	a,h		;; 1620: 7c          |
	ana	a		;; 1621: a7          .
	jrnz	L1628		;; 1622: 20 04        .
	mov	a,l		;; 1624: 7d          }
	ana	a		;; 1625: a7          .
	jrz	L164b		;; 1626: 28 23       (#
L1628:	dcx	h		;; 1628: 2b          +
	shld	L2031		;; 1629: 22 31 20    "1 
	lhld	L202f		;; 162c: 2a 2f 20    */ 
	push	h		;; 162f: e5          .
	lxi	d,128		;; 1630: 11 80 00    ...
	dad	d		;; 1633: 19          .
	shld	L202f		;; 1634: 22 2f 20    "/ 
	pop	d		;; 1637: d1          .
	mvi	c,01ah		;; 1638: 0e 1a       ..
	call	bdos		;; 163a: cd 05 00    ...
	lxi	d,deffcb	;; 163d: 11 5c 00    .\.
	mvi	c,015h		;; 1640: 0e 15       ..
	call	bdos		;; 1642: cd 05 00    ...
	ana	a		;; 1645: a7          .
	jrz	L161d		;; 1646: 28 d5       (.
	jmp	L09db		;; 1648: c3 db 09    ...

L164b:	lxi	d,deffcb	;; 164b: 11 5c 00    .\.
	mvi	c,010h		;; 164e: 0e 10       ..
	call	bdos		;; 1650: cd 05 00    ...
	jmp	L0379		;; 1653: c3 79 03    .y.

L1656:	db	'VE '
L1659:	cpi	020h		;; 1659: fe 20       . 
	rz			;; 165b: c8          .
	push	h		;; 165c: e5          .
	dad	h		;; 165d: 29          )
	dad	h		;; 165e: 29          )
	dad	h		;; 165f: 29          )
	xchg			;; 1660: eb          .
	pop	h		;; 1661: e1          .
	dad	h		;; 1662: 29          )
	dad	d		;; 1663: 19          .
	mvi	d,000h		;; 1664: 16 00       ..
	sui	030h		;; 1666: d6 30       .0
	mov	e,a		;; 1668: 5f          _
	dad	d		;; 1669: 19          .
	ret			;; 166a: c9          .

L166b:	lxi	h,L1f73		;; 166b: 21 73 1f    .s.
	lxi	d,L167c		;; 166e: 11 7c 16    .|.
	call	L1794		;; 1671: cd 94 17    ...
	lxi	h,L167a		;; 1674: 21 7a 16    .z.
	jmp	L0856		;; 1677: c3 56 08    .V.

L167a:	db	'SP'
L167c:	db	'OOL   '
L1682:	lxi	h,L1f73		;; 1682: 21 73 1f    .s.
	lxi	d,L1691		;; 1685: 11 91 16    ...
	call	L1794		;; 1688: cd 94 17    ...
	lxi	h,L1696		;; 168b: 21 96 16    ...
	jmp	L0856		;; 168e: c3 56 08    .V.

L1691:	db	'BMIT '
L1696:	db	'OSUB    '
L169e:	inx	h		;; 169e: 23          #
	mov	a,m		;; 169f: 7e          ~
	cpi	054h		;; 16a0: fe 54       .T
	jrz	L16ab		;; 16a2: 28 07       (.
	cpi	059h		;; 16a4: fe 59       .Y
	jrz	L16e9		;; 16a6: 28 41       (A
	jmp	L17b2		;; 16a8: c3 b2 17    ...

L16ab:	lxi	h,L1f73		;; 16ab: 21 73 1f    .s.
	lxi	d,L0861		;; 16ae: 11 61 08    .a.
	call	L1794		;; 16b1: cd 94 17    ...
	lxi	h,deffcb+1	;; 16b4: 21 5d 00    .].
	mov	a,m		;; 16b7: 7e          ~
	cpi	' '		;; 16b8: fe 20       . 
	jz	L1af3		;; 16ba: ca f3 1a    ...
	cpi	'G'		;; 16bd: fe 47       .G
	jrz	L16db		;; 16bf: 28 1a       (.
	cpi	'N'		;; 16c1: fe 4e       .N
	jrz	L16df		;; 16c3: 28 1a       (.
	cpi	'C'		;; 16c5: fe 43       .C
	jrz	L16d0		;; 16c7: 28 07       (.
	cpi	'T'		;; 16c9: fe 54       .T
	jrz	L16d4		;; 16cb: 28 07       (.
	jmp	L1b05		;; 16cd: c3 05 1b    ...

L16d0:	mvi	a,001h		;; 16d0: 3e 01       >.
	jr	L16d5		;; 16d2: 18 01       ..

L16d4:	xra	a		;; 16d4: af          .
L16d5:	sta	L1da3		;; 16d5: 32 a3 1d    2..
	jmp	L03d8		;; 16d8: c3 d8 03    ...

L16db:	mvi	a,001h		;; 16db: 3e 01       >.
	jr	L16e0		;; 16dd: 18 01       ..

L16df:	xra	a		;; 16df: af          .
L16e0:	sta	L1da2		;; 16e0: 32 a2 1d    2..
	jmp	L03d8		;; 16e3: c3 d8 03    ...

L16e6:	db	'PE '
L16e9:	lxi	h,L1f73		;; 16e9: 21 73 1f    .s.
	lxi	d,L16e6		;; 16ec: 11 e6 16    ...
	call	L1794		;; 16ef: cd 94 17    ...
	call	L1c0a		;; 16f2: cd 0a 1c    ...
	jmp	L089d		;; 16f5: c3 9d 08    ...

L16f8:	db	'SER '

L16fc:	lxi	h,L1f72		;; 16fc: 21 72 1f    .r.
	lxi	d,L16f8		;; 16ff: 11 f8 16    ...
	call	L1794		;; 1702: cd 94 17    ...
	lda	deffcb+1	;; 1705: 3a 5d 00    :].
	cpi	020h		;; 1708: fe 20       . 
	jz	L0a14		;; 170a: ca 14 0a    ...
	lda	L1db1		;; 170d: 3a b1 1d    :..
	ani	002h		;; 1710: e6 02       ..
	jz	L1905		;; 1712: ca 05 19    ...
	lxi	h,0		;; 1715: 21 00 00    ...
	lda	deffcb+1	;; 1718: 3a 5d 00    :].
	call	L1659		;; 171b: cd 59 16    .Y.
	lda	deffcb+2	;; 171e: 3a 5e 00    :^.
	call	L1659		;; 1721: cd 59 16    .Y.
	mov	a,l		;; 1724: 7d          }
	ana	a		;; 1725: a7          .
	jm	L09a3		;; 1726: fa a3 09    ...
	cpi	010h		;; 1729: fe 10       ..
	jnc	L09a3		;; 172b: d2 a3 09    ...
	sta	L1da7		;; 172e: 32 a7 1d    2..
	sta	L1d93		;; 1731: 32 93 1d    2..
	call	L1c0a		;; 1734: cd 0a 1c    ...
	call	L0524		;; 1737: cd 24 05    .$.
	jmp	L0a14		;; 173a: c3 14 0a    ...

L173d:	lxi	d,L1746		;; 173d: 11 46 17    .F.
	call	msgout		;; 1740: cd 3b 1c    .;.
	jmp	L03d8		;; 1743: c3 d8 03    ...

; func 105 - return version string
L1746:	db	'1.85 $'

L174c:	lxi	h,L1f72		;; 174c: 21 72 1f    .r.
	lxi	d,L175b		;; 174f: 11 5b 17    .[.
	call	L1794		;; 1752: cd 94 17    ...
L1755:	lxi	h,L1760		;; 1755: 21 60 17    .`.
	jmp	L0856		;; 1758: c3 56 08    .V.

L175b:	db	'HERE '
L1760:	db	'NETUTIL '
L1768:	lxi	h,L1f74		;; 1768: 21 74 1f    .t.
	lxi	d,L1774		;; 176b: 11 74 17    .t.
	call	L1794		;; 176e: cd 94 17    ...
	jmp	L1755		;; 1771: c3 55 17    .U.

L1774:	db	'ATE '
L1778:	lxi	h,L1f72		;; 1778: 21 72 1f    .r.
	lxi	d,L1789		;; 177b: 11 89 17    ...
	call	L1794		;; 177e: cd 94 17    ...
	lxi	h,L1787		;; 1781: 21 87 17    ...
	jmp	L0856		;; 1784: c3 56 08    .V.

L1787:	db	'OX'
L1789:	db	'SUB   '
	mvi	a,030h		;; 178f: 3e 30       >0
	jmp	L1796		;; 1791: c3 96 17    ...

L1794:	mvi	a,031h		;; 1794: 3e 31       >1
L1796:	sta	L17a6		;; 1796: 32 a6 17    2..
L1799:	mov	a,m		;; 1799: 7e          ~
	cpi	030h		;; 179a: fe 30       .0
	rc			;; 179c: d8          .
	mov	b,a		;; 179d: 47          G
	ldax	d		;; 179e: 1a          .
	cmp	b		;; 179f: b8          .
	jrnz	L17a7		;; 17a0: 20 05        .
	inx	h		;; 17a2: 23          #
	inx	d		;; 17a3: 13          .
	jr	L1799		;; 17a4: 18 f3       ..

L17a6:	db	'1'
L17a7:	lda	L17a6		;; 17a7: 3a a6 17    :..
	cpi	030h		;; 17aa: fe 30       .0
	jz	L1b05		;; 17ac: ca 05 1b    ...
	lxi	sp,L20de	;; 17af: 31 de 20    1. 
L17b2:	xra	a		;; 17b2: af          .
	sta	L1d9b		;; 17b3: 32 9b 1d    2..
	inr	a		;; 17b6: 3c          <
	sta	L18b5		;; 17b7: 32 b5 18    2..
	jr	L17c1		;; 17ba: 18 05       ..

L17bc:	mvi	a,001h		;; 17bc: 3e 01       >.
	sta	L1d9b		;; 17be: 32 9b 1d    2..
L17c1:	lda	L1da7		;; 17c1: 3a a7 1d    :..
	sta	L1d93		;; 17c4: 32 93 1d    2..
	lxi	h,L1ff4		;; 17c7: 21 f4 1f    ...
	mvi	a,047h		;; 17ca: 3e 47       >G
	cmp	m		;; 17cc: be          .
	jrnz	L17da		;; 17cd: 20 0b        .
	inx	h		;; 17cf: 23          #
	mvi	a,020h		;; 17d0: 3e 20       > 
	cmp	m		;; 17d2: be          .
	jrnz	L17da		;; 17d3: 20 05        .
	mvi	a,0ffh		;; 17d5: 3e ff       >.
	sta	L1d93		;; 17d7: 32 93 1d    2..
L17da:	lda	L1da7		;; 17da: 3a a7 1d    :..
	sta	L1a51		;; 17dd: 32 51 1a    2Q.
	lda	L1ff1		;; 17e0: 3a f1 1f    :..
	ana	a		;; 17e3: a7          .
	jrnz	L17ed		;; 17e4: 20 07        .
	lda	L1db9		;; 17e6: 3a b9 1d    :..
	inr	a		;; 17e9: 3c          <
	sta	L1ff1		;; 17ea: 32 f1 1f    2..
L17ed:	lda	L1ff2		;; 17ed: 3a f2 1f    :..
	cpi	020h		;; 17f0: fe 20       . 
	jz	L1af3		;; 17f2: ca f3 1a    ...
	lda	L0a88		;; 17f5: 3a 88 0a    :..
	ana	a		;; 17f8: a7          .
	jrnz	L1801		;; 17f9: 20 06        .
	lda	L18b5		;; 17fb: 3a b5 18    :..
	ana	a		;; 17fe: a7          .
	jrnz	L1804		;; 17ff: 20 03        .
L1801:	call	L18a9		;; 1801: cd a9 18    ...
L1804:	xra	a		;; 1804: af          .
	sta	L18b5		;; 1805: 32 b5 18    2..
	mvi	c,020h		;; 1808: 0e 20       . 
	mvi	e,0ffh		;; 180a: 1e ff       ..
	call	L0cab		;; 180c: cd ab 0c    ...
	sta	L2022		;; 180f: 32 22 20    2" 
	xra	a		;; 1812: af          .
	sta	L18a8		;; 1813: 32 a8 18    2..
L1816:	xra	a		;; 1816: af          .
	sta	L1ffd		;; 1817: 32 fd 1f    2..
	sta	L1fff		;; 181a: 32 ff 1f    2..
	lxi	h,L1ff1		;; 181d: 21 f1 1f    ...
	lxi	d,L1de5		;; 1820: 11 e5 1d    ...
	lxi	b,36		;; 1823: 01 24 00    .$.
	ldir			;; 1826: ed b0       ..
	lxi	d,L1de5		;; 1828: 11 e5 1d    ...
	call	L1c35		;; 182b: cd 35 1c    .5.
	inr	a		;; 182e: 3c          <
	jz	L188e		;; 182f: ca 8e 18    ...
	xra	a		;; 1832: af          .
	sta	L1e05		;; 1833: 32 05 1e    2..
	sta	L1df1		;; 1836: 32 f1 1d    2..
	lxi	h,L0100		;; 1839: 21 00 01    ...
L183c:	shld	L18b3		;; 183c: 22 b3 18    "..
	lded	L18b3		;; 183f: ed 5b b3 18 .[..
	call	L1c25		;; 1843: cd 25 1c    .%.
	lda	bdos+2		;; 1846: 3a 07 00    :..
	dcr	a		;; 1849: 3d          =
	cmp	h		;; 184a: bc          .
	jz	L09db		;; 184b: ca db 09    ...
	lhld	L18b3		;; 184e: 2a b3 18    *..
	lxi	d,128		;; 1851: 11 80 00    ...
	dad	d		;; 1854: 19          .
	shld	L18b3		;; 1855: 22 b3 18    "..
	lxi	d,L1de5		;; 1858: 11 e5 1d    ...
	call	L1c2d		;; 185b: cd 2d 1c    .-.
	ora	a		;; 185e: b7          .
	jrz	L183c		;; 185f: 28 db       (.
	lxi	d,defdma	;; 1861: 11 80 00    ...
	call	L1c25		;; 1864: cd 25 1c    .%.
	lda	L1a51		;; 1867: 3a 51 1a    :Q.
	sta	L1da7		;; 186a: 32 a7 1d    2..
	call	L1c0a		;; 186d: cd 0a 1c    ...
	call	L0524		;; 1870: cd 24 05    .$.
	lda	L1d9b		;; 1873: 3a 9b 1d    :..
	ana	a		;; 1876: a7          .
	jnz	L03d8		;; 1877: c2 d8 03    ...
	lda	L1d96		;; 187a: 3a 96 1d    :..
	cpi	'1'		;; 187d: fe 31       .1
	jz	L1888		;; 187f: ca 88 18    ...
	lda	L1ff1		;; 1882: 3a f1 1f    :..
	sta	L2023		;; 1885: 32 23 20    2# 
L1888:	call	L0100		;; 1888: cd 00 01    ...
	jmp	L0379		;; 188b: c3 79 03    .y.

L188e:	lda	L18a8		;; 188e: 3a a8 18    :..
	ana	a		;; 1891: a7          .
	jnz	L18b6		;; 1892: c2 b6 18    ...
	inr	a		;; 1895: 3c          <
	sta	L18a8		;; 1896: 32 a8 18    2..
	mvi	a,001h		;; 1899: 3e 01       >.
	sta	L1ff1		;; 189b: 32 f1 1f    2..
	call	L18a9		;; 189e: cd a9 18    ...
	xra	a		;; 18a1: af          .
	sta	L2022		;; 18a2: 32 22 20    2" 
	jmp	L1816		;; 18a5: c3 16 18    ...

L18a8:	db	0
L18a9:	xra	a		;; 18a9: af          .
	sta	L1da7		;; 18aa: 32 a7 1d    2..
	call	L1c0a		;; 18ad: cd 0a 1c    ...
	jmp	L0524		;; 18b0: c3 24 05    .$.

L18b3:	db	0,0
L18b5:	db	0
L18b6:	lda	L1a51		;; 18b6: 3a 51 1a    :Q.
	sta	L1da7		;; 18b9: 32 a7 1d    2..
	call	L1c0a		;; 18bc: cd 0a 1c    ...
	call	L0524		;; 18bf: cd 24 05    .$.
	mvi	a,03fh		;; 18c2: 3e 3f       >?
	sta	L1ff1		;; 18c4: 32 f1 1f    2..
	sta	L1ffa		;; 18c7: 32 fa 1f    2..
	mvi	a,024h		;; 18ca: 3e 24       >$
	sta	L1ffb		;; 18cc: 32 fb 1f    2..
	lxi	d,L1ff1		;; 18cf: 11 f1 1f    ...
	call	msgout		;; 18d2: cd 3b 1c    .;.
	call	L1cfe		;; 18d5: cd fe 1c    ...
	mvi	a,001h		;; 18d8: 3e 01       >.
	sta	L1ff1		;; 18da: 32 f1 1f    2..
	mvi	a,043h		;; 18dd: 3e 43       >C
	sta	L1ffa		;; 18df: 32 fa 1f    2..
	mvi	a,04fh		;; 18e2: 3e 4f       >O
	sta	L1ffb		;; 18e4: 32 fb 1f    2..
	jmp	L0379		;; 18e7: c3 79 03    .y.

L18ea:	call	L18ef		;; 18ea: cd ef 18    ...
	jr	L1902		;; 18ed: 18 13       ..

L18ef:	xra	a		;; 18ef: af          .
	sta	L1e9f		;; 18f0: 32 9f 1e    2..
	inr	a		;; 18f3: 3c          <
	sta	L1e9e		;; 18f4: 32 9e 1e    2..
	xra	a		;; 18f7: af          .
	call	L0527		;; 18f8: cd 27 05    .'.
	sta	L1db9		;; 18fb: 32 b9 1d    2..
	sta	L1db8		;; 18fe: 32 b8 1d    2..
	ret			;; 1901: c9          .

L1902:	lxi	sp,L20de	;; 1902: 31 de 20    1. 
L1905:	lxi	d,L190b		;; 1905: 11 0b 19    ...
	jmp	L0761		;; 1908: c3 61 07    .a.

L190b:	db	'?Not privleged$'

L191a:	lda	L1db1		;; 191a: 3a b1 1d    :..
	ani	001h		;; 191d: e6 01       ..
	rz			;; 191f: c8          .
	lda	L1da7		;; 1920: 3a a7 1d    :..
	adi	'0'		;; 1923: c6 30       .0
	sta	L1951		;; 1925: 32 51 19    2Q.
	mvi	e,'['		;; 1928: 1e 5b       .[
	mvi	c,002h		;; 192a: 0e 02       ..
	call	L0cab		;; 192c: cd ab 0c    ...
	lda	L1951		;; 192f: 3a 51 19    :Q.
	cpi	'9'+1		;; 1932: fe 3a       .:
	jrc	L1942		;; 1934: 38 0c       8.
	sui	10		;; 1936: d6 0a       ..
	sta	L1951		;; 1938: 32 51 19    2Q.
	mvi	e,'1'		;; 193b: 1e 31       .1
	mvi	c,002h		;; 193d: 0e 02       ..
	call	L0cab		;; 193f: cd ab 0c    ...
L1942:	lxi	d,L1951		;; 1942: 11 51 19    .Q.
	call	msgout		;; 1945: cd 3b 1c    .;.
	lxi	d,L1da7+1	;; 1948: 11 a8 1d    ...
	call	msgout		;; 194b: cd 3b 1c    .;.
	jmp	L1cfe		;; 194e: c3 fe 1c    ...

L1951:	db	0,']  User: $'

; background printing check
L195c:	push	b		;; 195c: c5          .
	push	d		;; 195d: d5          .
	push	h		;; 195e: e5          .
	call	L1dbc	; listst
	inr	a		;; 1962: 3c          <
	jrz	L196b		;; 1963: 28 06       (.
L1965:	pop	h		;; 1965: e1          .
	pop	d		;; 1966: d1          .
	pop	b		;; 1967: c1          .
	jmp	L0b4f		;; 1968: c3 4f 0b    .O.

; print next char...
L196b:	lda	L1aab		;; 196b: 3a ab 1a    :..
	ana	a		;; 196e: a7          .
	jnz	L1a0b		;; 196f: c2 0b 1a    ...
	lxi	h,L2049		;; 1972: 21 49 20    .I 
	lxi	d,L2039		;; 1975: 11 39 20    .9 
	lxi	b,4		;; 1978: 01 04 00    ...
	ldir			;; 197b: ed b0       ..
	lda	L2049		;; 197d: 3a 49 20    :I 
	push	psw		;; 1980: f5          .
	ani	0f0h		;; 1981: e6 f0       ..
	sta	L2037		;; 1983: 32 37 20    27 
	jrz	L1994		;; 1986: 28 0c       (.
	sta	L1d9e		;; 1988: 32 9e 1d    2..
	pop	psw		;; 198b: f1          .
	ani	00fh		;; 198c: e6 0f       ..
	sta	L2049		;; 198e: 32 49 20    2I 
	jmp	L1965		;; 1991: c3 65 19    .e.

L1994:	pop	psw		;; 1994: f1          .
	lda	L204a		;; 1995: 3a 4a 20    :J 
	sta	L2036		;; 1998: 32 36 20    26 
	mov	e,a		;; 199b: 5f          _
	call	L1c12	; set user no?
	lda	L2049		;; 199f: 3a 49 20    :I 
	ani	00fh		;; 19a2: e6 0f       ..
	sta	L2038		;; 19a4: 32 38 20    28 
	lda	L204b		;; 19a7: 3a 4b 20    :K 
	sta	L1eba		;; 19aa: 32 ba 1e    2..
	lda	L204c		;; 19ad: 3a 4c 20    :L 
	sta	L1ebb		;; 19b0: 32 bb 1e    2..
L19b3:	xra	a		;; 19b3: af          .
	sta	L2049		;; 19b4: 32 49 20    2I 
	sta	L204a		;; 19b7: 32 4a 20    2J 
	sta	L204b		;; 19ba: 32 4b 20    2K 
	sta	L204c		;; 19bd: 32 4c 20    2L 
	sta	L205d		;; 19c0: 32 5d 20    2] 
	lxi	d,L203d		;; 19c3: 11 3d 20    .= 
	mvi	c,00fh	; open spool file
	call	L1a52		;; 19c8: cd 52 1a    .R.
	call	L1c0a		;; 19cb: cd 0a 1c    ...
	mvi	a,001h		;; 19ce: 3e 01       >.
	sta	L1aab		;; 19d0: 32 ab 1a    2..
	xra	a		;; 19d3: af          .
	sta	L205d		;; 19d4: 32 5d 20    2] 
	lded	L1d97		;; 19d7: ed 5b 97 1d .[..
	sded	L1d99		;; 19db: ed 53 99 1d .S..
L19df:	lda	L203d		;; 19df: 3a 3d 20    := 
	ana	a		;; 19e2: a7          .
	jz	L1a5b		;; 19e3: ca 5b 1a    .[.
	lxi	d,L1e1a		;; 19e6: 11 1a 1e    ...
	mvi	c,01ah		;; 19e9: 0e 1a       ..
	call	L1a52		;; 19eb: cd 52 1a    .R.
	lda	L2036		;; 19ee: 3a 36 20    :6 
	mov	e,a		;; 19f1: 5f          _
	call	L1c12		;; 19f2: cd 12 1c    ...
	lxi	d,L203d		;; 19f5: 11 3d 20    .= 
	mvi	c,014h		;; 19f8: 0e 14       ..
	call	L1a52		;; 19fa: cd 52 1a    .R.
	ana	a		;; 19fd: a7          .
	jnz	L1a5b		;; 19fe: c2 5b 1a    .[.
	call	L1c0a		;; 1a01: cd 0a 1c    ...
	lxi	h,L1e1a		;; 1a04: 21 1a 1e    ...
	mvi	c,080h		;; 1a07: 0e 80       ..
	jr	L1a1a		;; 1a09: 18 0f       ..

L1a0b:	lded	L1d97		;; 1a0b: ed 5b 97 1d .[..
	sded	L1d99		;; 1a0f: ed 53 99 1d .S..
	lhld	L1aa9		;; 1a13: 2a a9 1a    *..
	lda	L1aa8		;; 1a16: 3a a8 1a    :..
	mov	c,a		;; 1a19: 4f          O
L1a1a:	mov	a,m		;; 1a1a: 7e          ~
	cpi	01ah		;; 1a1b: fe 1a       ..
	jrnz	L1a27		;; 1a1d: 20 08        .
	inx	h		;; 1a1f: 23          #
	mov	a,m		;; 1a20: 7e          ~
	cpi	01ah		;; 1a21: fe 1a       ..
	jrz	L1a5b		;; 1a23: 28 36       (6
	dcx	h		;; 1a25: 2b          +
	mov	a,m		;; 1a26: 7e          ~
L1a27:	mov	e,a		;; 1a27: 5f          _
	push	h		;; 1a28: e5          .
	push	b		;; 1a29: c5          .
	mvi	c,005h		;; 1a2a: 0e 05       ..
	call	L1a52		;; 1a2c: cd 52 1a    .R.
	pop	b		;; 1a2f: c1          .
	pop	h		;; 1a30: e1          .
	inx	h		;; 1a31: 23          #
	dcr	c		;; 1a32: 0d          .
	jz	L19df		;; 1a33: ca df 19    ...
	shld	L1aa9		;; 1a36: 22 a9 1a    "..
	mov	a,c		;; 1a39: 79          y
	sta	L1aa8		;; 1a3a: 32 a8 1a    2..
L1a3d:	lded	L1d99		;; 1a3d: ed 5b 99 1d .[..
	sded	L1d97		;; 1a41: ed 53 97 1d .S..
	mvi	c,01ah		;; 1a45: 0e 1a       ..
	call	L1a52		;; 1a47: cd 52 1a    .R.
	call	L1c0a		;; 1a4a: cd 0a 1c    ...
	jmp	L1965		;; 1a4d: c3 65 19    .e.

	db	0
L1a51:	db	0

L1a52:	push	psw		;; 1a52: f5          .
	mvi	a,001h		;; 1a53: 3e 01       >.
	sta	L0dcf		;; 1a55: 32 cf 0d    2..
	jmp	L0bb3		;; 1a58: c3 b3 0b    ...

L1a5b:	mvi	e,00ch	; form feed
	mvi	c,005h	; listout
	call	L1a52		;; 1a5f: cd 52 1a    .R.
	lda	L2038		;; 1a62: 3a 38 20    :8 
	dcr	a		;; 1a65: 3d          =
	sta	L2038		;; 1a66: 32 38 20    28 
	jnz	L19b3		;; 1a69: c2 b3 19    ...
	mvi	a,020h		;; 1a6c: 3e 20       > 
	sta	L203e		;; 1a6e: 32 3e 20    2> 
	xra	a		;; 1a71: af          .
	sta	L1aab		;; 1a72: 32 ab 1a    2..
	lda	L2062		;; 1a75: 3a 62 20    :b 
	cpi	020h		;; 1a78: fe 20       . 
	jz	L1a3d		;; 1a7a: ca 3d 1a    .=.
	lxi	h,L2061		;; 1a7d: 21 61 20    .a 
	lxi	d,L203d		;; 1a80: 11 3d 20    .= 
	lxi	b,36		;; 1a83: 01 24 00    .$.
	ldir			;; 1a86: ed b0       ..
	mvi	a,020h		;; 1a88: 3e 20       > 
	sta	L2062		;; 1a8a: 32 62 20    2b 
	lda	L2086		;; 1a8d: 3a 86 20    :. 
	cpi	020h		;; 1a90: fe 20       . 
	jz	L1a3d		;; 1a92: ca 3d 1a    .=.
	lxi	h,L2085		;; 1a95: 21 85 20    .. 
	lxi	d,L2061		;; 1a98: 11 61 20    .a 
	lxi	b,16		;; 1a9b: 01 10 00    ...
	ldir			;; 1a9e: ed b0       ..
	mvi	a,020h		;; 1aa0: 3e 20       > 
	sta	L2086		;; 1aa2: 32 86 20    2. 
	jmp	L1a3d		;; 1aa5: c3 3d 1a    .=.

L1aa8:	db	0
L1aa9:	db	0,0
L1aab:	db	0

L1aac:	cpi	020h		;; 1aac: fe 20       . 
	jrc	L1ac3		;; 1aae: 38 13       8.
	mvi	a,03fh		;; 1ab0: 3e 3f       >?
	sta	L1f70		;; 1ab2: 32 70 1f    2p.
	sta	L1f72		;; 1ab5: 32 72 1f    2r.
	mvi	a,024h		;; 1ab8: 3e 24       >$
	sta	L1f73		;; 1aba: 32 73 1f    2s.
L1abd:	lxi	d,L1f70		;; 1abd: 11 70 1f    .p.
	jmp	L0761		;; 1ac0: c3 61 07    .a.

L1ac3:	cpi	01ah		;; 1ac3: fe 1a       ..
	jz	L1b8d		;; 1ac5: ca 8d 1b    ...
	mvi	a,03fh		;; 1ac8: 3e 3f       >?
	sta	L1f70		;; 1aca: 32 70 1f    2p.
	sta	L1f73		;; 1acd: 32 73 1f    2s.
	lda	L1f71		;; 1ad0: 3a 71 1f    :q.
	adi	040h		;; 1ad3: c6 40       .@
	sta	L1f72		;; 1ad5: 32 72 1f    2r.
	mvi	a,05eh		;; 1ad8: 3e 5e       >^
	sta	L1f71		;; 1ada: 32 71 1f    2q.
	mvi	a,024h		;; 1add: 3e 24       >$
	sta	L1f74		;; 1adf: 32 74 1f    2t.
	jr	L1abd		;; 1ae2: 18 d9       ..

	; orphan
	lxi	d,L1d7d	; "File already exist"
	call	msgout		;; 1ae7: cd 3b 1c    .;.
	lxi	h,deffcb	;; 1aea: 21 5c 00    .\.
	call	L1b3c	; print file name
	jmp	L03d8	; CR/LF, prompt for next command

L1af3:	lxi	d,L1d6f		;; 1af3: 11 6f 1d    .o.
	jmp	L0761		;; 1af6: c3 61 07    .a.

	lxi	d,L1d5a		;; 1af9: 11 5a 1d    .Z.
	call	msgout		;; 1afc: cd 3b 1c    .;.
	call	L1b3c		;; 1aff: cd 3c 1b    .<.
	jmp	L03d8		;; 1b02: c3 d8 03    ...

L1b05:	mvi	e,03fh		;; 1b05: 1e 3f       .?
	call	L1b9d		;; 1b07: cd 9d 1b    ...
	lxi	h,defdma+1	;; 1b0a: 21 81 00    ...
L1b0d:	mov	a,m		;; 1b0d: 7e          ~
	ana	a		;; 1b0e: a7          .
	jrz	L1b18		;; 1b0f: 28 07       (.
	mov	e,a		;; 1b11: 5f          _
	call	L1b9d		;; 1b12: cd 9d 1b    ...
	inx	h		;; 1b15: 23          #
	jr	L1b0d		;; 1b16: 18 f5       ..

L1b18:	mvi	e,03fh		;; 1b18: 1e 3f       .?
	call	L1b9d		;; 1b1a: cd 9d 1b    ...
	jmp	L03d8		;; 1b1d: c3 d8 03    ...

	push	h		;; 1b20: e5          .
L1b21:	mov	a,m		;; 1b21: 7e          ~
	cpi	020h		;; 1b22: fe 20       . 
	jrz	L1b2d		;; 1b24: 28 07       (.
	mov	e,a		;; 1b26: 5f          _
	call	L1b9d		;; 1b27: cd 9d 1b    ...
	inx	h		;; 1b2a: 23          #
	jr	L1b21		;; 1b2b: 18 f4       ..

L1b2d:	mvi	e,03ah		;; 1b2d: 1e 3a       .:
	call	L1b9d		;; 1b2f: cd 9d 1b    ...
	mvi	e,020h		;; 1b32: 1e 20       . 
	call	L1b9d		;; 1b34: cd 9d 1b    ...
	lxi	h,deffcb	;; 1b37: 21 5c 00    .\.
	jr	L1b3d		;; 1b3a: 18 01       ..

; print file name from FCB
L1b3c:	push	h		;; 1b3c: e5          .
L1b3d:	mov	a,m		;; 1b3d: 7e          ~
	ana	a		;; 1b3e: a7          .
	jrnz	L1b4a		;; 1b3f: 20 09        .
	xra	a		;; 1b41: af          .
	sta	L1b7c		;; 1b42: 32 7c 1b    2|.
	sta	L1b7d		;; 1b45: 32 7d 1b    2}.
	jr	L1b54		;; 1b48: 18 0a       ..

L1b4a:	adi	'A'-1		;; 1b4a: c6 40       .@
	sta	L1b7c		;; 1b4c: 32 7c 1b    2|.
	mvi	a,':'		;; 1b4f: 3e 3a       >:
	sta	L1b7d		;; 1b51: 32 7d 1b    2}.
L1b54:	lxi	d,L1b7e		;; 1b54: 11 7e 1b    .~.
	inx	h		;; 1b57: 23          #
	lxi	b,8		;; 1b58: 01 08 00    ...
	ldir			;; 1b5b: ed b0       ..
	inx	d		;; 1b5d: 13          .
	lxi	b,3		;; 1b5e: 01 03 00    ...
	ldir			;; 1b61: ed b0       ..
	lxi	h,L1b7b		;; 1b63: 21 7b 1b    .{.
	mvi	c,14		;; 1b66: 0e 0e       ..
L1b68:	mov	a,m		;; 1b68: 7e          ~
	cpi	' '		;; 1b69: fe 20       . 
	jrnz	L1b6f		;; 1b6b: 20 02        .
	mvi	m,0		;; 1b6d: 36 00       6.
L1b6f:	inx	h		;; 1b6f: 23          #
	dcr	c		;; 1b70: 0d          .
	jrnz	L1b68		;; 1b71: 20 f5        .
	lxi	d,L1b7b		;; 1b73: 11 7b 1b    .{.
	call	msgout		;; 1b76: cd 3b 1c    .;.
	pop	h		;; 1b79: e1          .
	ret			;; 1b7a: c9          .

L1b7b:	db	' '
L1b7c:	db	'A'
L1b7d:	db	':'
L1b7e:	db	'FILENAME.',0,0,0,0dh,0ah,'$'

L1b8d:	mov	e,a		;; 1b8d: 5f          _
	call	L1b9d		;; 1b8e: cd 9d 1b    ...
	jmp	L03dd		;; 1b91: c3 dd 03    ...

L1b94:	db	0
L1b95:	db	0

L1b96:	mov	a,e		;; 1b96: 7b          {
	cpi	0ffh		;; 1b97: fe ff       ..
	jz	L0caa		;; 1b99: ca aa 0c    ...
	pop	psw		;; 1b9c: f1          .
L1b9d:	push	psw		;; 1b9d: f5          .
	push	h		;; 1b9e: e5          .
	mov	a,e		;; 1b9f: 7b          {
	cpi	00ah		;; 1ba0: fe 0a       ..
	jrz	L1bd1		;; 1ba2: 28 2d       (-
	cpi	00dh		;; 1ba4: fe 0d       ..
	jrz	L1bcd		;; 1ba6: 28 25       (%
	cpi	01ah		;; 1ba8: fe 1a       ..
	jrz	L1bcd		;; 1baa: 28 21       (.
	cpi	009h		;; 1bac: fe 09       ..
	jrz	L1bb9		;; 1bae: 28 09       (.
	lda	L1b94		;; 1bb0: 3a 94 1b    :..
	inr	a		;; 1bb3: 3c          <
	sta	L1b94		;; 1bb4: 32 94 1b    2..
	jr	L1bd1		;; 1bb7: 18 18       ..

L1bb9:	mvi	e,020h		;; 1bb9: 1e 20       . 
	mvi	c,006h		;; 1bbb: 0e 06       ..
	call	L0cab		;; 1bbd: cd ab 0c    ...
	lda	L1b94		;; 1bc0: 3a 94 1b    :..
	inr	a		;; 1bc3: 3c          <
	sta	L1b94		;; 1bc4: 32 94 1b    2..
	ani	007h		;; 1bc7: e6 07       ..
	jrnz	L1bb9		;; 1bc9: 20 ee        .
	jr	L1bd6		;; 1bcb: 18 09       ..

L1bcd:	xra	a		;; 1bcd: af          .
	sta	L1b94		;; 1bce: 32 94 1b    2..
L1bd1:	mvi	c,006h		;; 1bd1: 0e 06       ..
	call	L0cab		;; 1bd3: cd ab 0c    ...
L1bd6:	lda	L1b95		;; 1bd6: 3a 95 1b    :..
	ana	a		;; 1bd9: a7          .
	jrnz	L1bf9		;; 1bda: 20 1d        .
	mvi	e,0ffh		;; 1bdc: 1e ff       ..
	mvi	c,006h		;; 1bde: 0e 06       ..
	call	L0cab		;; 1be0: cd ab 0c    ...
	ana	a		;; 1be3: a7          .
	jrz	L1bf9		;; 1be4: 28 13       (.
	cpi	013h		;; 1be6: fe 13       ..
	jrnz	L1bfc		;; 1be8: 20 12        .
L1bea:	mvi	c,006h		;; 1bea: 0e 06       ..
	mvi	e,0ffh		;; 1bec: 1e ff       ..
	call	L0b3c		;; 1bee: cd 3c 0b    .<.
	ana	a		;; 1bf1: a7          .
	jrz	L1bea		;; 1bf2: 28 f6       (.
	cpi	003h		;; 1bf4: fe 03       ..
	jz	L1ce7		;; 1bf6: ca e7 1c    ...
L1bf9:	pop	h		;; 1bf9: e1          .
	pop	psw		;; 1bfa: f1          .
	ret			;; 1bfb: c9          .

L1bfc:	sta	L1b95		;; 1bfc: 32 95 1b    2..
	jr	L1bf9		;; 1bff: 18 f8       ..

	mvi	a,001h		;; 1c01: 3e 01       >.
	sta	L1c24		;; 1c03: 32 24 1c    2$.
	mvi	e,000h		;; 1c06: 1e 00       ..
	jr	L1c12		;; 1c08: 18 08       ..

; set user num from L1da7
L1c0a:	xra	a		;; 1c0a: af          .
	sta	L1c24		;; 1c0b: 32 24 1c    2$.
	lda	L1da7		;; 1c0e: 3a a7 1d    :..
	mov	e,a		;; 1c11: 5f          _
L1c12:	mvi	c,020h		;; 1c12: 0e 20       . 
	jmp	L0cab		;; 1c14: c3 ab 0c    ...

L1c17:	push	h		;; 1c17: e5          .
	push	d		;; 1c18: d5          .
	mvi	c,020h		;; 1c19: 0e 20       . 
	mvi	a,0ffh		;; 1c1b: 3e ff       >.
	mov	e,a		;; 1c1d: 5f          _
	call	L0cd8		;; 1c1e: cd d8 0c    ...
	pop	d		;; 1c21: d1          .
	pop	h		;; 1c22: e1          .
	ret			;; 1c23: c9          .

L1c24:	db	0

; set DMA addr
L1c25:	push	h		;; 1c25: e5          .
	mvi	c,01ah		;; 1c26: 0e 1a       ..
	call	L1a52	; make NDOS call
	pop	h		;; 1c2b: e1          .
	ret			;; 1c2c: c9          .

L1c2d:	push	h		;; 1c2d: e5          .
	mvi	c,014h		;; 1c2e: 0e 14       ..
	call	bdos		;; 1c30: cd 05 00    ...
	pop	h		;; 1c33: e1          .
	ret			;; 1c34: c9          .

L1c35:	mvi	c,00fh		;; 1c35: 0e 0f       ..
	jmp	bdos		;; 1c37: c3 05 00    ...

; pop stack and print string.
L1c3a:	pop	psw		;; 1c3a: f1          .
; print string to console, term '$'
msgout:	push	psw		;; 1c3b: f5          .
	push	h		;; 1c3c: e5          .
	xchg			;; 1c3d: eb          .
L1c3e:	mov	a,m		;; 1c3e: 7e          ~
	cpi	'$'		;; 1c3f: fe 24       .$
	jrz	L1c4a		;; 1c41: 28 07       (.
	mov	e,a		;; 1c43: 5f          _
	call	L1b9d		;; 1c44: cd 9d 1b    ...
	inx	h		;; 1c47: 23          #
	jr	L1c3e		;; 1c48: 18 f4       ..

L1c4a:	pop	h		;; 1c4a: e1          .
	pop	psw		;; 1c4b: f1          .
	ret			;; 1c4c: c9          .

L1c4d:	pop	psw		;; 1c4d: f1          .
L1c4e:	lda	L1b95		;; 1c4e: 3a 95 1b    :..
	ana	a		;; 1c51: a7          .
	jrnz	L1c5c		;; 1c52: 20 08        .
	mvi	c,00bh		;; 1c54: 0e 0b       ..
	call	L0b3c		;; 1c56: cd 3c 0b    .<.
	ana	a		;; 1c59: a7          .
	jrz	L1c4e		;; 1c5a: 28 f2       (.
L1c5c:	mvi	c,001h		;; 1c5c: 0e 01       ..
	jmp	L0cab		;; 1c5e: c3 ab 0c    ...

L1c61:	pop	psw		;; 1c61: f1          .
L1c62:	ldax	d		;; 1c62: 1a          .
	sta	L1c99+1		;; 1c63: 32 9a 1c    2..
	inx	d		;; 1c66: 13          .
	sded	L20ac		;; 1c67: ed 53 ac 20 .S. 
	mvi	b,000h		;; 1c6b: 06 00       ..
L1c6d:	push	b		;; 1c6d: c5          .
L1c6e:	push	d		;; 1c6e: d5          .
	call	L1c4e	; get char
	pop	d		;; 1c72: d1          .
	pop	b		;; 1c73: c1          .
	ani	07fh		;; 1c74: e6 7f       ..
	cpi	003h	; Ctrl-C
	jz	L1ce7		;; 1c78: ca e7 1c    ...
	cpi	008h	; BS
	jrz	L1cb0		;; 1c7d: 28 31       (1
	cpi	018h	; Ctrl-X
	jrz	L1cc4		;; 1c81: 28 41       (A
	cpi	015h	; Ctrl-U
	jrz	L1cc4		;; 1c85: 28 3d       (=
	cpi	07fh	; DEL
	jrz	L1ca1		;; 1c89: 28 16       (.
	cpi	00ah	; LF
	jz	L1cf7		;; 1c8d: ca f7 1c    ...
	cpi	00dh	; CR
	jz	L1cf7		;; 1c92: ca f7 1c    ...
	inr	b		;; 1c95: 04          .
	inx	d		;; 1c96: 13          .
	stax	d		;; 1c97: 12          .
	mov	a,b		;; 1c98: 78          x
L1c99:	cpi	07fh		;; 1c99: fe 7f       ..
	jnz	L1c6d		;; 1c9b: c2 6d 1c    .m.
	jmp	L1cf7		;; 1c9e: c3 f7 1c    ...

L1ca1:	push	d		;; 1ca1: d5          .
	push	b		;; 1ca2: c5          .
	lxi	d,L1cf3		;; 1ca3: 11 f3 1c    ...
	call	msgout		;; 1ca6: cd 3b 1c    .;.
	mvi	e,008h		;; 1ca9: 1e 08       ..
	call	L1b9d		;; 1cab: cd 9d 1b    ...
	pop	b		;; 1cae: c1          .
	pop	d		;; 1caf: d1          .
L1cb0:	mov	a,b		;; 1cb0: 78          x
	ana	a		;; 1cb1: a7          .
	jz	L1cd9		;; 1cb2: ca d9 1c    ...
	push	b		;; 1cb5: c5          .
	push	d		;; 1cb6: d5          .
	lxi	d,L1cf3+1	;; 1cb7: 11 f4 1c    ...
	call	msgout		;; 1cba: cd 3b 1c    .;.
	pop	d		;; 1cbd: d1          .
	pop	b		;; 1cbe: c1          .
	dcx	d		;; 1cbf: 1b          .
	dcr	b		;; 1cc0: 05          .
	jmp	L1c6d		;; 1cc1: c3 6d 1c    .m.

L1cc4:	dcr	b		;; 1cc4: 05          .
	jm	L1cd5		;; 1cc5: fa d5 1c    ...
	dcx	d		;; 1cc8: 1b          .
	push	b		;; 1cc9: c5          .
	push	d		;; 1cca: d5          .
	lxi	d,L1cf3		;; 1ccb: 11 f3 1c    ...
	call	msgout		;; 1cce: cd 3b 1c    .;.
	pop	d		;; 1cd1: d1          .
	pop	b		;; 1cd2: c1          .
	jr	L1cc4		;; 1cd3: 18 ef       ..

L1cd5:	inr	b		;; 1cd5: 04          .
	jmp	L1c6d		;; 1cd6: c3 6d 1c    .m.

L1cd9:	push	b		;; 1cd9: c5          .
	push	d		;; 1cda: d5          .
	mvi	e,'>'		;; 1cdb: 1e 3e       .>
	mvi	c,006h		;; 1cdd: 0e 06       ..
	call	L0cab		;; 1cdf: cd ab 0c    ...
	pop	d		;; 1ce2: d1          .
	pop	b		;; 1ce3: c1          .
	jmp	L1c6d	; input line w/edit

L1ce7:	lxi	d,L1cf0		;; 1ce7: 11 f0 1c    ...
	call	msgout		;; 1cea: cd 3b 1c    .;.
	jmp	L0379		;; 1ced: c3 79 03    .y.

L1cf0:	db	'^C$'

L1cf3:	db	8,' ',8,'$'

; done with line input, B=len
L1cf7:	lded	L20ac		;; 1cf7: ed 5b ac 20 .[. 
	mov	a,b		;; 1cfb: 78          x
	stax	d		;; 1cfc: 12          .
	ret			;; 1cfd: c9          .

; print CR/LF
L1cfe:	lxi	d,L1d4f	; CR/LF
	jmp	msgout		;; 1d01: c3 3b 1c    .;.

fill:	mov	m,a		;; 1d04: 77          w
	inx	h		;; 1d05: 23          #
	dcr	c		;; 1d06: 0d          .
	jrnz	fill		;; 1d07: 20 fb        .
	ret			;; 1d09: c9          .

L1d0a:	db	'ULC-OPSnet v1.85 Workstation, Node '
L1d2d:	db	'0'
	dbq	0dh,0ah,'OPSnet (c) 1985 by Aquinas Inc.'
L1d4f:	db	0dh,0ah,'$'

L1d52:	db	0dh,0ah,'<'
L1d55:	db	'X$'

L1d57:	db	'0>$'

L1d5a:	db	'?No such file(s) as $'
L1d6f:	db	'?Too few args$'
L1d7d:	db	'?File already exist: $'

L1d93:	db	0ffh
L1d94:	db	1,0
L1d96:	db	'0'
L1d97:	db	80h,0
L1d99:	db	80h,0
L1d9b:	db	0
L1d9c:	db	0
L1d9d:	db	0
L1d9e:	db	0
L1d9f:	db	2,'2'
L1da1:	db	0
L1da2:	db	0
L1da3:	db	1
L1da4:	db	0
L1da5:	db	0
L1da6:	db	'N'

L1da7:	db	0	; node id / user num?
	db	' ',3,0,5,0,5
	db	'BDO'
L1db1:	db	'0990'
	db	'$'
L1db6:	db	'0'
L1db7:	db	0
L1db8:	db	0
L1db9:	db	0
L1dba:	db	0
L1dbb:	db	0
L1dbc:	jmp	00000h	; dyn adr - wboote+42 - listst

L1dbf:	db	1,'$$$     SUB',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
L1de0:	db	0ffh,0ffh,0
L1de3:	db	0
L1de4:	db	0
L1de5:	db	'B'
L1de6:	db	'DOSXV',13h,0ch,0d8h
L1dee:	db	21h,85h,'B'
L1df1:	db	'DOSZ'

; I/O config... "network vector block"
; set by "INET KAYPRO [...]" to:
;	6,6,6,6,4,4,4,4,4,1,1,1,nid,1,
netvec:	db	20h,13h,1,0dbh	; SIO ctl/sts port
	db	2,2,'BD'	; SIO data port
	db	'R'		; SIO TxE mask
	db	'ERH'		; SIO RxA mask
	db	'3'		; node id
	db	2		; flag ... NZ == standard DTR
	db	0eh,2	; ??? - not set?

L1e05:	db	'@BDRE'
	db	'RR3',2,'<',2,'dBERET 3',2,14h

L1e1a:	db	2,'CBERR  3',2,'n',2,86h,'BERRET',13h,2,',',2,'VBFRERH3',2
	db	12h,2,'BBFRER'
	db	'R3',2,'A',2,'fBLA'
	db	'NK 3',1bh,8dh,'ERBOOT  ',3,0,0,0,4,'BP1C1 3',0dh,14h,'"(BP1'
	db	'C2 3',0ch,0d3h,21h,81h,'BPC1 '
	db	' 3',0dh,0eh,'"$BPC'
	db	'4  3',0ch,0cdh,21h,'wBPS3  3',0ch,0c4h,21h,'qBSE'
	db	'RV',1ah
L1e9b:	db	0
L1e9c:	db	0,0
L1e9e:	db	0
L1e9f:	db	0
L1ea0:	db	0,0,0
	db	0,0
	db	0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0
L1eba:	db	0
L1ebb:	db	0,0,0
L1ebe:	db	0
L1ebf:	db	0,0,0,0,0,0
L1ec5:	db	0
L1ec6:	db	0,0
L1ec8:	db	0
L1ec9:	db	0
L1eca:	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0
L1eea:	db	0,0,0
L1eed:	db	0
L1eee:	db	0
L1eef:	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
L1f6f:	db	7fh
L1f70:	db	7fh
L1f71:	db	7fh
L1f72:	db	7fh
L1f73:	db	7fh
L1f74:	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh,7fh,7fh,7fh,7fh
L1ff1:	db	7fh
L1ff2:	db	7fh,7fh
L1ff4:	db	7fh,7fh,7fh,7fh,7fh,7fh
L1ffa:	db	7fh
L1ffb:	db	7fh,7fh
L1ffd:	db	7fh,7fh
L1fff:	db	7fh
	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh,7fh
	db	7fh,7fh
L2022:	db	7fh
L2023:	db	7fh
L2024:	db	7fh,7fh
L2026:	db	7fh,7fh
L2028:	db	7fh,7fh
L202a:	db	7fh
L202b:	db	7fh,7fh
L202d:	db	7fh,7fh
L202f:	db	7fh,7fh
L2031:	db	7fh,7fh
L2033:	db	7fh
L2034:	db	7fh,7fh	; orig wboot entry
L2036:	db	7fh
L2037:	db	7fh
L2038:	db	7fh
L2039:	db	7fh,7fh,7fh,7fh
L203d:	db	7fh
L203e:	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh
L2045:	db	7fh,7fh,7fh,7fh
L2049:	db	7fh
L204a:	db	7fh
L204b:	db	7fh
L204c:	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
L2059:	db	7fh,7fh,7fh,7fh
L205d:	db	7fh,7fh,7fh,7fh
L2061:	db	7fh
L2062:	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh,7fh,7fh,7fh,7fh
L2085:	db	7fh
L2086:	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh,7fh,7fh,7fh,7fh,7fh
L20aa:	db	7fh
L20ab:	db	7fh
L20ac:	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh,7fh,7fh,7fh,7fh
L20de:	ds	0
	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh,7fh,7fh
L210e:	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
L2126:	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh
L2136:	db	7fh

L2137:	db	7fh	; msg status flag?
			; 0 = idle / done
			; 1 = L11ad
			; 2 = 1129:
			; 3 = L110d
			; else L11e7
	; msg buf
L2138:	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	ds	2148	; 2220 total
L29e4:	ds	2
	end

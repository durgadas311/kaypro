	org	00100h
L0100:	lxi	sp,L20dc	;; 0100: 31 dc 20    1. 
	xra	a		;; 0103: af          .
	lxi	h,L1fef		;; 0104: 21 ef 1f    ...
	mvi	c,023h		;; 0107: 0e 23       .#
	call	L1cc6		;; 0109: cd c6 1c    ...
	lxi	h,L1e9a		;; 010c: 21 9a 1e    ...
	mvi	c,022h		;; 010f: 0e 22       ."
	call	L1cc6		;; 0111: cd c6 1c    ...
	lxi	h,L01ca		;; 0114: 21 ca 01    ...
	lxi	d,L1ff8		;; 0117: 11 f8 1f    ...
	lxi	b,00003h	;; 011a: 01 03 00    ...
	ldir			;; 011d: ed b0       ..
	lxi	h,L1ebc		;; 011f: 21 bc 1e    ...
	mvi	c,032h		;; 0122: 0e 32       .2
	call	L1cc6		;; 0124: cd c6 1c    ...
	mvi	a,064h		;; 0127: 3e 64       >d
	sta	L1ec3		;; 0129: 32 c3 1e    2..
	lxi	h,000a7h	;; 012c: 21 a7 00    ...
	shld	L1ec4		;; 012f: 22 c4 1e    "..
	mvi	a,001h		;; 0132: 3e 01       >.
	sta	L1e9c		;; 0134: 32 9c 1e    2..
	inr	a		;; 0137: 3c          <
	sta	L1e9e		;; 0138: 32 9e 1e    2..
	mvi	a,080h		;; 013b: 3e 80       >.
	sta	L1f6d		;; 013d: 32 6d 1f    2m.
	lhld	00001h		;; 0140: 2a 01 00    *..
	shld	L2032		;; 0143: 22 32 20    "2 
	lxi	d,00007h	;; 0146: 11 07 00    ...
	dad	d		;; 0149: 19          .
	shld	L0325		;; 014a: 22 25 03    "%.
	dcx	h		;; 014d: 2b          +
	dcx	h		;; 014e: 2b          +
	dcx	h		;; 014f: 2b          +
	dcx	h		;; 0150: 2b          +
	shld	L0da6		;; 0151: 22 a6 0d    "..
	lxi	d,00027h	;; 0154: 11 27 00    .'.
	dad	d		;; 0157: 19          .
	shld	L1d7d		;; 0158: 22 7d 1d    "}.
	lhld	00006h		;; 015b: 2a 06 00    *..
	shld	L0c96		;; 015e: 22 96 0c    "..
	lhld	L2032		;; 0161: 2a 32 20    *2 
	lxi	d,0f203h	;; 0164: 11 03 f2    ...
	dad	d		;; 0167: 19          .
	push	h		;; 0168: e5          .
	inx	h		;; 0169: 23          #
	inx	h		;; 016a: 23          #
	inx	h		;; 016b: 23          #
	lxi	d,L01fd		;; 016c: 11 fd 01    ...
	mov	m,e		;; 016f: 73          s
	inx	h		;; 0170: 23          #
	mov	m,d		;; 0171: 72          r
	inx	h		;; 0172: 23          #
	lxi	d,L0201		;; 0173: 11 01 02    ...
	mov	m,e		;; 0176: 73          s
	inx	h		;; 0177: 23          #
	mov	m,d		;; 0178: 72          r
	inx	h		;; 0179: 23          #
	lxi	d,L0205		;; 017a: 11 05 02    ...
	mov	m,e		;; 017d: 73          s
	inx	h		;; 017e: 23          #
	mov	m,d		;; 017f: 72          r
	inx	h		;; 0180: 23          #
	lxi	d,L0209		;; 0181: 11 09 02    ...
	mov	m,e		;; 0184: 73          s
	inx	h		;; 0185: 23          #
	mov	m,d		;; 0186: 72          r
	lxi	d,L0619		;; 0187: 11 19 06    ...
	dad	d		;; 018a: 19          .
	xra	a		;; 018b: af          .
	mov	m,a		;; 018c: 77          w
	pop	h		;; 018d: e1          .
	lxi	d,L0dd3		;; 018e: 11 d3 0d    ...
	dad	d		;; 0191: 19          .
	shld	L0c79		;; 0192: 22 79 0c    "y.
	lxi	d,00011h	;; 0195: 11 11 00    ...
	dad	d		;; 0198: 19          .
	shld	L0cc2		;; 0199: 22 c2 0c    "..
	shld	L0c81		;; 019c: 22 81 0c    "..
	inx	h		;; 019f: 23          #
	shld	L0cc8		;; 01a0: 22 c8 0c    "..
	shld	L0c87		;; 01a3: 22 87 0c    "..
	lhld	L0325		;; 01a6: 2a 25 03    *%.
	mov	a,m		;; 01a9: 7e          ~
	sta	L0325		;; 01aa: 32 25 03    2%.
	inx	h		;; 01ad: 23          #
	mov	a,m		;; 01ae: 7e          ~
	sta	L0326		;; 01af: 32 26 03    2&.
	lxi	d,L030c		;; 01b2: 11 0c 03    ...
	mov	m,d		;; 01b5: 72          r
	dcx	h		;; 01b6: 2b          +
	mov	m,e		;; 01b7: 73          s
	mvi	a,020h		;; 01b8: 3e 20       > 
	sta	L203c		;; 01ba: 32 3c 20    2< 
	sta	L2060		;; 01bd: 32 60 20    2` 
	sta	L2084		;; 01c0: 32 84 20    2. 
	xra	a		;; 01c3: af          .
	sta	L20a8		;; 01c4: 32 a8 20    2. 
	jmp	L0335		;; 01c7: c3 35 03    .5.

L01ca:	db	'COM'
L01cd:	sspd	L2022		;; 01cd: ed 73 22 20 .s" 
	lxi	sp,L210c	;; 01d1: 31 0c 21    1..
	jr	L020f		;; 01d4: 18 39       .9

L01d6:	push	psw		;; 01d6: f5          .
	push	h		;; 01d7: e5          .
	push	b		;; 01d8: c5          .
	push	d		;; 01d9: d5          .
	lda	L1d61		;; 01da: 3a 61 1d    :a.
	ana	a		;; 01dd: a7          .
	jrz	L01f6		;; 01de: 28 16       (.
	lxi	h,00009h	;; 01e0: 21 09 00    ...
	dad	d		;; 01e3: 19          .
	mov	a,m		;; 01e4: 7e          ~
	ani	07fh		;; 01e5: e6 7f       ..
	cpi	044h		;; 01e7: fe 44       .D
	jrnz	L01f6		;; 01e9: 20 0b        .
	mov	a,c		;; 01eb: 79          y
	cpi	00fh		;; 01ec: fe 0f       ..
	jz	L02a9		;; 01ee: ca a9 02    ...
	cpi	010h		;; 01f1: fe 10       ..
	jz	L02de		;; 01f3: ca de 02    ...
L01f6:	pop	d		;; 01f6: d1          .
	pop	b		;; 01f7: c1          .
	pop	h		;; 01f8: e1          .
	pop	psw		;; 01f9: f1          .
	jmp	L0c5e		;; 01fa: c3 5e 0c    .^.

L01fd:	mvi	a,0e1h		;; 01fd: 3e e1       >.
L01ff:	jr	L020b		;; 01ff: 18 0a       ..

L0200	equ	$-1
L0201:	mvi	a,0f2h		;; 0201: 3e f2       >.
	jr	L020b		;; 0203: 18 06       ..

L0205:	mvi	a,0f3h		;; 0205: 3e f3       >.
	jr	L020b		;; 0207: 18 02       ..

L0209:	mvi	a,0f4h		;; 0209: 3e f4       >.
L020b:	sta	L0265		;; 020b: 32 65 02    2e.
	ret			;; 020e: c9          .

L020f:	call	L0aef		;; 020f: cd ef 0a    ...
	push	psw		;; 0212: f5          .
	cpi	0e1h		;; 0213: fe e1       ..
	jrz	L0229		;; 0215: 28 12       (.
	cpi	0f2h		;; 0217: fe f2       ..
	jrz	L022e		;; 0219: 28 13       (.
	cpi	0f3h		;; 021b: fe f3       ..
	jrz	L0233		;; 021d: 28 14       (.
	cpi	0f4h		;; 021f: fe f4       ..
	jrz	L0238		;; 0221: 28 15       (.
L0223:	pop	psw		;; 0223: f1          .
	lspd	L2022		;; 0224: ed 7b 22 20 .{" 
	ret			;; 0228: c9          .

L0229:	lxi	d,L027f		;; 0229: 11 7f 02    ...
	jr	L023b		;; 022c: 18 0d       ..

L022e:	lxi	d,L028a		;; 022e: 11 8a 02    ...
	jr	L023b		;; 0231: 18 08       ..

L0233:	lxi	d,L0291		;; 0233: 11 91 02    ...
	jr	L023b		;; 0236: 18 03       ..

L0238:	lxi	d,L029b		;; 0238: 11 9b 02    ...
L023b:	push	d		;; 023b: d5          .
	lda	L0279		;; 023c: 3a 79 02    :y.
	adi	040h		;; 023f: c6 40       .@
	sta	L0279		;; 0241: 32 79 02    2y.
	lxi	d,L0266		;; 0244: 11 66 02    .f.
	mvi	c,009h		;; 0247: 0e 09       ..
	call	L0c5e		;; 0249: cd 5e 0c    .^.
	pop	d		;; 024c: d1          .
	mvi	c,009h		;; 024d: 0e 09       ..
	call	L0c5e		;; 024f: cd 5e 0c    .^.
	mvi	c,001h		;; 0252: 0e 01       ..
	call	L0c5e		;; 0254: cd 5e 0c    .^.
	cpi	003h		;; 0257: fe 03       ..
	jrnz	L0223		;; 0259: 20 c8        .
	xra	a		;; 025b: af          .
	sta	L1d79		;; 025c: 32 79 1d    2y.
	call	L04ec		;; 025f: cd ec 04    ...
	jmp	L033e		;; 0262: c3 3e 03    .>.

L0265:	db	0
L0266:	db	0dh,0ah,7,'? BDOS Error on '
L0279:	db	'x: - $'
L027f:	db	'Bad Sector$'
L028a:	db	'Select$'
L0291:	db	'Drive R/O$'
L029b:	db	'File R/O$'
	pop	d		;; 02a4: d1          .
	pop	b		;; 02a5: c1          .
	pop	h		;; 02a6: e1          .
	pop	psw		;; 02a7: f1          .
	ret			;; 02a8: c9          .

L02a9:	pop	d		;; 02a9: d1          .
	push	d		;; 02aa: d5          .
	mvi	c,00fh		;; 02ab: 0e 0f       ..
	call	L0c5e		;; 02ad: cd 5e 0c    .^.
	inr	a		;; 02b0: 3c          <
	jz	L01f6		;; 02b1: ca f6 01    ...
	pop	h		;; 02b4: e1          .
	push	h		;; 02b5: e5          .
	lxi	d,00004h	;; 02b6: 11 04 00    ...
	dad	d		;; 02b9: 19          .
	mov	a,m		;; 02ba: 7e          ~
	ani	080h		;; 02bb: e6 80       ..
	jrz	L02c6		;; 02bd: 28 07       (.
L02bf:	mvi	a,001h		;; 02bf: 3e 01       >.
	sta	L1de1		;; 02c1: 32 e1 1d    2..
	jr	L02fc		;; 02c4: 18 36       .6

L02c6:	lda	L1de2		;; 02c6: 3a e2 1d    :..
	cpi	05ah		;; 02c9: fe 5a       .Z
	jrnz	L02bf		;; 02cb: 20 f2        .
	mov	a,m		;; 02cd: 7e          ~
	ori	080h		;; 02ce: f6 80       ..
	mov	m,a		;; 02d0: 77          w
	pop	d		;; 02d1: d1          .
	push	d		;; 02d2: d5          .
	mvi	c,01eh		;; 02d3: 0e 1e       ..
	call	L0c5e		;; 02d5: cd 5e 0c    .^.
	xra	a		;; 02d8: af          .
	sta	L1de1		;; 02d9: 32 e1 1d    2..
	jr	L02fc		;; 02dc: 18 1e       ..

L02de:	lda	L1de1		;; 02de: 3a e1 1d    :..
	ana	a		;; 02e1: a7          .
	jrnz	L02fc		;; 02e2: 20 18        .
	pop	d		;; 02e4: d1          .
	push	d		;; 02e5: d5          .
	mvi	c,010h		;; 02e6: 0e 10       ..
	call	L0c5e		;; 02e8: cd 5e 0c    .^.
	pop	h		;; 02eb: e1          .
	push	h		;; 02ec: e5          .
	lxi	d,00004h	;; 02ed: 11 04 00    ...
	dad	d		;; 02f0: 19          .
	mov	a,m		;; 02f1: 7e          ~
	ani	07fh		;; 02f2: e6 7f       ..
	mov	m,a		;; 02f4: 77          w
	pop	d		;; 02f5: d1          .
	push	d		;; 02f6: d5          .
	mvi	c,01eh		;; 02f7: 0e 1e       ..
	call	L0c5e		;; 02f9: cd 5e 0c    .^.
L02fc:	pop	d		;; 02fc: d1          .
	pop	b		;; 02fd: c1          .
	pop	h		;; 02fe: e1          .
	pop	psw		;; 02ff: f1          .
	xra	a		;; 0300: af          .
	ret			;; 0301: c9          .

L0302:	push	psw		;; 0302: f5          .
	lda	L1448		;; 0303: 3a 48 14    :H.
L0305	equ	$-1
	dcr	a		;; 0306: 3d          =
	sta	L1448		;; 0307: 32 48 14    2H.
	pop	psw		;; 030a: f1          .
	ret			;; 030b: c9          .

L030c:	sspd	L2024		;; 030c: ed 73 24 20 .s$ 
	lxi	sp,L2134	;; 0310: 31 34 21    14.
	call	L0302		;; 0313: cd 02 03    ...
	lda	L1b57		;; 0316: 3a 57 1b    :W.
	ana	a		;; 0319: a7          .
	jrz	L0324		;; 031a: 28 08       (.
	push	psw		;; 031c: f5          .
	xra	a		;; 031d: af          .
	sta	L1b57		;; 031e: 32 57 1b    2W.
	pop	psw		;; 0321: f1          .
	jr	L0327		;; 0322: 18 03       ..

L0324:	call	00000h		;; 0324: cd 00 00    ...
L0325	equ	$-2
L0326	equ	$-1
L0327:	lspd	L2024		;; 0327: ed 7b 24 20 .{$ 
	ret			;; 032b: c9          .

	push	psw		;; 032c: f5          .
	jmp	L0b02		;; 032d: c3 02 0b    ...

L0330:	mvi	c,00dh		;; 0330: 0e 0d       ..
	call	00005h		;; 0332: cd 05 00    ...
L0335:	lxi	d,L1ccc		;; 0335: 11 cc 1c    ...
	call	L1bfd		;; 0338: cd fd 1b    ...
	call	L18df		;; 033b: cd df 18    ...
L033e:	xra	a		;; 033e: af          .
	sta	00008h		;; 033f: 32 08 00    2..
	lda	L1d76		;; 0342: 3a 76 1d    :v.
	sta	L1d71		;; 0345: 32 71 1d    2q.
	lda	L1d53		;; 0348: 3a 53 1d    :S.
	cpi	0ffh		;; 034b: fe ff       ..
	jrz	L0355		;; 034d: 28 06       (.
	sta	L1d67		;; 034f: 32 67 1d    2g.
	call	L1bcc		;; 0352: cd cc 1b    ...
L0355:	lda	L1d56		;; 0355: 3a 56 1d    :V.
	cpi	030h		;; 0358: fe 30       .0
	jnz	L03a4		;; 035a: c2 a4 03    ...
	lxi	sp,L20dc	;; 035d: 31 dc 20    1. 
	lda	L1d79		;; 0360: 3a 79 1d    :y.
	call	L04ec		;; 0363: cd ec 04    ...
	mov	e,a		;; 0366: 5f          _
	mvi	c,00eh		;; 0367: 0e 0e       ..
	call	00005h		;; 0369: cd 05 00    ...
	lxi	h,L01cd		;; 036c: 21 cd 01    ...
	shld	00006h		;; 036f: 22 06 00    "..
	lxi	d,L033e		;; 0372: 11 3e 03    .>.
	lhld	L2032		;; 0375: 2a 32 20    *2 
	inx	h		;; 0378: 23          #
	mov	m,e		;; 0379: 73          s
	inx	h		;; 037a: 23          #
	mov	m,d		;; 037b: 72          r
	lhld	L2032		;; 037c: 2a 32 20    *2 
	shld	00001h		;; 037f: 22 01 00    "..
	lxi	sp,L20dc	;; 0382: 31 dc 20    1. 
	xra	a		;; 0385: af          .
	sta	00041h		;; 0386: 32 41 00    2A.
	sta	L0a3b		;; 0389: 32 3b 0a    2;.
	sta	L1de3		;; 038c: 32 e3 1d    2..
	lxi	d,L1dbd		;; 038f: 11 bd 1d    ...
	mvi	c,00fh		;; 0392: 0e 0f       ..
	call	00005h		;; 0394: cd 05 00    ...
	inr	a		;; 0397: 3c          <
	sta	L1e99		;; 0398: 32 99 1e    2..
	jr	L03a2		;; 039b: 18 05       ..

L039d:	call	L1cc0		;; 039d: cd c0 1c    ...
	jr	L033e		;; 03a0: 18 9c       ..

L03a2:	jr	L03be		;; 03a2: 18 1a       ..

L03a4:	mvi	a,030h		;; 03a4: 3e 30       >0
	sta	L1d56		;; 03a6: 32 56 1d    2V.
	lspd	L1d54		;; 03a9: ed 7b 54 1d .{T.
	pop	h		;; 03ad: e1          .
	pop	d		;; 03ae: d1          .
	pop	b		;; 03af: c1          .
	pop	psw		;; 03b0: f1          .
	ret			;; 03b1: c9          .

L03b2:	db	0dh,0ah,'[XSUB ON]$'
L03be:	lda	L1d5d		;; 03be: 3a 5d 1d    :].
	ana	a		;; 03c1: a7          .
	jrz	L03ca		;; 03c2: 28 06       (.
	lxi	d,L03b2		;; 03c4: 11 b2 03    ...
	call	L1bfd		;; 03c7: cd fd 1b    ...
L03ca:	lda	L1d78		;; 03ca: 3a 78 1d    :x.
	adi	041h		;; 03cd: c6 41       .A
	sta	L1d15		;; 03cf: 32 15 1d    2..
	lda	L1d67		;; 03d2: 3a 67 1d    :g.
	adi	030h		;; 03d5: c6 30       .0
	sta	L1d17		;; 03d7: 32 17 1d    2..
	lxi	d,L1d12		;; 03da: 11 12 1d    ...
	call	L1bfd		;; 03dd: cd fd 1b    ...
	lda	L1d17		;; 03e0: 3a 17 1d    :..
	cpi	03ah		;; 03e3: fe 3a       .:
	jrc	L03f1		;; 03e5: 38 0a       8.
	sui	00ah		;; 03e7: d6 0a       ..
	sta	L1d17		;; 03e9: 32 17 1d    2..
	mvi	e,031h		;; 03ec: 1e 31       .1
	call	L1b5f		;; 03ee: cd 5f 1b    ._.
L03f1:	lxi	d,L1d17		;; 03f1: 11 17 1d    ...
	call	L1bfd		;; 03f4: cd fd 1b    ...
	call	L03fd		;; 03f7: cd fd 03    ...
	jmp	L044e		;; 03fa: c3 4e 04    .N.

L03fd:	lxi	d,00080h	;; 03fd: 11 80 00    ...
	call	L1be7		;; 0400: cd e7 1b    ...
	lxi	h,0005ch	;; 0403: 21 5c 00    .\.
	mvi	a,020h		;; 0406: 3e 20       > 
	mvi	c,020h		;; 0408: 0e 20       . 
	call	L1cc6		;; 040a: cd c6 1c    ...
	lxi	h,00068h	;; 040d: 21 68 00    .h.
	mvi	c,004h		;; 0410: 0e 04       ..
	xra	a		;; 0412: af          .
	call	L1cc6		;; 0413: cd c6 1c    ...
	lxi	h,00078h	;; 0416: 21 78 00    .x.
	mvi	c,008h		;; 0419: 0e 08       ..
	call	L1cc6		;; 041b: cd c6 1c    ...
	sta	0005ch		;; 041e: 32 5c 00    2\.
	sta	0006ch		;; 0421: 32 6c 00    2l.
	sta	L1de3		;; 0424: 32 e3 1d    2..
	xra	a		;; 0427: af          .
	sta	L1fef		;; 0428: 32 ef 1f    2..
	lda	L1d56		;; 042b: 3a 56 1d    :V.
	cpi	031h		;; 042e: fe 31       .1
	jz	L04c5		;; 0430: ca c5 04    ...
	xra	a		;; 0433: af          .
	sta	00080h		;; 0434: 32 80 00    2..
	sta	00081h		;; 0437: 32 81 00    2..
	ret			;; 043a: c9          .

L043b:	xra	a		;; 043b: af          .
	sta	L1e99		;; 043c: 32 99 1e    2..
	dcr	a		;; 043f: 3d          =
	sta	L1dde		;; 0440: 32 de 1d    2..
	lxi	d,L1dbd		;; 0443: 11 bd 1d    ...
	mvi	c,013h		;; 0446: 0e 13       ..
	call	00005h		;; 0448: cd 05 00    ...
	jmp	L033e		;; 044b: c3 3e 03    .>.

L044e:	lxi	d,L1f6d		;; 044e: 11 6d 1f    .m.
	mvi	a,001h		;; 0451: 3e 01       >.
	sta	L1d77		;; 0453: 32 77 1d    2w.
	lda	L1e99		;; 0456: 3a 99 1e    :..
	ana	a		;; 0459: a7          .
	jz	L04be		;; 045a: ca be 04    ...
	mvi	c,00bh		;; 045d: 0e 0b       ..
	call	00005h		;; 045f: cd 05 00    ...
	ana	a		;; 0462: a7          .
	jrnz	L043b		;; 0463: 20 d6        .
	call	L046b		;; 0465: cd 6b 04    .k.
	jmp	L04c1		;; 0468: c3 c1 04    ...

L046b:	lda	L1dde		;; 046b: 3a de 1d    :..
	inr	a		;; 046e: 3c          <
	jrnz	L0480		;; 046f: 20 0f        .
	lxi	d,L1dbd		;; 0471: 11 bd 1d    ...
	mvi	c,023h		;; 0474: 0e 23       .#
	call	L04ba		;; 0476: cd ba 04    ...
	lda	L1dde		;; 0479: 3a de 1d    :..
	dcr	a		;; 047c: 3d          =
	sta	L1dde		;; 047d: 32 de 1d    2..
L0480:	lxi	d,L1f6e		;; 0480: 11 6e 1f    .n.
	mvi	c,01ah		;; 0483: 0e 1a       ..
	call	L04ba		;; 0485: cd ba 04    ...
	lxi	d,L1dbd		;; 0488: 11 bd 1d    ...
	mvi	c,021h		;; 048b: 0e 21       ..
	call	L04ba		;; 048d: cd ba 04    ...
	lda	L1dde		;; 0490: 3a de 1d    :..
	dcr	a		;; 0493: 3d          =
	sta	L1dde		;; 0494: 32 de 1d    2..
	inr	a		;; 0497: 3c          <
	jrnz	L04a5		;; 0498: 20 0b        .
	sta	L1e99		;; 049a: 32 99 1e    2..
	lxi	d,L1dbd		;; 049d: 11 bd 1d    ...
	mvi	c,013h		;; 04a0: 0e 13       ..
	call	L04ba		;; 04a2: cd ba 04    ...
L04a5:	lxi	h,L1f6f		;; 04a5: 21 6f 1f    .o.
	mvi	d,000h		;; 04a8: 16 00       ..
	lda	L1f6e		;; 04aa: 3a 6e 1f    :n.
	mov	e,a		;; 04ad: 5f          _
	dad	d		;; 04ae: 19          .
	xra	a		;; 04af: af          .
	mov	m,a		;; 04b0: 77          w
	mvi	a,024h		;; 04b1: 3e 24       >$
	inx	h		;; 04b3: 23          #
	mov	m,a		;; 04b4: 77          w
	lxi	d,L1f6f		;; 04b5: 11 6f 1f    .o.
	mvi	c,009h		;; 04b8: 0e 09       ..
L04ba:	push	psw		;; 04ba: f5          .
	jmp	L0b66		;; 04bb: c3 66 0b    .f.

L04be:	call	L1c24		;; 04be: cd 24 1c    .$.
L04c1:	xra	a		;; 04c1: af          .
	sta	L1d77		;; 04c2: 32 77 1d    2w.
L04c5:	call	L1cc0		;; 04c5: cd c0 1c    ...
	lxi	h,L1f6e		;; 04c8: 21 6e 1f    .n.
	mov	a,m		;; 04cb: 7e          ~
	ana	a		;; 04cc: a7          .
	jz	L03a2		;; 04cd: ca a2 03    ...
	push	psw		;; 04d0: f5          .
	cpi	002h		;; 04d1: fe 02       ..
	jrnz	L04fd		;; 04d3: 20 28        (
	inx	h		;; 04d5: 23          #
	inx	h		;; 04d6: 23          #
	mov	a,m		;; 04d7: 7e          ~
	cpi	03ah		;; 04d8: fe 3a       .:
	jrnz	L04fd		;; 04da: 20 21        .
	dcx	h		;; 04dc: 2b          +
	mov	a,m		;; 04dd: 7e          ~
	sui	041h		;; 04de: d6 41       .A
	sta	L1d79		;; 04e0: 32 79 1d    2y.
	call	L04ec		;; 04e3: cd ec 04    ...
	jmp	L033e		;; 04e6: c3 3e 03    .>.

L04e9:	lda	L1d79		;; 04e9: 3a 79 1d    :y.
L04ec:	push	psw		;; 04ec: f5          .
	mov	b,a		;; 04ed: 47          G
	lda	L1d67		;; 04ee: 3a 67 1d    :g.
	ral			;; 04f1: 17          .
	ral			;; 04f2: 17          .
	ral			;; 04f3: 17          .
	ral			;; 04f4: 17          .
	ani	0f0h		;; 04f5: e6 f0       ..
	ora	b		;; 04f7: b0          .
	sta	00004h		;; 04f8: 32 04 00    2..
	pop	psw		;; 04fb: f1          .
	ret			;; 04fc: c9          .

L04fd:	pop	psw		;; 04fd: f1          .
	mov	e,a		;; 04fe: 5f          _
	mvi	d,000h		;; 04ff: 16 00       ..
	lxi	h,L1f6f		;; 0501: 21 6f 1f    .o.
	dad	d		;; 0504: 19          .
	mvi	m,00dh		;; 0505: 36 0d       6.
	lxi	h,L1f6f		;; 0507: 21 6f 1f    .o.
L050a:	mov	a,m		;; 050a: 7e          ~
	cpi	020h		;; 050b: fe 20       . 
	jrc	L0519		;; 050d: 38 0a       8.
	cpi	061h		;; 050f: fe 61       .a
	jrc	L0515		;; 0511: 38 02       8.
	ani	0dfh		;; 0513: e6 df       ..
L0515:	mov	m,a		;; 0515: 77          w
	inx	h		;; 0516: 23          #
	jr	L050a		;; 0517: 18 f1       ..

L0519:	lxi	h,L1ff0		;; 0519: 21 f0 1f    ...
	mvi	a,020h		;; 051c: 3e 20       > 
	mvi	c,008h		;; 051e: 0e 08       ..
	call	L1cc6		;; 0520: cd c6 1c    ...
	lxi	h,L1ffb		;; 0523: 21 fb 1f    ...
	xra	a		;; 0526: af          .
	mvi	c,017h		;; 0527: 0e 17       ..
	call	L1cc6		;; 0529: cd c6 1c    ...
	lxi	h,L1f6f		;; 052c: 21 6f 1f    .o.
	lxi	b,L1ff0		;; 052f: 01 f0 1f    ...
L0532:	mov	a,m		;; 0532: 7e          ~
	cpi	020h		;; 0533: fe 20       . 
	jrnz	L053a		;; 0535: 20 03        .
	inx	h		;; 0537: 23          #
	jr	L0532		;; 0538: 18 f8       ..

L053a:	cpi	041h		;; 053a: fe 41       .A
	jc	L1a6e		;; 053c: da 6e 1a    .n.
	mvi	e,009h		;; 053f: 1e 09       ..
L0541:	mov	a,m		;; 0541: 7e          ~
	cpi	030h		;; 0542: fe 30       .0
	jrc	L0552		;; 0544: 38 0c       8.
	dcr	e		;; 0546: 1d          .
	jrz	L054e		;; 0547: 28 05       (.
	stax	b		;; 0549: 02          .
	inx	h		;; 054a: 23          #
	inx	b		;; 054b: 03          .
	jr	L0541		;; 054c: 18 f3       ..

L054e:	inr	e		;; 054e: 1c          .
	inx	h		;; 054f: 23          #
	jr	L0541		;; 0550: 18 ef       ..

L0552:	mvi	e,000h		;; 0552: 1e 00       ..
	lxi	b,00081h	;; 0554: 01 81 00    ...
L0557:	mov	a,m		;; 0557: 7e          ~
	cpi	00dh		;; 0558: fe 0d       ..
	jrz	L0562		;; 055a: 28 06       (.
	stax	b		;; 055c: 02          .
	inx	h		;; 055d: 23          #
	inr	e		;; 055e: 1c          .
	inx	b		;; 055f: 03          .
	jr	L0557		;; 0560: 18 f5       ..

L0562:	xra	a		;; 0562: af          .
	stax	b		;; 0563: 02          .
	lxi	h,00080h	;; 0564: 21 80 00    ...
	mov	m,e		;; 0567: 73          s
	lxi	h,00081h	;; 0568: 21 81 00    ...
	call	L05a2		;; 056b: cd a2 05    ...
	push	h		;; 056e: e5          .
	lxi	h,L1de3		;; 056f: 21 e3 1d    ...
	lxi	d,0005ch	;; 0572: 11 5c 00    .\.
	lxi	b,00010h	;; 0575: 01 10 00    ...
	ldir			;; 0578: ed b0       ..
	pop	h		;; 057a: e1          .
	mov	a,m		;; 057b: 7e          ~
	ana	a		;; 057c: a7          .
	jz	L063d		;; 057d: ca 3d 06    .=.
	inx	h		;; 0580: 23          #
	push	h		;; 0581: e5          .
	lxi	h,L1de3		;; 0582: 21 e3 1d    ...
	mvi	a,020h		;; 0585: 3e 20       > 
	mvi	c,010h		;; 0587: 0e 10       ..
	call	L1cc6		;; 0589: cd c6 1c    ...
	xra	a		;; 058c: af          .
	sta	L1de3		;; 058d: 32 e3 1d    2..
	pop	h		;; 0590: e1          .
	call	L05a2		;; 0591: cd a2 05    ...
	lxi	h,L1de3		;; 0594: 21 e3 1d    ...
	lxi	d,0006ch	;; 0597: 11 6c 00    .l.
	lxi	b,00010h	;; 059a: 01 10 00    ...
	ldir			;; 059d: ed b0       ..
	jmp	L063d		;; 059f: c3 3d 06    .=.

L05a2:	push	h		;; 05a2: e5          .
	lxi	h,L1de3		;; 05a3: 21 e3 1d    ...
	mvi	a,020h		;; 05a6: 3e 20       > 
	mvi	c,00ch		;; 05a8: 0e 0c       ..
	call	L1cc6		;; 05aa: cd c6 1c    ...
	lxi	h,L1def		;; 05ad: 21 ef 1d    ...
	xra	a		;; 05b0: af          .
	mvi	c,004h		;; 05b1: 0e 04       ..
	call	L1cc6		;; 05b3: cd c6 1c    ...
	sta	L1de3		;; 05b6: 32 e3 1d    2..
	pop	h		;; 05b9: e1          .
	mov	a,m		;; 05ba: 7e          ~
	cpi	020h		;; 05bb: fe 20       . 
	jnz	L05c3		;; 05bd: c2 c3 05    ...
	inx	h		;; 05c0: 23          #
	jr	L05a2		;; 05c1: 18 df       ..

L05c3:	ana	a		;; 05c3: a7          .
	rz			;; 05c4: c8          .
	inx	h		;; 05c5: 23          #
	mov	a,m		;; 05c6: 7e          ~
	cpi	03ah		;; 05c7: fe 3a       .:
	jrnz	L05d5		;; 05c9: 20 0a        .
	dcx	h		;; 05cb: 2b          +
	mov	a,m		;; 05cc: 7e          ~
	sui	040h		;; 05cd: d6 40       .@
	sta	L1de3		;; 05cf: 32 e3 1d    2..
	inx	h		;; 05d2: 23          #
	inx	h		;; 05d3: 23          #
	inx	h		;; 05d4: 23          #
L05d5:	lxi	b,L1de4		;; 05d5: 01 e4 1d    ...
	dcx	h		;; 05d8: 2b          +
	mvi	e,009h		;; 05d9: 1e 09       ..
L05db:	mov	a,m		;; 05db: 7e          ~
	cpi	02ah		;; 05dc: fe 2a       .*
	jrz	L0600		;; 05de: 28 20       ( 
	cpi	024h		;; 05e0: fe 24       .$
	jrz	L05f4		;; 05e2: 28 10       (.
	cpi	030h		;; 05e4: fe 30       .0
	jrc	L0609		;; 05e6: 38 21       8.
	cpi	05bh		;; 05e8: fe 5b       .[
	jrz	L0609		;; 05ea: 28 1d       (.
	cpi	03bh		;; 05ec: fe 3b       .;
	jrc	L05f4		;; 05ee: 38 04       8.
	cpi	03fh		;; 05f0: fe 3f       .?
	jrc	L0609		;; 05f2: 38 15       8.
L05f4:	dcr	e		;; 05f4: 1d          .
	jrz	L05fc		;; 05f5: 28 05       (.
	stax	b		;; 05f7: 02          .
	inx	h		;; 05f8: 23          #
	inx	b		;; 05f9: 03          .
	jr	L05db		;; 05fa: 18 df       ..

L05fc:	inr	e		;; 05fc: 1c          .
	inx	h		;; 05fd: 23          #
	jr	L05db		;; 05fe: 18 db       ..

L0600:	mvi	a,03fh		;; 0600: 3e 3f       >?
L0602:	dcr	e		;; 0602: 1d          .
	jrz	L05fc		;; 0603: 28 f7       (.
	stax	b		;; 0605: 02          .
	inx	b		;; 0606: 03          .
	jr	L0602		;; 0607: 18 f9       ..

L0609:	cpi	02eh		;; 0609: fe 2e       ..
	rnz			;; 060b: c0          .
	lxi	b,L1dec		;; 060c: 01 ec 1d    ...
	inx	h		;; 060f: 23          #
	mvi	e,004h		;; 0610: 1e 04       ..
L0612:	mov	a,m		;; 0612: 7e          ~
	cpi	02ah		;; 0613: fe 2a       .*
	jrz	L0634		;; 0615: 28 1d       (.
	cpi	024h		;; 0617: fe 24       .$
L0619:	jrz	L0628		;; 0619: 28 0d       (.
	cpi	030h		;; 061b: fe 30       .0
	rc			;; 061d: d8          .
	cpi	05bh		;; 061e: fe 5b       .[
	rz			;; 0620: c8          .
	cpi	03ah		;; 0621: fe 3a       .:
	jrc	L0628		;; 0623: 38 03       8.
	cpi	03fh		;; 0625: fe 3f       .?
	rc			;; 0627: d8          .
L0628:	dcr	e		;; 0628: 1d          .
	jrz	L0630		;; 0629: 28 05       (.
	stax	b		;; 062b: 02          .
	inx	h		;; 062c: 23          #
	inx	b		;; 062d: 03          .
	jr	L0612		;; 062e: 18 e2       ..

L0630:	inr	e		;; 0630: 1c          .
	inx	h		;; 0631: 23          #
	jr	L0612		;; 0632: 18 de       ..

L0634:	mvi	a,03fh		;; 0634: 3e 3f       >?
L0636:	dcr	e		;; 0636: 1d          .
	jrz	L0630		;; 0637: 28 f7       (.
	stax	b		;; 0639: 02          .
	inx	b		;; 063a: 03          .
	jr	L0636		;; 063b: 18 f9       ..

L063d:	lxi	h,L1ff0		;; 063d: 21 f0 1f    ...
	mov	a,m		;; 0640: 7e          ~
	cpi	04ch		;; 0641: fe 4c       .L
	jz	L0920		;; 0643: ca 20 09    . .
	push	psw		;; 0646: f5          .
	lda	L1d71		;; 0647: 3a 71 1d    :q.
	ani	001h		;; 064a: e6 01       ..
	jz	L06a8		;; 064c: ca a8 06    ...
	pop	psw		;; 064f: f1          .
	cpi	041h		;; 0650: fe 41       .A
	jz	L06bc		;; 0652: ca bc 06    ...
	cpi	043h		;; 0655: fe 43       .C
	jz	L07e5		;; 0657: ca e5 07    ...
	cpi	044h		;; 065a: fe 44       .D
	jz	L0835		;; 065c: ca 35 08    .5.
	cpi	045h		;; 065f: fe 45       .E
	jz	L0861		;; 0661: ca 61 08    .a.
	cpi	046h		;; 0664: fe 46       .F
	jz	L0881		;; 0666: ca 81 08    ...
	cpi	047h		;; 0669: fe 47       .G
	jz	L08d9		;; 066b: ca d9 08    ...
	cpi	048h		;; 066e: fe 48       .H
	jz	L08f3		;; 0670: ca f3 08    ...
	cpi	049h		;; 0673: fe 49       .I
	jz	L0914		;; 0675: ca 14 09    ...
	cpi	04fh		;; 0678: fe 4f       .O
	jz	L099d		;; 067a: ca 9d 09    ...
	cpi	050h		;; 067d: fe 50       .P
	jz	L09bd		;; 067f: ca bd 09    ...
	cpi	051h		;; 0682: fe 51       .Q
	jz	L09f3		;; 0684: ca f3 09    ...
	cpi	052h		;; 0687: fe 52       .R
	jz	L0a3c		;; 0689: ca 3c 0a    .<.
	cpi	053h		;; 068c: fe 53       .S
	jz	L1576		;; 068e: ca 76 15    .v.
	cpi	054h		;; 0691: fe 54       .T
	jz	L1672		;; 0693: ca 72 16    .r.
	cpi	055h		;; 0696: fe 55       .U
	jz	L16d0		;; 0698: ca d0 16    ...
	cpi	057h		;; 069b: fe 57       .W
	jz	L1711		;; 069d: ca 11 17    ...
	cpi	058h		;; 06a0: fe 58       .X
	jz	L173d		;; 06a2: ca 3d 17    .=.
	jmp	L1777		;; 06a5: c3 77 17    .w.

L06a8:	lxi	d,L06ae		;; 06a8: 11 ae 06    ...
	jmp	L0714		;; 06ab: c3 14 07    ...

L06ae:	db	'?Login please$'
L06bc:	inx	h		;; 06bc: 23          #
	mov	a,m		;; 06bd: 7e          ~
	cpi	053h		;; 06be: fe 53       .S
	jnz	L1777		;; 06c0: c2 77 17    .w.
	inx	h		;; 06c3: 23          #
	mov	a,m		;; 06c4: 7e          ~
	cpi	053h		;; 06c5: fe 53       .S
	jrz	L06cc		;; 06c7: 28 03       (.
	jmp	L1777		;; 06c9: c3 77 17    .w.

L06cc:	lxi	h,L1f72		;; 06cc: 21 72 1f    .r.
	lxi	d,L07e1		;; 06cf: 11 e1 07    ...
	call	L1759		;; 06d2: cd 59 17    .Y.
	lda	0005ch		;; 06d5: 3a 5c 00    :\.
	ana	a		;; 06d8: a7          .
	jrz	L071a		;; 06d9: 28 3f       (?
	ani	0f0h		;; 06db: e6 f0       ..
	jrnz	L071a		;; 06dd: 20 3b        ;
	lda	0005ch		;; 06df: 3a 5c 00    :\.
	call	L0db4		;; 06e2: cd b4 0d    ...
	lda	0006ch		;; 06e5: 3a 6c 00    :l.
	mov	m,a		;; 06e8: 77          w
	inx	h		;; 06e9: 23          #
	lda	0006dh		;; 06ea: 3a 6d 00    :m.
	push	h		;; 06ed: e5          .
	lxi	h,L1cee		;; 06ee: 21 ee 1c    ...
	cmp	m		;; 06f1: be          .
	pop	h		;; 06f2: e1          .
	jrz	L06f9		;; 06f3: 28 04       (.
	cpi	020h		;; 06f5: fe 20       . 
	jrnz	L06fd		;; 06f7: 20 04        .
L06f9:	mvi	a,030h		;; 06f9: 3e 30       >0
	jr	L0706		;; 06fb: 18 09       ..

L06fd:	push	psw		;; 06fd: f5          .
	lda	0006ch		;; 06fe: 3a 6c 00    :l.
	ana	a		;; 0701: a7          .
	jz	L1ab5		;; 0702: ca b5 1a    ...
	pop	psw		;; 0705: f1          .
L0706:	sui	030h		;; 0706: d6 30       .0
	mov	m,a		;; 0708: 77          w
	lda	0005ch		;; 0709: 3a 5c 00    :\.
	adi	040h		;; 070c: c6 40       .@
	sta	L07d5		;; 070e: 32 d5 07    2..
	lxi	d,L07ce		;; 0711: 11 ce 07    ...
L0714:	call	L1bfd		;; 0714: cd fd 1b    ...
	jmp	L039d		;; 0717: c3 9d 03    ...

L071a:	lda	0005dh		;; 071a: 3a 5d 00    :].
	cpi	020h		;; 071d: fe 20       . 
	jz	L07b7		;; 071f: ca b7 07    ...
	cpi	04ch		;; 0722: fe 4c       .L
	jnz	L07b7		;; 0724: c2 b7 07    ...
	lda	00060h		;; 0727: 3a 60 00    :`.
	cpi	03ah		;; 072a: fe 3a       .:
	jnz	L07b7		;; 072c: c2 b7 07    ...
	lxi	h,0006ch	;; 072f: 21 6c 00    .l.
	mov	a,m		;; 0732: 7e          ~
	ana	a		;; 0733: a7          .
	jrnz	L073b		;; 0734: 20 05        .
	lda	L1d78		;; 0736: 3a 78 1d    :x.
	inr	a		;; 0739: 3c          <
	mov	m,a		;; 073a: 77          w
L073b:	lxi	d,L0792		;; 073b: 11 92 07    ...
	lxi	b,00010h	;; 073e: 01 10 00    ...
	ldir			;; 0741: ed b0       ..
	lxi	h,L07a2		;; 0743: 21 a2 07    ...
	mvi	c,012h		;; 0746: 0e 12       ..
	xra	a		;; 0748: af          .
	call	L1cc6		;; 0749: cd c6 1c    ...
	sta	L07b6		;; 074c: 32 b6 07    2..
	lxi	d,L0792		;; 074f: 11 92 07    ...
	mvi	c,011h		;; 0752: 0e 11       ..
	call	00005h		;; 0754: cd 05 00    ...
	inr	a		;; 0757: 3c          <
	jrnz	L077f		;; 0758: 20 25        %
	lxi	d,L0792		;; 075a: 11 92 07    ...
	mvi	c,016h		;; 075d: 0e 16       ..
	call	00005h		;; 075f: cd 05 00    ...
	inr	a		;; 0762: 3c          <
	jrz	L077a		;; 0763: 28 15       (.
	lxi	d,L0774		;; 0765: 11 74 07    .t.
	call	L1bfd		;; 0768: cd fd 1b    ...
	lxi	h,L0792		;; 076b: 21 92 07    ...
	call	L1afe		;; 076e: cd fe 1a    ...
	jmp	L039d		;; 0771: c3 9d 03    ...

L0774:	db	'LST:=$'
L077a:	lxi	d,L0994		;; 077a: 11 94 09    ...
	jr	L0780		;; 077d: 18 01       ..

L077f:	lxi	d,L1d3d		;; 077f: 11 3d 1d    .=.
L0780	equ	$-2
	call	L1bfd		;; 0782: cd fd 1b    ...
	lxi	h,L0792		;; 0785: 21 92 07    ...
	call	L1afe		;; 0788: cd fe 1a    ...
	xra	a		;; 078b: af          .
	sta	L0793		;; 078c: 32 93 07    2..
	jmp	L039d		;; 078f: c3 9d 03    ...

L0792:	db	0
L0793:	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
L07a2:	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
L07b6:	db	0
L07b7:	lxi	d,L07bd		;; 07b7: 11 bd 07    ...
	jmp	L0714		;; 07ba: c3 14 07    ...

L07bd:	db	'?Bad logical dev$'
L07ce:	db	'Device '
L07d5:	db	'X: assigned$'
L07e1:	db	'IGN '
L07e5:	inx	h		;; 07e5: 23          #
	mov	a,m		;; 07e6: 7e          ~
	cpi	04fh		;; 07e7: fe 4f       .O
	jrz	L07ee		;; 07e9: 28 03       (.
	jmp	L1777		;; 07eb: c3 77 17    .w.

L07ee:	inx	h		;; 07ee: 23          #
	mov	a,m		;; 07ef: 7e          ~
	cpi	052h		;; 07f0: fe 52       .R
	jrz	L07fb		;; 07f2: 28 07       (.
	cpi	050h		;; 07f4: fe 50       .P
	jrz	L0816		;; 07f6: 28 1e       (.
	jmp	L1777		;; 07f8: c3 77 17    .w.

L07fb:	lxi	h,L1f72		;; 07fb: 21 72 1f    .r.
	lxi	d,L0807		;; 07fe: 11 07 08    ...
	call	L1759		;; 0801: cd 59 17    .Y.
	jmp	L0850		;; 0804: c3 50 08    .P.

L0807:	db	'E '
L0809:	lxi	d,L1ff0		;; 0809: 11 f0 1f    ...
	lxi	b,00008h	;; 080c: 01 08 00    ...
	ldir			;; 080f: ed b0       ..
	jmp	L1777		;; 0811: c3 77 17    .w.

L0814:	db	'Y '
L0816:	lxi	h,L1f72		;; 0816: 21 72 1f    .r.
	lxi	d,L0814		;; 0819: 11 14 08    ...
	call	L1759		;; 081c: cd 59 17    .Y.
	lda	0006dh		;; 081f: 3a 6d 00    :m.
	cpi	020h		;; 0822: fe 20       . 
	jz	L1ab5		;; 0824: ca b5 1a    ...
	lxi	h,L082d		;; 0827: 21 2d 08    .-.
	jmp	L0809		;; 082a: c3 09 08    ...

L082d:	db	'PIP     '
L0835:	inx	h		;; 0835: 23          #
	mov	a,m		;; 0836: 7e          ~
	cpi	049h		;; 0837: fe 49       .I
	jz	L0847		;; 0839: ca 47 08    .G.
	jmp	L1777		;; 083c: c3 77 17    .w.

L083f:	db	'RECTORY '
L0847:	lxi	h,L1f71		;; 0847: 21 71 1f    .q.
	lxi	d,L083f		;; 084a: 11 3f 08    .?.
	call	L1759		;; 084d: cd 59 17    .Y.
L0850:	lxi	h,L0856		;; 0850: 21 56 08    .V.
	jmp	L0809		;; 0853: c3 09 08    ...

L0856:	db	'UTIL    IT '
L0861:	inx	h		;; 0861: 23          #
	mov	a,m		;; 0862: 7e          ~
	cpi	052h		;; 0863: fe 52       .R
	jz	L086b		;; 0865: ca 6b 08    .k.
	jmp	L1777		;; 0868: c3 77 17    .w.

L086b:	lxi	h,L1f71		;; 086b: 21 71 1f    .q.
	lxi	d,L0877		;; 086e: 11 77 08    .w.
	call	L1759		;; 0871: cd 59 17    .Y.
	jmp	L0850		;; 0874: c3 50 08    .P.

L0877:	db	'ASE '
L087b:	db	'INISH '
L0881:	lxi	h,L1f70		;; 0881: 21 70 1f    .p.
	lxi	d,L087b		;; 0884: 11 7b 08    .{.
	call	L1759		;; 0887: cd 59 17    .Y.
	lda	L0793		;; 088a: 3a 93 07    :..
	ana	a		;; 088d: a7          .
	jz	L033e		;; 088e: ca 3e 03    .>.
	lxi	b,L0305		;; 0891: 01 05 03    ...
L0894:	push	b		;; 0894: c5          .
	mvi	e,01ah		;; 0895: 1e 1a       ..
	call	00005h		;; 0897: cd 05 00    ...
	pop	b		;; 089a: c1          .
	djnz	L0894		;; 089b: 10 f7       ..
	mvi	a,07fh		;; 089d: 3e 7f       >.
	sta	L07b6		;; 089f: 32 b6 07    2..
	mvi	e,01ah		;; 08a2: 1e 1a       ..
	mvi	c,005h		;; 08a4: 0e 05       ..
	call	00005h		;; 08a6: cd 05 00    ...
	lxi	d,L0792		;; 08a9: 11 92 07    ...
	mvi	c,010h		;; 08ac: 0e 10       ..
	call	00005h		;; 08ae: cd 05 00    ...
	lxi	d,L08c4		;; 08b1: 11 c4 08    ...
	call	L1bfd		;; 08b4: cd fd 1b    ...
	lxi	h,L0792		;; 08b7: 21 92 07    ...
	call	L1afe		;; 08ba: cd fe 1a    ...
	xra	a		;; 08bd: af          .
	sta	L0793		;; 08be: 32 93 07    2..
	jmp	L039d		;; 08c1: c3 9d 03    ...

L08c4:	db	'LST: file closed as $'
L08d9:	lxi	h,L1f70		;; 08d9: 21 70 1f    .p.
	lxi	d,L08f0		;; 08dc: 11 f0 08    ...
	call	L1759		;; 08df: cd 59 17    .Y.
	lxi	h,0005ch	;; 08e2: 21 5c 00    .\.
	lxi	d,L1fef		;; 08e5: 11 ef 1f    ...
	lxi	b,00009h	;; 08e8: 01 09 00    ...
	ldir			;; 08eb: ed b0       ..
	jmp	L1781		;; 08ed: c3 81 17    ...

L08f0:	db	'ET '
L08f3:	lxi	h,L1f70		;; 08f3: 21 70 1f    .p.
	lxi	d,L0904		;; 08f6: 11 04 09    ...
	call	L1759		;; 08f9: cd 59 17    .Y.
	lxi	h,L0902		;; 08fc: 21 02 09    ...
	jmp	L0809		;; 08ff: c3 09 08    ...

L0902:	db	'OH'
L0904:	db	'ELP   '
L090a:	db	'NITIALIZE '
L0914:	lxi	h,L1f70		;; 0914: 21 70 1f    .p.
	lxi	d,L090a		;; 0917: 11 0a 09    ...
	call	L1759		;; 091a: cd 59 17    .Y.
	jmp	L0330		;; 091d: c3 30 03    .0.

L0920:	inx	h		;; 0920: 23          #
	mov	a,m		;; 0921: 7e          ~
	cpi	04fh		;; 0922: fe 4f       .O
	jrz	L0931		;; 0924: 28 0b       (.
	lda	L1d71		;; 0926: 3a 71 1d    :q.
	ani	001h		;; 0929: e6 01       ..
	jz	L06a8		;; 092b: ca a8 06    ...
	jmp	L1777		;; 092e: c3 77 17    .w.

L0931:	inx	h		;; 0931: 23          #
	mov	a,m		;; 0932: 7e          ~
	cpi	047h		;; 0933: fe 47       .G
	jrz	L0948		;; 0935: 28 11       (.
	lda	L1d71		;; 0937: 3a 71 1d    :q.
	ani	001h		;; 093a: e6 01       ..
	jz	L06a8		;; 093c: ca a8 06    ...
	mov	a,m		;; 093f: 7e          ~
	cpi	043h		;; 0940: fe 43       .C
	jz	L172d		;; 0942: ca 2d 17    .-.
	jmp	L1777		;; 0945: c3 77 17    .w.

L0948:	lxi	h,L094e		;; 0948: 21 4e 09    .N.
	jmp	L0809		;; 094b: c3 09 08    ...

L094e:	db	'LOG     '
L0956:	lxi	d,L095c		;; 0956: 11 5c 09    .\.
	jmp	L0714		;; 0959: c3 14 07    ...

L095c:	db	'?Bad user #$'
L0968:	xra	a		;; 0968: af          .
	sta	L1d65		;; 0969: 32 65 1d    2e.
	sta	L1d5d		;; 096c: 32 5d 1d    2].
	sta	L1d64		;; 096f: 32 64 1d    2d.
	sta	L1d71		;; 0972: 32 71 1d    2q.
	sta	L1d76		;; 0975: 32 76 1d    2v.
	lxi	h,L1e9a		;; 0978: 21 9a 1e    ...
	mvi	c,020h		;; 097b: 0e 20       . 
L097d:	mov	m,a		;; 097d: 77          w
	inx	h		;; 097e: 23          #
	dcr	c		;; 097f: 0d          .
	jnz	L097d		;; 0980: c2 7d 09    .}.
	mvi	a,001h		;; 0983: 3e 01       >.
	sta	L1e9c		;; 0985: 32 9c 1e    2..
	inr	a		;; 0988: 3c          <
	sta	L1e9e		;; 0989: 32 9e 1e    2..
	pop	psw		;; 098c: f1          .
	ret			;; 098d: c9          .

L098e:	lxi	d,L0994		;; 098e: 11 94 09    ...
	jmp	L0714		;; 0991: c3 14 07    ...

L0994:	db	'?No room$'
L099d:	inx	h		;; 099d: 23          #
	mov	a,m		;; 099e: 7e          ~
	cpi	056h		;; 099f: fe 56       .V
	jnz	L1777		;; 09a1: c2 77 17    .w.
	inx	h		;; 09a4: 23          #
	mov	a,m		;; 09a5: 7e          ~
	cpi	04fh		;; 09a6: fe 4f       .O
	jnz	L1777		;; 09a8: c2 77 17    .w.
	inx	h		;; 09ab: 23          #
	mov	a,m		;; 09ac: 7e          ~
	cpi	04eh		;; 09ad: fe 4e       .N
	jz	L09b7		;; 09af: ca b7 09    ...
	cpi	046h		;; 09b2: fe 46       .F
	jnz	L1777		;; 09b4: c2 77 17    .w.
L09b7:	sta	L1d66		;; 09b7: 32 66 1d    2f.
	jmp	L039d		;; 09ba: c3 9d 03    ...

L09bd:	inx	h		;; 09bd: 23          #
	mov	a,m		;; 09be: 7e          ~
	cpi	052h		;; 09bf: fe 52       .R
	jz	L09cd		;; 09c1: ca cd 09    ...
	jmp	L1777		;; 09c4: c3 77 17    .w.

L09c7:	call	L18df		;; 09c7: cd df 18    ...
	jmp	L03a2		;; 09ca: c3 a2 03    ...

L09cd:	inx	h		;; 09cd: 23          #
	mov	a,m		;; 09ce: 7e          ~
	cpi	04fh		;; 09cf: fe 4f       .O
	jnz	L1777		;; 09d1: c2 77 17    .w.
	lxi	h,L1f72		;; 09d4: 21 72 1f    .r.
	lxi	d,L09e0		;; 09d7: 11 e0 09    ...
	call	L1759		;; 09da: cd 59 17    .Y.
	jmp	L0850		;; 09dd: c3 50 08    .P.

L09e0:	db	'TECT '
L09e5:	lxi	h,L09eb		;; 09e5: 21 eb 09    ...
	jmp	L0809		;; 09e8: c3 09 08    ...

L09eb:	db	'QUEUE   '
L09f3:	inx	h		;; 09f3: 23          #
	mov	a,m		;; 09f4: 7e          ~
	cpi	055h		;; 09f5: fe 55       .U
	jz	L0a2b		;; 09f7: ca 2b 0a    .+.
	cpi	04fh		;; 09fa: fe 4f       .O
	jnz	L1777		;; 09fc: c2 77 17    .w.
	inx	h		;; 09ff: 23          #
	mov	a,m		;; 0a00: 7e          ~
	cpi	04eh		;; 0a01: fe 4e       .N
	jz	L0a24		;; 0a03: ca 24 0a    .$.
	cpi	046h		;; 0a06: fe 46       .F
	jnz	L1777		;; 0a08: c2 77 17    .w.
	lda	L203c		;; 0a0b: 3a 3c 20    :< 
	cpi	020h		;; 0a0e: fe 20       . 
	jnz	L0a1b		;; 0a10: c2 1b 0a    ...
	mvi	a,001h		;; 0a13: 3e 01       >.
	sta	L1d5e		;; 0a15: 32 5e 1d    2^.
	jmp	L033e		;; 0a18: c3 3e 03    .>.

L0a1b:	lxi	d,L11b6		;; 0a1b: 11 b6 11    ...
	call	L1bfd		;; 0a1e: cd fd 1b    ...
	jmp	L033e		;; 0a21: c3 3e 03    .>.

L0a24:	xra	a		;; 0a24: af          .
	sta	L1d5e		;; 0a25: 32 5e 1d    2^.
	jmp	L033e		;; 0a28: c3 3e 03    .>.

L0a2b:	lxi	h,L1f71		;; 0a2b: 21 71 1f    .q.
	lxi	d,L0a37		;; 0a2e: 11 37 0a    .7.
	call	L1759		;; 0a31: cd 59 17    .Y.
	jmp	L09e5		;; 0a34: c3 e5 09    ...

L0a37:	db	'EUE '
L0a3b:	db	0
L0a3c:	inx	h		;; 0a3c: 23          #
	mov	a,m		;; 0a3d: 7e          ~
	cpi	020h		;; 0a3e: fe 20       . 
	jz	L0a50		;; 0a40: ca 50 0a    .P.
	cpi	045h		;; 0a43: fe 45       .E
	jz	L0ad4		;; 0a45: ca d4 0a    ...
	cpi	055h		;; 0a48: fe 55       .U
	jz	L0aac		;; 0a4a: ca ac 0a    ...
	jmp	L1777		;; 0a4d: c3 77 17    .w.

L0a50:	lda	0005dh		;; 0a50: 3a 5d 00    :].
	cpi	020h		;; 0a53: fe 20       . 
	jz	L1ab5		;; 0a55: ca b5 1a    ...
	lda	0005ch		;; 0a58: 3a 5c 00    :\.
	sta	L2028		;; 0a5b: 32 28 20    2( 
	call	L03fd		;; 0a5e: cd fd 03    ...
	xra	a		;; 0a61: af          .
	sta	L187a		;; 0a62: 32 7a 18    2z.
	lda	L2028		;; 0a65: 3a 28 20    :( 
	sta	L1fef		;; 0a68: 32 ef 1f    2..
	inr	a		;; 0a6b: 3c          <
	sta	L0a3b		;; 0a6c: 32 3b 0a    2;.
L0a6f:	lda	L1f6e		;; 0a6f: 3a 6e 1f    :n.
	mov	c,a		;; 0a72: 4f          O
	lxi	h,L1f6f		;; 0a73: 21 6f 1f    .o.
L0a76:	inx	h		;; 0a76: 23          #
	dcr	c		;; 0a77: 0d          .
	mov	a,m		;; 0a78: 7e          ~
	cpi	020h		;; 0a79: fe 20       . 
	jnz	L0a76		;; 0a7b: c2 76 0a    .v.
	push	b		;; 0a7e: c5          .
	inx	h		;; 0a7f: 23          #
	lxi	d,L1f6f		;; 0a80: 11 6f 1f    .o.
	mvi	b,000h		;; 0a83: 06 00       ..
	ldir			;; 0a85: ed b0       ..
	pop	b		;; 0a87: c1          .
	mov	a,c		;; 0a88: 79          y
	sta	L1f6e		;; 0a89: 32 6e 1f    2n.
	lda	L1f70		;; 0a8c: 3a 70 1f    :p.
	cpi	03ah		;; 0a8f: fe 3a       .:
	jnz	L04c5		;; 0a91: c2 c5 04    ...
	lda	L1f6e		;; 0a94: 3a 6e 1f    :n.
	dcr	a		;; 0a97: 3d          =
	dcr	a		;; 0a98: 3d          =
	sta	L1f6e		;; 0a99: 32 6e 1f    2n.
	mov	c,a		;; 0a9c: 4f          O
	mvi	b,000h		;; 0a9d: 06 00       ..
	lxi	h,L1f71		;; 0a9f: 21 71 1f    .q.
	lxi	d,L1f6f		;; 0aa2: 11 6f 1f    .o.
	ldir			;; 0aa5: ed b0       ..
	jmp	L04c5		;; 0aa7: c3 c5 04    ...

L0aaa:	db	'N '
L0aac:	lxi	h,L1f71		;; 0aac: 21 71 1f    .q.
	lxi	d,L0aaa		;; 0aaf: 11 aa 0a    ...
	call	L1759		;; 0ab2: cd 59 17    .Y.
	lda	0005dh		;; 0ab5: 3a 5d 00    :].
	cpi	020h		;; 0ab8: fe 20       . 
	jz	L1ab5		;; 0aba: ca b5 1a    ...
	lda	0005ch		;; 0abd: 3a 5c 00    :\.
	sta	L2028		;; 0ac0: 32 28 20    2( 
	call	L03fd		;; 0ac3: cd fd 03    ...
	lda	L2028		;; 0ac6: 3a 28 20    :( 
	sta	L1fef		;; 0ac9: 32 ef 1f    2..
	mvi	a,001h		;; 0acc: 3e 01       >.
	sta	L187a		;; 0ace: 32 7a 18    2z.
	jmp	L0a6f		;; 0ad1: c3 6f 0a    .o.

L0ad4:	inx	h		;; 0ad4: 23          #
	mov	a,m		;; 0ad5: 7e          ~
	cpi	04eh		;; 0ad6: fe 4e       .N
	jz	L0ae2		;; 0ad8: ca e2 0a    ...
	jmp	L1777		;; 0adb: c3 77 17    .w.

L0ade:	db	'AME '
L0ae2:	lxi	h,L1f72		;; 0ae2: 21 72 1f    .r.
	lxi	d,L0ade		;; 0ae5: 11 de 0a    ...
	call	L1759		;; 0ae8: cd 59 17    .Y.
	jmp	L0850		;; 0aeb: c3 50 08    .P.

	db	0
L0aef:	call	L0302		;; 0aef: cd 02 03    ...
	push	psw		;; 0af2: f5          .
	lda	L1d5e		;; 0af3: 3a 5e 1d    :^.
	ana	a		;; 0af6: a7          .
	jnz	L0b02		;; 0af7: c2 02 0b    ...
	lda	L203c		;; 0afa: 3a 3c 20    :< 
	cpi	020h		;; 0afd: fe 20       . 
	jnz	L1921		;; 0aff: c2 21 19    ...
L0b02:	xra	a		;; 0b02: af          .
	sta	L0da3		;; 0b03: 32 a3 0d    2..
	lda	L1d77		;; 0b06: 3a 77 1d    :w.
	in	011h		;; 0b09: db 11       ..
L0b0a	equ	$-1
	ani	002h		;; 0b0b: e6 02       ..
L0b0c	equ	$-1
	jz	L0b66		;; 0b0d: ca 66 0b    .f.
	in	010h		;; 0b10: db 10       ..
L0b11	equ	$-1
	cpi	002h		;; 0b12: fe 02       ..
	jnz	L0b66		;; 0b14: c2 66 0b    .f.
	; message arriving...
	push	h		;; 0b17: e5          .
	push	d		;; 0b18: d5          .
	push	b		;; 0b19: c5          .
L0b1a:	call	L1314		;; 0b1a: cd 14 13    ...
	cpi	002h		;; 0b1d: fe 02       ..
	jz	L0b1a		;; 0b1f: ca 1a 0b    ...
	; sync done, start message header
	lxi	d,L0200		;; 0b22: 11 00 02    ...
	sded	L134e		;; 0b25: ed 53 4e 13 .SN.
	call	L137c		;; 0b29: cd 7c 13    .|.
	lxi	d,L1e00		;; 0b2c: 11 00 1e    ...
	sded	L134e		;; 0b2f: ed 53 4e 13 .SN.
	pop	b		;; 0b33: c1          .
	pop	d		;; 0b34: d1          .
	pop	h		;; 0b35: e1          .
	lda	L2135		;; 0b36: 3a 35 21    :5.
	ana	a		;; 0b39: a7          .
	jnz	L0b66		;; 0b3a: c2 66 0b    .f.
	lda	L1d77		;; 0b3d: 3a 77 1d    :w.
	cpi	001h		;; 0b40: fe 01       ..
	jz	L0b4c		;; 0b42: ca 4c 0b    .L.
	lda	L1d62		;; 0b45: 3a 62 1d    :b.
	ana	a		;; 0b48: a7          .
	jnz	L0b54		;; 0b49: c2 54 0b    .T.
L0b4c:	lda	L2136+7		;; 0b4c: 3a 3d 21    :=.
	cpi	004h		;; 0b4f: fe 04       ..
	jz	L13f4		;; 0b51: ca f4 13    ...
L0b54:	lda	L2136+7	; msg func no?
	cpi	066h		;; 0b57: fe 66       .f
	jz	L0dc4		;; 0b59: ca c4 0d    ...
	cpi	06eh		;; 0b5c: fe 6e       .n
	jz	L0cda		;; 0b5e: ca da 0c    ...
L0b61:	cpi	064h		;; 0b61: fe 64       .d
	cz	L0e63		;; 0b63: cc 63 0e    .c.
L0b66:	mov	a,c		;; 0b66: 79          y
	cpi	063h		;; 0b67: fe 63       .c
	jz	L0da4		;; 0b69: ca a4 0d    ...
	cpi	002h		;; 0b6c: fe 02       ..
	jrnz	L0b73		;; 0b6e: 20 03        .
	mvi	a,006h		;; 0b70: 3e 06       >.
	mov	c,a		;; 0b72: 4f          O
L0b73:	sta	L1ec6		;; 0b73: 32 c6 1e    2..
	sta	L1d5c		;; 0b76: 32 5c 1d    2\.
	mov	a,c		;; 0b79: 79          y
	cpi	001h		;; 0b7a: fe 01       ..
	jz	L1c0f		;; 0b7c: ca 0f 1c    ...
	cpi	006h		;; 0b7f: fe 06       ..
	jz	L1b58		;; 0b81: ca 58 1b    .X.
	cpi	009h		;; 0b84: fe 09       ..
	jz	L1bfc		;; 0b86: ca fc 1b    ...
	cpi	00ah		;; 0b89: fe 0a       ..
	jnz	L0bae		;; 0b8b: c2 ae 0b    ...
	lda	L1e99		;; 0b8e: 3a 99 1e    :..
	ana	a		;; 0b91: a7          .
	jz	L1c23		;; 0b92: ca 23 1c    .#.
	lda	L1d5d		;; 0b95: 3a 5d 1d    :].
	ana	a		;; 0b98: a7          .
	jz	L1c23		;; 0b99: ca 23 1c    .#.
	push	d		;; 0b9c: d5          .
	call	L046b		;; 0b9d: cd 6b 04    .k.
	pop	d		;; 0ba0: d1          .
	ldax	d		;; 0ba1: 1a          .
	mov	c,a		;; 0ba2: 4f          O
	mvi	b,000h		;; 0ba3: 06 00       ..
	inx	b		;; 0ba5: 03          .
	inx	d		;; 0ba6: 13          .
	lxi	h,L1f6e		;; 0ba7: 21 6e 1f    .n.
	ldir			;; 0baa: ed b0       ..
	pop	psw		;; 0bac: f1          .
	ret			;; 0bad: c9          .

L0bae:	cpi	005h		;; 0bae: fe 05       ..
	jz	L0d56		;; 0bb0: ca 56 0d    .V.
	cpi	00eh		;; 0bb3: fe 0e       ..
	jz	L0e28		;; 0bb5: ca 28 0e    .(.
	cpi	019h		;; 0bb8: fe 19       ..
	jz	L0e5e		;; 0bba: ca 5e 0e    .^.
	cpi	00fh		;; 0bbd: fe 0f       ..
	jc	L0bc7		;; 0bbf: da c7 0b    ...
	cpi	018h		;; 0bc2: fe 18       ..
	jc	L0f2c		;; 0bc4: da 2c 0f    .,.
L0bc7:	cpi	01eh		;; 0bc7: fe 1e       ..
	jz	L0f2c		;; 0bc9: ca 2c 0f    .,.
	cpi	025h		;; 0bcc: fe 25       .%
	jnc	L0bd6		;; 0bce: d2 d6 0b    ...
	cpi	021h		;; 0bd1: fe 21       ..
	jnc	L0f2c		;; 0bd3: d2 2c 0f    .,.
L0bd6:	cpi	028h		;; 0bd6: fe 28       .(
	jz	L0f2c		;; 0bd8: ca 2c 0f    .,.
	cpi	064h		;; 0bdb: fe 64       .d
	jz	L156c		;; 0bdd: ca 6c 15    .l.
	cpi	065h		;; 0be0: fe 65       .e
	jz	L0335		;; 0be2: ca 35 03    .5.
	cpi	066h		;; 0be5: fe 66       .f
	jz	L0968		;; 0be7: ca 68 09    .h.
	cpi	067h		;; 0bea: fe 67       .g
	jz	L1571		;; 0bec: ca 71 15    .q.
	cpi	068h		;; 0bef: fe 68       .h
	jz	L1549		;; 0bf1: ca 49 15    .I.
	cpi	069h		;; 0bf4: fe 69       .i
	jz	L0cd5		;; 0bf6: ca d5 0c    ...
	cpi	06eh		;; 0bf9: fe 6e       .n
	jz	L0d46		;; 0bfb: ca 46 0d    .F.
	cpi	077h		;; 0bfe: fe 77       .w
	jz	L1274		;; 0c00: ca 74 12    .t.
	cpi	078h		;; 0c03: fe 78       .x
	jz	L1303		;; 0c05: ca 03 13    ...
	cpi	07bh		;; 0c08: fe 7b       .{
	jz	L130b		;; 0c0a: ca 0b 13    ...
	cpi	07ch		;; 0c0d: fe 7c       .|
	jz	L1467		;; 0c0f: ca 67 14    .g.
	cpi	07dh		;; 0c12: fe 7d       .}
	jz	L1340		;; 0c14: ca 40 13    .@.
	cpi	07eh		;; 0c17: fe 7e       .~
	jz	L0db3		;; 0c19: ca b3 0d    ...
	cpi	07fh		;; 0c1c: fe 7f       ..
	jz	L0e22		;; 0c1e: ca 22 0e    .".
	cpi	080h		;; 0c21: fe 80       ..
	jz	L0da8		;; 0c23: ca a8 0d    ...
	cpi	081h		;; 0c26: fe 81       ..
	jz	L0dad		;; 0c28: ca ad 0d    ...
	cpi	01ah		;; 0c2b: fe 1a       ..
	jnz	L0c34		;; 0c2d: c2 34 0c    .4.
	sded	L1d57		;; 0c30: ed 53 57 1d .SW.
L0c34:	cpi	020h		;; 0c34: fe 20       . 
	jnz	L0c5d		;; 0c36: c2 5d 0c    .].
	lda	L1d71		;; 0c39: 3a 71 1d    :q.
	ani	002h		;; 0c3c: e6 02       ..
	jnz	L0c4b		;; 0c3e: c2 4b 0c    .K.
	lda	L1d67		;; 0c41: 3a 67 1d    :g.
	cmp	e		;; 0c44: bb          .
	jnz	L0c57		;; 0c45: c2 57 0c    .W.
	jmp	L0c5d		;; 0c48: c3 5d 0c    .].

L0c4b:	mov	a,e		;; 0c4b: 7b          {
	cpi	0ffh		;; 0c4c: fe ff       ..
	jz	L0c5d		;; 0c4e: ca 5d 0c    .].
	sta	L1d67		;; 0c51: 32 67 1d    2g.
	jmp	L0c5d		;; 0c54: c3 5d 0c    .].

L0c57:	mov	a,e		;; 0c57: 7b          {
	cpi	0ffh		;; 0c58: fe ff       ..
	jnz	L18c7		;; 0c5a: c2 c7 18    ...
L0c5d:	pop	psw		;; 0c5d: f1          .
L0c5e:	push	h		;; 0c5e: e5          .
	push	psw		;; 0c5f: f5          .
	lda	L0da3		;; 0c60: 3a a3 0d    :..
	ana	a		;; 0c63: a7          .
	jnz	L0c6b		;; 0c64: c2 6b 0c    .k.
	mov	a,c		;; 0c67: 79          y
	sta	L1ec6		;; 0c68: 32 c6 1e    2..
L0c6b:	xra	a		;; 0c6b: af          .
	sta	L0da3		;; 0c6c: 32 a3 0d    2..
	call	L0302		;; 0c6f: cd 02 03    ...
	mov	a,c		;; 0c72: 79          y
	cpi	012h		;; 0c73: fe 12       ..
	jrnz	L0c89		;; 0c75: 20 12        .
	sded	00000h		;; 0c77: ed 53 00 00 .S..
L0c79	equ	$-2
	lxi	h,13		;; 0c7b: 21 0d 00    ...
	dad	d		;; 0c7e: 19          .
	mov	a,m		;; 0c7f: 7e          ~
	sta	00000h		;; 0c80: 32 00 00    2..
L0c81	equ	$-2
	inx	h		;; 0c83: 23          #
	inx	h		;; 0c84: 23          #
	mov	a,m		;; 0c85: 7e          ~
	sta	00001h		;; 0c86: 32 01 00    2..
L0c87	equ	$-2
L0c89:	pop	psw		;; 0c89: f1          .
	pop	h		;; 0c8a: e1          .
L0c8b:	push	psw		;; 0c8b: f5          .
	mov	a,c		;; 0c8c: 79          y
	sta	L0cd4		;; 0c8d: 32 d4 0c    2..
	pop	psw		;; 0c90: f1          .
	sded	L0cd2		;; 0c91: ed 53 d2 0c .S..
	call	00000h		;; 0c95: cd 00 00    ...
L0c96	equ	$-2
	push	psw		;; 0c98: f5          .
	lda	L0265		;; 0c99: 3a 65 02    :e.
	ana	a		;; 0c9c: a7          .
	jrz	L0ca8		;; 0c9d: 28 09       (.
	pop	psw		;; 0c9f: f1          .
	lda	L0265		;; 0ca0: 3a 65 02    :e.
	push	psw		;; 0ca3: f5          .
	xra	a		;; 0ca4: af          .
	sta	L0265		;; 0ca5: 32 65 02    2e.
L0ca8:	pop	psw		;; 0ca8: f1          .
	sta	L1d7b		;; 0ca9: 32 7b 1d    2{.
	push	psw		;; 0cac: f5          .
	push	d		;; 0cad: d5          .
	push	h		;; 0cae: e5          .
	lda	L0cd4		;; 0caf: 3a d4 0c    :..
	cpi	011h		;; 0cb2: fe 11       ..
	jrz	L0cba		;; 0cb4: 28 04       (.
	cpi	012h		;; 0cb6: fe 12       ..
	jrnz	L0ccb		;; 0cb8: 20 11        .
L0cba:	lhld	L0cd2		;; 0cba: 2a d2 0c    *..
	lxi	d,0000dh	;; 0cbd: 11 0d 00    ...
	dad	d		;; 0cc0: 19          .
	lda	00000h		;; 0cc1: 3a 00 00    :..
L0cc2	equ	$-2
	mov	m,a		;; 0cc4: 77          w
	inx	h		;; 0cc5: 23          #
	inx	h		;; 0cc6: 23          #
	lda	00001h		;; 0cc7: 3a 01 00    :..
L0cc8	equ	$-2
	mov	m,a		;; 0cca: 77          w
L0ccb:	call	L0302		;; 0ccb: cd 02 03    ...
	pop	h		;; 0cce: e1          .
	pop	d		;; 0ccf: d1          .
	pop	psw		;; 0cd0: f1          .
	ret			;; 0cd1: c9          .

L0cd2:	db	0,0
L0cd4:	db	0
L0cd5:	lxi	h,L212e		;; 0cd5: 21 2e 21    ...
	pop	psw		;; 0cd8: f1          .
	ret			;; 0cd9: c9          .

; func 110 - return gatekeeper info to workstation?
L0cda:	push	b		;; 0cda: c5          .
	push	d		;; 0cdb: d5          .
	push	h		;; 0cdc: e5          .
	; lookup L2136+4 in L1d7f? (node id?)
	lda	L2136+4	; node id
	lxi	h,L0d4d+8	;; 0ce0: 21 55 0d    .U.
	mov	m,a		;; 0ce3: 77          w
	lxi	d,L1d7f		;; 0ce4: 11 7f 1d    ...
L0ce7:	ldax	d		;; 0ce7: 1a          .
	ana	a		;; 0ce8: a7          .
	jz	L0d06		;; 0ce9: ca 06 0d    ...
	cmp	m		;; 0cec: be          .
	jz	L0d2f	; node id matches
	push	h		;; 0cf0: e5          .
	inx	d		;; 0cf1: 13          .
	lxi	h,L2136+10	;; 0cf2: 21 40 21    .@.
	ldax	d		;; 0cf5: 1a          .
	inx	d		;; 0cf6: 13          .
	cmp	m		;; 0cf7: be          .
	jnz	L0d01	; next entry
	inx	h		;; 0cfb: 23          #
	ldax	d		;; 0cfc: 1a          .
	cmp	m		;; 0cfd: be          .
	jz	L0d29	; authorization error
L0d01:	inx	d	; next entry
	pop	h		;; 0d02: e1          .
	jmp	L0ce7		;; 0d03: c3 e7 0c    ...

L0d06:	mov	a,m		;; 0d06: 7e          ~
	stax	d		;; 0d07: 12          .
	push	h		;; 0d08: e5          .
	lxi	h,L2136+10	;; 0d09: 21 40 21    .@.
	inx	d		;; 0d0c: 13          .
	mov	a,m		;; 0d0d: 7e          ~
	stax	d		;; 0d0e: 12          .
	inx	h		;; 0d0f: 23          #
	inx	d		;; 0d10: 13          .
	mov	a,m		;; 0d11: 7e          ~
	stax	d		;; 0d12: 12          .
L0d13:	pop	h		;; 0d13: e1          .
	mvi	a,071h	; success
L0d16:	sta	L0d4d+7		;; 0d16: 32 54 0d    2T.
	mov	a,m		;; 0d19: 7e          ~
	sta	L0d4d+1		;; 0d1a: 32 4e 0d    2N.
	lxi	h,L0d4d		;; 0d1d: 21 4d 0d    .M.
	call	L0f26	; send?
	pop	h		;; 0d23: e1          .
	pop	d		;; 0d24: d1          .
	pop	b		;; 0d25: c1          .
	jmp	L0b66		;; 0d26: c3 66 0b    .f.

L0d29:	pop	h		;; 0d29: e1          .
	mvi	a,070h	; authorization error?
	jmp	L0d16		;; 0d2c: c3 16 0d    ...

; node id matches entry
L0d2f:	push	h		;; 0d2f: e5          .
	inx	d		;; 0d30: 13          .
	lxi	h,L2136+10	;; 0d31: 21 40 21    .@.
	ldax	d		;; 0d34: 1a          .
	cmp	m		;; 0d35: be          .
	jnz	L0d40		;; 0d36: c2 40 0d    .@.
	inx	d		;; 0d39: 13          .
	inx	h		;; 0d3a: 23          #
	ldax	d		;; 0d3b: 1a          .
	cmp	m		;; 0d3c: be          .
	jz	L0d13	; success
L0d40:	pop	h		;; 0d40: e1          .
	mvi	a,06fh	; node in use
	jmp	L0d16		;; 0d43: c3 16 0d    ...

; func 110 - return gatekeeper info - local call?
L0d46:	pop	psw		;; 0d46: f1          .
	lxi	h,L1d7f		;; 0d47: 21 7f 1d    ...
	mvi	a,07bh	; "I am a gatekeeper"
	ret			;; 0d4c: c9          .

; response message
L0d4d:	db	40h	; ACK?
	db	0,0,0,0,0,0,0,0

L0d56:	lda	L0da3		;; 0d56: 3a a3 0d    :..
	ana	a		;; 0d59: a7          .
	jnz	L0c5d		;; 0d5a: c2 5d 0c    .].
	lda	L0793		;; 0d5d: 3a 93 07    :..
	ana	a		;; 0d60: a7          .
	jz	L0c5d		;; 0d61: ca 5d 0c    .].
	push	b		;; 0d64: c5          .
	push	h		;; 0d65: e5          .
	push	d		;; 0d66: d5          .
	lxi	h,L1e18		;; 0d67: 21 18 1e    ...
	lda	L07b6		;; 0d6a: 3a b6 07    :..
	mov	e,a		;; 0d6d: 5f          _
	mvi	d,000h		;; 0d6e: 16 00       ..
	dad	d		;; 0d70: 19          .
	pop	d		;; 0d71: d1          .
	push	d		;; 0d72: d5          .
	mov	a,e		;; 0d73: 7b          {
	mov	m,a		;; 0d74: 77          w
	lda	L07b6		;; 0d75: 3a b6 07    :..
	inr	a		;; 0d78: 3c          <
	sta	L07b6		;; 0d79: 32 b6 07    2..
	cpi	080h		;; 0d7c: fe 80       ..
	jnz	L0d9e		;; 0d7e: c2 9e 0d    ...
	xra	a		;; 0d81: af          .
	sta	L07b6		;; 0d82: 32 b6 07    2..
	lxi	d,L1e18		;; 0d85: 11 18 1e    ...
	mvi	c,01ah		;; 0d88: 0e 1a       ..
	call	L0c5e		;; 0d8a: cd 5e 0c    .^.
	lxi	d,L0792		;; 0d8d: 11 92 07    ...
	mvi	c,015h		;; 0d90: 0e 15       ..
	call	L0c5e		;; 0d92: cd 5e 0c    .^.
	lded	L1d57		;; 0d95: ed 5b 57 1d .[W.
	mvi	c,01ah		;; 0d99: 0e 1a       ..
	call	L0c5e		;; 0d9b: cd 5e 0c    .^.
L0d9e:	pop	d		;; 0d9e: d1          .
	pop	h		;; 0d9f: e1          .
	pop	b		;; 0da0: c1          .
	pop	psw		;; 0da1: f1          .
	ret			;; 0da2: c9          .

L0da3:	db	0
L0da4:	pop	psw		;; 0da4: f1          .
	jmp	00000h		;; 0da5: c3 00 00    ...

L0da6	equ	$-2
L0da8:	pop	psw		;; 0da8: f1          .
	sta	L0db2		;; 0da9: 32 b2 0d    2..
	ret			;; 0dac: c9          .

L0dad:	pop	psw		;; 0dad: f1          .
	lda	L0db2		;; 0dae: 3a b2 0d    :..
	ret			;; 0db1: c9          .

L0db2:	db	0
L0db3:	pop	psw		;; 0db3: f1          .
L0db4:	push	d		;; 0db4: d5          .
	ani	00fh		;; 0db5: e6 0f       ..
	sta	L0279		;; 0db7: 32 79 02    2y.
	add	a		;; 0dba: 87          .
	mov	e,a		;; 0dbb: 5f          _
	mvi	d,000h		;; 0dbc: 16 00       ..
	lxi	h,L1e9a		;; 0dbe: 21 9a 1e    ...
	dad	d		;; 0dc1: 19          .
	pop	d		;; 0dc2: d1          .
	ret			;; 0dc3: c9          .

L0dc4:	push	psw		;; 0dc4: f5          .
	push	b		;; 0dc5: c5          .
	push	d		;; 0dc6: d5          .
	push	h		;; 0dc7: e5          .
	lxi	h,L203b		;; 0dc8: 21 3b 20    .; 
	inx	h		;; 0dcb: 23          #
L0dcc:	mov	a,m		;; 0dcc: 7e          ~
	ana	a		;; 0dcd: a7          .
	jz	L0e1b		;; 0dce: ca 1b 0e    ...
	cpi	020h		;; 0dd1: fe 20       . 
L0dd3:	jz	L0ddd		;; 0dd3: ca dd 0d    ...
	lxi	d,00024h	;; 0dd6: 11 24 00    .$.
	dad	d		;; 0dd9: 19          .
	jmp	L0dcc		;; 0dda: c3 cc 0d    ...

L0ddd:	dcx	h		;; 0ddd: 2b          +
	shld	L2029		;; 0dde: 22 29 20    ") 
	lda	L2136+5		;; 0de1: 3a 3b 21    :;.
	sta	L1532		;; 0de4: 32 32 15    22.
	lda	L2136+4		;; 0de7: 3a 3a 21    ::.
	lxi	h,L13a3		;; 0dea: 21 a3 13    ...
	cmp	m		;; 0ded: be          .
	jnz	L0df2		;; 0dee: c2 f2 0d    ...
	xra	a		;; 0df1: af          .
L0df2:	push	psw		;; 0df2: f5          .
	lxi	h,L1531		;; 0df3: 21 31 15    .1.
	call	L0f26		;; 0df6: cd 26 0f    .&.
	pop	psw		;; 0df9: f1          .
	sta	L2136+25	;; 0dfa: 32 4f 21    2O.
	lda	L2136+10	;; 0dfd: 3a 40 21    :@.
	sta	L2136+24	;; 0e00: 32 4e 21    2N.
	lda	L2152		;; 0e03: 3a 52 21    :R.
	sta	L2136+23	;; 0e06: 32 4d 21    2M.
	lxi	h,L2136+10	;; 0e09: 21 40 21    .@.
	lded	L2029		;; 0e0c: ed 5b 29 20 .[) 
	lxi	b,16		;; 0e10: 01 10 00    ...
	ldir			;; 0e13: ed b0       ..
	mvi	a,00fh		;; 0e15: 3e 0f       >.
	lhld	L2029		;; 0e17: 2a 29 20    *) 
	mov	m,a		;; 0e1a: 77          w
L0e1b:	pop	h		;; 0e1b: e1          .
	pop	d		;; 0e1c: d1          .
	pop	b		;; 0e1d: c1          .
	pop	psw		;; 0e1e: f1          .
	jmp	L0b66		;; 0e1f: c3 66 0b    .f.

L0e22:	lxi	h,L1f6f		;; 0e22: 21 6f 1f    .o.
	jmp	L0e55		;; 0e25: c3 55 0e    .U.

L0e28:	lda	L1d78		;; 0e28: 3a 78 1d    :x.
	sta	L1d7a		;; 0e2b: 32 7a 1d    2z.
	mov	a,e		;; 0e2e: 7b          {
	ani	00fh		;; 0e2f: e6 0f       ..
	sta	L1d78		;; 0e31: 32 78 1d    2x.
	sspd	L0e5c		;; 0e34: ed 73 5c 0e .s\.
	lxi	sp,L2124	;; 0e38: 31 24 21    1$.
	inr	a		;; 0e3b: 3c          <
	call	L0db4		;; 0e3c: cd b4 0d    ...
	inx	h		;; 0e3f: 23          #
	mov	a,m		;; 0e40: 7e          ~
	ana	a		;; 0e41: a7          .
	jnz	L0e51		;; 0e42: c2 51 0e    .Q.
	dcx	h		;; 0e45: 2b          +
	mov	a,m		;; 0e46: 7e          ~
	dcr	a		;; 0e47: 3d          =
	jm	L0e57		;; 0e48: fa 57 0e    .W.
	mov	e,a		;; 0e4b: 5f          _
	mvi	c,00eh		;; 0e4c: 0e 0e       ..
	call	L0c5e		;; 0e4e: cd 5e 0c    .^.
L0e51:	lspd	L0e5c		;; 0e51: ed 7b 5c 0e .{\.
L0e55:	pop	psw		;; 0e55: f1          .
	ret			;; 0e56: c9          .

L0e57:	mov	a,e		;; 0e57: 7b          {
	inr	a		;; 0e58: 3c          <
	jmp	L1002		;; 0e59: c3 02 10    ...

L0e5c:	db	0,0
L0e5e:	pop	psw		;; 0e5e: f1          .
	lda	L1d78		;; 0e5f: 3a 78 1d    :x.
	ret			;; 0e62: c9          .

L0e63:	push	b		;; 0e63: c5          .
	push	d		;; 0e64: d5          .
	push	h		;; 0e65: e5          .
	lda	L2136+10	;; 0e66: 3a 40 21    :@.
	cpi	028h		;; 0e69: fe 28       .(
	jrz	L0e75		;; 0e6b: 28 08       (.
	cpi	022h		;; 0e6d: fe 22       ."
	jrz	L0e75		;; 0e6f: 28 04       (.
	cpi	015h		;; 0e71: fe 15       ..
	jrnz	L0e80		;; 0e73: 20 0b        .
L0e75:	lxi	h,L2167		;; 0e75: 21 67 21    .g.
	lxi	d,L1eed		;; 0e78: 11 ed 1e    ...
	lxi	b,00080h	;; 0e7b: 01 80 00    ...
	ldir			;; 0e7e: ed b0       ..
L0e80:	lxi	d,L1eed		;; 0e80: 11 ed 1e    ...
	mvi	c,01ah		;; 0e83: 0e 1a       ..
	call	L0c5e		;; 0e85: cd 5e 0c    .^.
	lda	L2166		;; 0e88: 3a 66 21    :f.
	mov	e,a		;; 0e8b: 5f          _
	mvi	c,020h		;; 0e8c: 0e 20       . 
	call	L0c5e		;; 0e8e: cd 5e 0c    .^.
	lhld	L2162		;; 0e91: 2a 62 21    *b.
	shld	L1de1		;; 0e94: 22 e1 1d    "..
	xra	a		;; 0e97: af          .
	sta	L1d61		;; 0e98: 32 61 1d    2a.
	lda	L2162		;; 0e9b: 3a 62 21    :b.
	cpi	0a5h		;; 0e9e: fe a5       ..
	jrz	L0ea7		;; 0ea0: 28 05       (.
	mvi	a,001h		;; 0ea2: 3e 01       >.
	sta	L1d61		;; 0ea4: 32 61 1d    2a.
L0ea7:	lda	L2136+10	;; 0ea7: 3a 40 21    :@.
	cpi	016h		;; 0eaa: fe 16       ..
	jnz	L0eb7		;; 0eac: c2 b7 0e    ...
	mvi	c,013h		;; 0eaf: 0e 13       ..
	lxi	d,L2136+11	;; 0eb1: 11 41 21    .A.
	call	L0c5e		;; 0eb4: cd 5e 0c    .^.
L0eb7:	lda	L2136+10	;; 0eb7: 3a 40 21    :@.
	mov	c,a		;; 0eba: 4f          O
	lxi	d,L2136+11	;; 0ebb: 11 41 21    .A.
	call	L01d6		;; 0ebe: cd d6 01    ...
	sta	L1eeb		;; 0ec1: 32 eb 1e    2..
	lda	L1d67		;; 0ec4: 3a 67 1d    :g.
	mov	e,a		;; 0ec7: 5f          _
	mvi	c,020h		;; 0ec8: 0e 20       . 
	call	L0c5e		;; 0eca: cd 5e 0c    .^.
	lxi	h,L2136+11	;; 0ecd: 21 41 21    .A.
	lxi	d,L1ec7		;; 0ed0: 11 c7 1e    ...
	lxi	b,36		;; 0ed3: 01 24 00    .$.
	ldir			;; 0ed6: ed b0       ..
	lda	L2136+10	;; 0ed8: 3a 40 21    :@.
	cpi	020h		;; 0edb: fe 20       . 
	jnc	L0ee6		;; 0edd: d2 e6 0e    ...
	lhld	L1de1		;; 0ee0: 2a e1 1d    *..
	shld	L1ee8		;; 0ee3: 22 e8 1e    "..
L0ee6:	lda	L2136+4		;; 0ee6: 3a 3a 21    ::.
	sta	L1ebd		;; 0ee9: 32 bd 1e    2..
	mvi	a,065h		;; 0eec: 3e 65       >e
	sta	L1ec3		;; 0eee: 32 c3 1e    2..
	lxi	h,00027h	;; 0ef1: 21 27 00    .'.
	lda	L2136+10	;; 0ef4: 3a 40 21    :@.
	cpi	011h		;; 0ef7: fe 11       ..
	jz	L0f0b		;; 0ef9: ca 0b 0f    ...
	cpi	012h		;; 0efc: fe 12       ..
	jz	L0f0b		;; 0efe: ca 0b 0f    ...
	cpi	014h		;; 0f01: fe 14       ..
	jz	L0f0b		;; 0f03: ca 0b 0f    ...
	cpi	021h		;; 0f06: fe 21       ..
	jnz	L0f0e		;; 0f08: c2 0e 0f    ...
L0f0b:	lxi	h,000a7h	;; 0f0b: 21 a7 00    ...
L0f0e:	shld	L1ec4		;; 0f0e: 22 c4 1e    "..
	lxi	h,L1ebc		;; 0f11: 21 bc 1e    ...
	call	L0f26		;; 0f14: cd 26 0f    .&.
	lded	L1d57		;; 0f17: ed 5b 57 1d .[W.
	mvi	c,01ah		;; 0f1b: 0e 1a       ..
	call	L0c5e		;; 0f1d: cd 5e 0c    .^.
	pop	h		;; 0f20: e1          .
	pop	d		;; 0f21: d1          .
	pop	b		;; 0f22: c1          .
	ret			;; 0f23: c9          .

L0f24:	db	0,0

L0f26:	mvi	a,001h		;; 0f26: 3e 01       >.
	push	psw		;; 0f28: f5          .
	jmp	L1467		;; 0f29: c3 67 14    .g.

L0f2c:	push	b		;; 0f2c: c5          .
	push	h		;; 0f2d: e5          .
	push	d		;; 0f2e: d5          .
	xchg			;; 0f2f: eb          .
	lda	L1d5c		;; 0f30: 3a 5c 1d    :\.
	cpi	011h		;; 0f33: fe 11       ..
	jnz	L0f3e		;; 0f35: c2 3e 0f    .>.
	shld	L1d5f		;; 0f38: 22 5f 1d    "_.
	jmp	L0f46		;; 0f3b: c3 46 0f    .F.

L0f3e:	cpi	012h		;; 0f3e: fe 12       ..
	jnz	L0f46		;; 0f40: c2 46 0f    .F.
	lhld	L1d5f		;; 0f43: 2a 5f 1d    *_.
L0f46:	call	L1bd9		;; 0f46: cd d9 1b    ...
	sta	L2031		;; 0f49: 32 31 20    21 
	lda	L1d66		;; 0f4c: 3a 66 1d    :f.
	cpi	046h		;; 0f4f: fe 46       .F
	jz	L0f7e		;; 0f51: ca 7e 0f    .~.
	push	h		;; 0f54: e5          .
	push	d		;; 0f55: d5          .
	lxi	d,00009h	;; 0f56: 11 09 00    ...
	dad	d		;; 0f59: 19          .
	mov	a,m		;; 0f5a: 7e          ~
	cpi	04fh		;; 0f5b: fe 4f       .O
	jnz	L0f7c		;; 0f5d: c2 7c 0f    .|.
	inx	h		;; 0f60: 23          #
	mov	a,m		;; 0f61: 7e          ~
	cpi	056h		;; 0f62: fe 56       .V
	jnz	L0f7c		;; 0f64: c2 7c 0f    .|.
	mvi	c,020h		;; 0f67: 0e 20       . 
	lda	L2020		;; 0f69: 3a 20 20    :  
	sta	L2031		;; 0f6c: 32 31 20    21 
	mov	e,a		;; 0f6f: 5f          _
	call	L0c8b		;; 0f70: cd 8b 0c    ...
	pop	d		;; 0f73: d1          .
	pop	h		;; 0f74: e1          .
	lda	L2021		;; 0f75: 3a 21 20    :. 
	mov	m,a		;; 0f78: 77          w
	jmp	L0f7e		;; 0f79: c3 7e 0f    .~.

L0f7c:	pop	d		;; 0f7c: d1          .
	pop	h		;; 0f7d: e1          .
L0f7e:	mov	a,m		;; 0f7e: 7e          ~
	push	psw		;; 0f7f: f5          .
	ani	0f0h		;; 0f80: e6 f0       ..
	jz	L0f8a		;; 0f82: ca 8a 0f    ...
	pop	psw		;; 0f85: f1          .
	xra	a		;; 0f86: af          .
	jmp	L0f8b		;; 0f87: c3 8b 0f    ...

L0f8a:	pop	psw		;; 0f8a: f1          .
L0f8b:	ani	00fh		;; 0f8b: e6 0f       ..
	ana	a		;; 0f8d: a7          .
	jnz	L0f95		;; 0f8e: c2 95 0f    ...
	lda	L1d78		;; 0f91: 3a 78 1d    :x.
	inr	a		;; 0f94: 3c          <
L0f95:	lxi	d,L1ec7		;; 0f95: 11 c7 1e    ...
	shld	L0f24		;; 0f98: 22 24 0f    "$.
	lxi	b,00024h	;; 0f9b: 01 24 00    .$.
	ldir			;; 0f9e: ed b0       ..
	sta	L1ec7		;; 0fa0: 32 c7 1e    2..
	call	L0db4		;; 0fa3: cd b4 0d    ...
	mov	a,m		;; 0fa6: 7e          ~
	ana	a		;; 0fa7: a7          .
	jz	L0fff		;; 0fa8: ca ff 0f    ...
	sta	L1ec7		;; 0fab: 32 c7 1e    2..
	inx	h		;; 0fae: 23          #
	mov	a,m		;; 0faf: 7e          ~
	ana	a		;; 0fb0: a7          .
	jnz	L1037		;; 0fb1: c2 37 10    .7.
	pop	d		;; 0fb4: d1          .
	lxi	d,L1ec7		;; 0fb5: 11 c7 1e    ...
	lhld	00040h		;; 0fb8: 2a 40 00    *@.
	shld	L1de1		;; 0fbb: 22 e1 1d    "..
	lda	00008h		;; 0fbe: 3a 08 00    :..
	sta	L1d61		;; 0fc1: 32 61 1d    2a.
	pop	h		;; 0fc4: e1          .
	pop	b		;; 0fc5: c1          .
	pop	psw		;; 0fc6: f1          .
	call	L01d6		;; 0fc7: cd d6 01    ...
	push	d		;; 0fca: d5          .
	push	b		;; 0fcb: c5          .
	push	h		;; 0fcc: e5          .
	push	psw		;; 0fcd: f5          .
	lda	L1d5c		;; 0fce: 3a 5c 1d    :\.
	cpi	00fh		;; 0fd1: fe 0f       ..
	jrz	L0fd9		;; 0fd3: 28 04       (.
	cpi	010h		;; 0fd5: fe 10       ..
	jrnz	L0fdf		;; 0fd7: 20 06        .
L0fd9:	lhld	L1de1		;; 0fd9: 2a e1 1d    *..
	shld	00040h		;; 0fdc: 22 40 00    "@.
L0fdf:	call	L1bcc		;; 0fdf: cd cc 1b    ...
	lxi	h,L1ec8		;; 0fe2: 21 c8 1e    ...
	lded	L0f24		;; 0fe5: ed 5b 24 0f .[$.
	inx	d		;; 0fe9: 13          .
	lxi	b,00020h	;; 0fea: 01 20 00    . .
	lda	L1d5c		;; 0fed: 3a 5c 1d    :\.
	cpi	020h		;; 0ff0: fe 20       . 
	jc	L0ff8		;; 0ff2: da f8 0f    ...
	lxi	b,00023h	;; 0ff5: 01 23 00    .#.
L0ff8:	ldir			;; 0ff8: ed b0       ..
	pop	psw		;; 0ffa: f1          .
	pop	h		;; 0ffb: e1          .
	pop	b		;; 0ffc: c1          .
	pop	d		;; 0ffd: d1          .
	ret			;; 0ffe: c9          .

L0fff:	lda	L1ec7		;; 0fff: 3a c7 1e    :..
L1002:	adi	040h		;; 1002: c6 40       .@
	sta	L101b		;; 1004: 32 1b 10    2..
	lxi	d,L1013		;; 1007: 11 13 10    ...
	call	L1bfd		;; 100a: cd fd 1b    ...
	call	L18b4		;; 100d: cd b4 18    ...
	jmp	L033e		;; 1010: c3 3e 03    .>.

L1013:	db	'?Device '
L101b:	db	'X: not assigned - DSK:=A:',0dh,0ah,'$'
L1037:	sta	L1ebd		;; 1037: 32 bd 1e    2..
	lda	L1ec6		;; 103a: 3a c6 1e    :..
	cpi	00fh		;; 103d: fe 0f       ..
	jrnz	L1054		;; 103f: 20 13        .
	lda	00008h		;; 1041: 3a 08 00    :..
	ana	a		;; 1044: a7          .
	jrz	L1058		;; 1045: 28 11       (.
	lxi	h,0efffh	;; 1047: 21 ff ef    ...
	shld	L134e		;; 104a: 22 4e 13    "N.
	mvi	a,00fh		;; 104d: 3e 0f       >.
	sta	L1189		;; 104f: 32 89 11    2..
	jr	L1058		;; 1052: 18 04       ..

L1054:	cpi	010h		;; 1054: fe 10       ..
	jrnz	L1076		;; 1056: 20 1e        .
L1058:	lhld	00040h		;; 1058: 2a 40 00    *@.
	shld	L1ee8		;; 105b: 22 e8 1e    "..
	lda	00008h		;; 105e: 3a 08 00    :..
	ana	a		;; 1061: a7          .
	jrnz	L106b		;; 1062: 20 07        .
	mvi	a,0a5h		;; 1064: 3e a5       >.
	sta	L1ee8		;; 1066: 32 e8 1e    2..
	jr	L1076		;; 1069: 18 0b       ..

L106b:	lda	L1ee8		;; 106b: 3a e8 1e    :..
	cpi	0a5h		;; 106e: fe a5       ..
	jrz	L1076		;; 1070: 28 04       (.
	xra	a		;; 1072: af          .
	sta	L1ee8		;; 1073: 32 e8 1e    2..
L1076:	lda	L0da3		;; 1076: 3a a3 0d    :..
	ana	a		;; 1079: a7          .
	jrnz	L1084		;; 107a: 20 08        .
	lda	L1d71		;; 107c: 3a 71 1d    :q.
	ani	004h		;; 107f: e6 04       ..
	jz	L18af		;; 1081: ca af 18    ...
L1084:	lda	L1ec6		;; 1084: 3a c6 1e    :..
	cpi	01eh		;; 1087: fe 1e       ..
	jrnz	L1093		;; 1089: 20 08        .
	lda	L1d71		;; 108b: 3a 71 1d    :q.
	cpi	037h		;; 108e: fe 37       .7
	jnz	L1255		;; 1090: c2 55 12    .U.
L1093:	lxi	h,00027h	;; 1093: 21 27 00    .'.
	shld	L1ec4		;; 1096: 22 c4 1e    "..
	lda	L1ec6		;; 1099: 3a c6 1e    :..
	sta	L2026		;; 109c: 32 26 20    2& 
	cpi	028h		;; 109f: fe 28       .(
	jrz	L10ab		;; 10a1: 28 08       (.
	cpi	022h		;; 10a3: fe 22       ."
	jrz	L10ab		;; 10a5: 28 04       (.
	cpi	015h		;; 10a7: fe 15       ..
	jrnz	L10bc		;; 10a9: 20 11        .
L10ab:	lxi	h,000a7h	;; 10ab: 21 a7 00    ...
	shld	L1ec4		;; 10ae: 22 c4 1e    "..
	lhld	L1d57		;; 10b1: 2a 57 1d    *W.
	lxi	d,L1eed		;; 10b4: 11 ed 1e    ...
	lxi	b,00080h	;; 10b7: 01 80 00    ...
	ldir			;; 10ba: ed b0       ..
L10bc:	mvi	a,064h		;; 10bc: 3e 64       >d
	sta	L1ec3		;; 10be: 32 c3 1e    2..
	lda	L1ec6		;; 10c1: 3a c6 1e    :..
	sta	L20a9		;; 10c4: 32 a9 20    2. 
	lda	L2031		;; 10c7: 3a 31 20    :1 
	sta	L1eec		;; 10ca: 32 ec 1e    2..
	lda	L1be6		;; 10cd: 3a e6 1b    :..
	ana	a		;; 10d0: a7          .
	jrz	L10d7		;; 10d1: 28 04       (.
	xra	a		;; 10d3: af          .
	sta	L1eec		;; 10d4: 32 ec 1e    2..
L10d7:	xra	a		;; 10d7: af          .
	sta	L11b5		;; 10d8: 32 b5 11    2..
	lda	L20a9		;; 10db: 3a a9 20    :. 
	sta	L1ec6		;; 10de: 32 c6 1e    2..
L10e1:	lxi	h,L1ebc		;; 10e1: 21 bc 1e    ...
	di			;; 10e4: f3          .
	call	L0f26		;; 10e5: cd 26 0f    .&.
L10e8:	call	L1341		;; 10e8: cd 41 13    .A.
	ei			;; 10eb: fb          .
	lda	L2135		;; 10ec: 3a 35 21    :5.
	cpi	001h		;; 10ef: fe 01       ..
	jz	L1181		;; 10f1: ca 81 11    ...
	cpi	003h		;; 10f4: fe 03       ..
	jrz	L10e1		;; 10f6: 28 e9       (.
	cpi	002h		;; 10f8: fe 02       ..
	jnz	L11bb		;; 10fa: c2 bb 11    ...
	lda	L11b5		;; 10fd: 3a b5 11    :..
	adi	005h		;; 1100: c6 05       ..
	sta	L11b5		;; 1102: 32 b5 11    2..
L1105:	xra	a		;; 1105: af          .
	sta	L1190		;; 1106: 32 90 11    2..
	lda	L11b5		;; 1109: 3a b5 11    :..
	inr	a		;; 110c: 3c          <
	sta	L11b5		;; 110d: 32 b5 11    2..
	ani	080h		;; 1110: e6 80       ..
	jrz	L10e1		;; 1112: 28 cd       (.
	lda	L1d64		;; 1114: 3a 64 1d    :d.
	dcr	a		;; 1117: 3d          =
	cpi	0f7h		;; 1118: fe f7       ..
	jz	L1122		;; 111a: ca 22 11    .".
	sta	L1d64		;; 111d: 32 64 1d    2d.
	jr	L10d7		;; 1120: 18 b5       ..

L1122:	lda	L1d65		;; 1122: 3a 65 1d    :e.
	sta	L1d64		;; 1125: 32 64 1d    2d.
	lda	L1ebd		;; 1128: 3a bd 1e    :..
	adi	030h		;; 112b: c6 30       .0
	sta	L1198		;; 112d: 32 98 11    2..
	mvi	a,020h		;; 1130: 3e 20       > 
	sta	L11a5		;; 1132: 32 a5 11    2..
	mvi	a,02dh		;; 1135: 3e 2d       >-
	sta	L11a6		;; 1137: 32 a6 11    2..
	lda	00008h		;; 113a: 3a 08 00    :..
	ana	a		;; 113d: a7          .
	jrz	L1153		;; 113e: 28 13       (.
	mvi	a,00dh		;; 1140: 3e 0d       >.
	sta	L11a5		;; 1142: 32 a5 11    2..
	mvi	a,024h		;; 1145: 3e 24       >$
	sta	L11a6		;; 1147: 32 a6 11    2..
	lxi	d,L1192		;; 114a: 11 92 11    ...
	call	L1bfd		;; 114d: cd fd 1b    ...
	jmp	L10d7		;; 1150: c3 d7 10    ...

L1153:	lxi	d,L1192		;; 1153: 11 92 11    ...
	call	L1bfd		;; 1156: cd fd 1b    ...
	mvi	c,001h		;; 1159: 0e 01       ..
	call	L0c5e		;; 115b: cd 5e 0c    .^.
	push	psw		;; 115e: f5          .
	mvi	e,00dh		;; 115f: 1e 0d       ..
	call	L1b5f		;; 1161: cd 5f 1b    ._.
	pop	psw		;; 1164: f1          .
	ani	05fh		;; 1165: e6 5f       ._
	cpi	059h		;; 1167: fe 59       .Y
	jz	L10d7		;; 1169: ca d7 10    ...
	cpi	04eh		;; 116c: fe 4e       .N
	jrnz	L1122		;; 116e: 20 b2        .
	xra	a		;; 1170: af          .
	sta	L1d79		;; 1171: 32 79 1d    2y.
	call	L04ec		;; 1174: cd ec 04    ...
	sta	L1e9d		;; 1177: 32 9d 1e    2..
	inr	a		;; 117a: 3c          <
	sta	L1e9c		;; 117b: 32 9c 1e    2..
	jmp	L033e		;; 117e: c3 3e 03    .>.

L1181:	lda	L1190		;; 1181: 3a 90 11    :..
	inr	a		;; 1184: 3c          <
	sta	L1190		;; 1185: 32 90 11    2..
	ani	003h		;; 1188: e6 03       ..
L1189	equ	$-1
	jnz	L10e8		;; 118a: c2 e8 10    ...
	jmp	L1105		;; 118d: c3 05 11    ...

L1190:	db	0
L1191:	db	0
L1192:	db	'?Node '
L1198:	db	'x unavailable'
L11a5:	db	' '
L11a6:	db	'- Retry(Y/N)? $'
L11b5:	db	0
L11b6:	db	'BUSY$'

L11bb:	lda	L1d65		;; 11bb: 3a 65 1d    :e.
	sta	L1d64		;; 11be: 32 64 1d    2d.
	lda	L2136+7		;; 11c1: 3a 3d 21    :=.
	cpi	064h		;; 11c4: fe 64       .d
	jz	L126e		;; 11c6: ca 6e 12    .n.
	cpi	065h		;; 11c9: fe 65       .e
	jnz	L1181		;; 11cb: c2 81 11    ...
	xra	a		;; 11ce: af          .
	sta	L1190		;; 11cf: 32 90 11    2..
	sta	L1191		;; 11d2: 32 91 11    2..
	lda	L2026		;; 11d5: 3a 26 20    :& 
	cpi	011h		;; 11d8: fe 11       ..
	jrz	L11e8		;; 11da: 28 0c       (.
	cpi	012h		;; 11dc: fe 12       ..
	jrz	L11e8		;; 11de: 28 08       (.
	cpi	014h		;; 11e0: fe 14       ..
	jrz	L11e8		;; 11e2: 28 04       (.
	cpi	021h		;; 11e4: fe 21       ..
	jrnz	L11f4		;; 11e6: 20 0c        .
L11e8:	lxi	h,L2167		;; 11e8: 21 67 21    .g.
	lded	L1d57		;; 11eb: ed 5b 57 1d .[W.
	lxi	b,00080h	;; 11ef: 01 80 00    ...
	ldir			;; 11f2: ed b0       ..
L11f4:	lxi	h,L2136+12	;; 11f4: 21 42 21    .B.
	lded	L0f24		;; 11f7: ed 5b 24 0f .[$.
	inx	d		;; 11fb: 13          .
	lxi	b,00020h	;; 11fc: 01 20 00    . .
	lda	L2026		;; 11ff: 3a 26 20    :& 
	cpi	020h		;; 1202: fe 20       . 
	jc	L120a		;; 1204: da 0a 12    ...
	lxi	b,00023h	;; 1207: 01 23 00    .#.
L120a:	ldir			;; 120a: ed b0       ..
	lda	L2026		;; 120c: 3a 26 20    :& 
	cpi	00fh		;; 120f: fe 0f       ..
	jrnz	L1220		;; 1211: 20 0d        .
	lxi	h,L2000		;; 1213: 21 00 20    .. 
	shld	L134e		;; 1216: 22 4e 13    "N.
	mvi	a,003h		;; 1219: 3e 03       >.
	sta	L1189		;; 121b: 32 89 11    2..
	jr	L1224		;; 121e: 18 04       ..

L1220:	cpi	010h		;; 1220: fe 10       ..
	jrnz	L122a		;; 1222: 20 06        .
L1224:	lhld	L2162		;; 1224: 2a 62 21    *b.
	shld	00040h		;; 1227: 22 40 00    "@.
L122a:	lda	L1d71		;; 122a: 3a 71 1d    :q.
	cpi	037h		;; 122d: fe 37       .7
	jrz	L1247		;; 122f: 28 16       (.
	lda	L0da3		;; 1231: 3a a3 0d    :..
	ana	a		;; 1234: a7          .
	jrnz	L1247		;; 1235: 20 10        .
	lxi	h,L2136+12	;; 1237: 21 42 21    .B.
	mov	a,m		;; 123a: 7e          ~
	ani	080h		;; 123b: e6 80       ..
	jrnz	L1255		;; 123d: 20 16        .
	lxi	h,L2136+22	;; 123f: 21 4c 21    .L.
	mov	a,m		;; 1242: 7e          ~
	ani	080h		;; 1243: e6 80       ..
	jrnz	L1255		;; 1245: 20 0e        .
L1247:	call	L1bcc		;; 1247: cd cc 1b    ...
	pop	d		;; 124a: d1          .
	pop	h		;; 124b: e1          .
	pop	b		;; 124c: c1          .
	pop	psw		;; 124d: f1          .
	lda	L2165		;; 124e: 3a 65 21    :e.
	mov	l,a		;; 1251: 6f          o
	mov	h,b		;; 1252: 60          `
	ret			;; 1253: c9          .

	db	0
L1255:	lxi	d,L125e		;; 1255: 11 5e 12    .^.
	call	L1bfd		;; 1258: cd fd 1b    ...
	jmp	L033e		;; 125b: c3 3e 03    .>.

L125e:	db	'?File protected$'
L126e:	pop	d		;; 126e: d1          .
	pop	h		;; 126f: e1          .
	pop	b		;; 1270: c1          .
	jmp	L0b61		;; 1271: c3 61 0b    .a.

; func 119 - initialize everything from network vector block
L1274:	lxi	h,L1df3		;; 1274: 21 f3 1d    ...
	mov	a,m
	inx	h		;; 1278: 23          #
	inx	h		;; 1279: 23          #
	inx	h		;; 127a: 23          #
	sta	L130c		;; 127b: 32 0c 13    2..
	sta	L132a		;; 127e: 32 2a 13    2*.
	sta	L0b0a		;; 1281: 32 0a 0b    2..
	sta	L1540		;; 1284: 32 40 15    2@.
	sta	L1353		;; 1287: 32 53 13    2S.
	sta	L14ed		;; 128a: 32 ed 14    2..
	sta	L14fb		;; 128d: 32 fb 14    2..
	sta	L14ff		;; 1290: 32 ff 14    2..
	sta	L1509		;; 1293: 32 09 15    2..
	sta	L150d		;; 1296: 32 0d 15    2..
	sta	L147a		;; 1299: 32 7a 14    2z.
	sta	L147c		;; 129c: 32 7c 14    2|.
	sta	L147e		;; 129f: 32 7e 14    2~.
	sta	L13c7		;; 12a2: 32 c7 13    2..
	sta	L14d5		;; 12a5: 32 d5 14    2..
	sta	L14de		;; 12a8: 32 de 14    2..
	inx	h		;; 12ab: 23          #
	mov	a,m		;; 12ac: 7e          ~
	inx	h		;; 12ad: 23          #
	inx	h		;; 12ae: 23          #
	sta	L133b		;; 12af: 32 3b 13    2;.
	sta	L0b11		;; 12b2: 32 11 0b    2..
	sta	L1545		;; 12b5: 32 45 15    2E.
	sta	L1367		;; 12b8: 32 67 13    2g.
	sta	L13cd		;; 12bb: 32 cd 13    2..
	sta	L14e4		;; 12be: 32 e4 14    2..
	inx	h		;; 12c1: 23          #
	mov	a,m		;; 12c2: 7e          ~
	sta	L1313		;; 12c3: 32 13 13    2..
	sta	L14dc		;; 12c6: 32 dc 14    2..
	inx	h		;; 12c9: 23          #
	mov	a,m		;; 12ca: 7e          ~
	sta	L130e		;; 12cb: 32 0e 13    2..
	sta	L14d7		;; 12ce: 32 d7 14    2..
	inx	h		;; 12d1: 23          #
	mov	a,m		;; 12d2: 7e          ~
	inx	h		;; 12d3: 23          #
	sta	L0b0c		;; 12d4: 32 0c 0b    2..
	sta	L132c		;; 12d7: 32 2c 13    2,.
	sta	L1542		;; 12da: 32 42 15    2B.
	sta	L1355		;; 12dd: 32 55 13    2U.
	sta	L13c9		;; 12e0: 32 c9 13    2..
	sta	L14e0		;; 12e3: 32 e0 14    2..
	inx	h		;; 12e6: 23          #
	inx	h		;; 12e7: 23          #
	mov	a,m		;; 12e8: 7e          ~
	sta	L13a3		;; 12e9: 32 a3 13    2..
	adi	030h		;; 12ec: c6 30       .0
	sta	L1cee		;; 12ee: 32 ee 1c    2..
	mvi	a,0eah		;; 12f1: 3e ea       >.
	sta	L150b		;; 12f3: 32 0b 15    2..
	inx	h		;; 12f6: 23          #
	mov	a,m		;; 12f7: 7e          ~
	ana	a		;; 12f8: a7          .
	jnz	L1301		;; 12f9: c2 01 13    ...
	mvi	a,06ah		;; 12fc: 3e 6a       >j
	sta	L150b		;; 12fe: 32 0b 15    2..
L1301:	pop	psw		;; 1301: f1          .
	ret			;; 1302: c9          .

; get network vector block...
L1303:	pop	h		;; 1303: e1          .
	lxi	h,L1df3		;; 1304: 21 f3 1d    ...
	ret			;; 1307: c9          .

L1308:	inx	h		;; 1308: 23          #
	mov	a,m		;; 1309: 7e          ~
L130a:	push	psw		;; 130a: f5          .
L130b:	in	011h		;; 130b: db 11       ..
L130c	equ	$-1
	ani	001h		;; 130d: e6 01       ..
L130e	equ	$-1
	jrz	L130b		;; 130f: 28 fa       (.
	pop	psw		;; 1311: f1          .
	out	010h		;; 1312: d3 10       ..
L1313	equ	$-1
L1314:	push	d		;; 1314: d5          .
	lda	L1448		;; 1315: 3a 48 14    :H.
	ori	0b0h		;; 1318: f6 b0       ..
	mov	e,a		;; 131a: 5f          _
	jmp	L1329		;; 131b: c3 29 13    .).

L131e:	push	d		;; 131e: d5          .
	lda	L1448		;; 131f: 3a 48 14    :H.
	mvi	d,000h		;; 1322: 16 00       ..
	ani	020h		;; 1324: e6 20       . 
	ori	001h		;; 1326: f6 01       ..
	mov	e,a		;; 1328: 5f          _
L1329:	in	011h		;; 1329: db 11       ..
L132a	equ	$-1
	ani	002h		;; 132b: e6 02       ..
L132c	equ	$-1
	jrnz	L133a		;; 132d: 20 0b        .
	call	L0302		;; 132f: cd 02 03    ...
	dcx	d		;; 1332: 1b          .
	mov	a,e		;; 1333: 7b          {
	ana	a		;; 1334: a7          .
	jrnz	L1329		;; 1335: 20 f2        .
	pop	d		;; 1337: d1          .
	stc			;; 1338: 37          7
	ret			;; 1339: c9          .

L133a:	in	010h		;; 133a: db 10       ..
L133b	equ	$-1
	pop	d		;; 133c: d1          .
	stc			;; 133d: 37          7
	cmc			;; 133e: 3f          ?
	ret			;; 133f: c9          .

L1340:	pop	psw		;; 1340: f1          .
L1341:	mvi	a,0ffh		;; 1341: 3e ff       >.
	sta	L137a		;; 1343: 32 7a 13    2z.
L1346:	lda	L137a		;; 1346: 3a 7a 13    :z.
	inr	a		;; 1349: 3c          <
	sta	L137a		;; 134a: 32 7a 13    2z.
	lxi	d,L01ff		;; 134d: 11 ff 01    ...
L134e	equ	$-2
L1350:	mvi	c,004h		;; 1350: 0e 04       ..
L1352:	in	011h		;; 1352: db 11       ..
L1353	equ	$-1
	ani	002h		;; 1354: e6 02       ..
L1355	equ	$-1
	jnz	L1366		;; 1356: c2 66 13    .f.
	dcr	c		;; 1359: 0d          .
	jnz	L1352		;; 135a: c2 52 13    .R.
	dcx	d		;; 135d: 1b          .
	mov	a,d		;; 135e: 7a          z
	ana	a		;; 135f: a7          .
	jnz	L1350		;; 1360: c2 50 13    .P.
	jmp	L13e9		;; 1363: c3 e9 13    ...

L1366:	in	010h		;; 1366: db 10       ..
L1367	equ	$-1
	cpi	002h		;; 1368: fe 02       ..
	jz	L1346		;; 136a: ca 46 13    .F.
	push	psw		;; 136d: f5          .
	lda	L137a		;; 136e: 3a 7a 13    :z.
	cpi	003h		;; 1371: fe 03       ..
	jnc	L137b		;; 1373: d2 7b 13    .{.
	pop	psw		;; 1376: f1          .
	jmp	L1341		;; 1377: c3 41 13    .A.

L137a:	db	0edh
L137b:	pop	psw		;; 137b: f1          .
L137c:	cpi	040h		;; 137c: fe 40       .@
	jz	L1399		;; 137e: ca 99 13    ...
	cpi	080h		;; 1381: fe 80       ..
	jz	L138d		;; 1383: ca 8d 13    ...
	ana	a		;; 1386: a7          .
	jnz	L1341		;; 1387: c2 41 13    .A.
	jmp	L1399		;; 138a: c3 99 13    ...

L138d:	lxi	h,L2136		;; 138d: 21 36 21    .6.
	mov	m,a		;; 1390: 77          w
	inx	h		;; 1391: 23          #
	call	L1314		;; 1392: cd 14 13    ...
	mov	m,a		;; 1395: 77          w
	jmp	L13a7		;; 1396: c3 a7 13    ...

L1399:	lxi	h,L2136		;; 1399: 21 36 21    .6.
	mov	m,a		;; 139c: 77          w
	inx	h		;; 139d: 23          #
	call	L1314		;; 139e: cd 14 13    ...
	mov	m,a		;; 13a1: 77          w
	cpi	001h		;; 13a2: fe 01       ..
L13a3	equ	$-1
	jnz	L13e4		;; 13a4: c2 e4 13    ...
L13a7:	inx	h		;; 13a7: 23          #
	inx	h		;; 13a8: 23          #
	call	L13ee		;; 13a9: cd ee 13    ...
	call	L13ee		;; 13ac: cd ee 13    ...
	inx	h		;; 13af: 23          #
	call	L13ee		;; 13b0: cd ee 13    ...
	lda	L2136		;; 13b3: 3a 36 21    :6.
	ani	040h		;; 13b6: e6 40       .@
	jnz	L13dc		;; 13b8: c2 dc 13    ...
	call	L13ee		;; 13bb: cd ee 13    ...
	mov	c,a		;; 13be: 4f          O
	inx	h		;; 13bf: 23          #
	inr	c		;; 13c0: 0c          .
	mvi	e,000h		;; 13c1: 1e 00       ..
L13c3:	dcr	c		;; 13c3: 0d          .
	jrz	L13d5		;; 13c4: 28 0f       (.
L13c6:	in	006h		;; 13c6: db 06       ..
L13c7	equ	$-1
	ani	001h		;; 13c8: e6 01       ..
L13c9	equ	$-1
	jrz	L13c6		;; 13ca: 28 fa       (.
	in	004h		;; 13cc: db 04       ..
L13cd	equ	$-1
	inx	h		;; 13ce: 23          #
	mov	m,a		;; 13cf: 77          w
	add	e		;; 13d0: 83          .
	mov	e,a		;; 13d1: 5f          _
	jmp	L13c3		;; 13d2: c3 c3 13    ...

L13d5:	call	L13ee		;; 13d5: cd ee 13    ...
	cmp	e		;; 13d8: bb          .
	jnz	L13e4		;; 13d9: c2 e4 13    ...
L13dc:	lxi	h,L2136		;; 13dc: 21 36 21    .6.
	xra	a		;; 13df: af          .
L13e0:	sta	L2135		;; 13e0: 32 35 21    25.
	ret			;; 13e3: c9          .

L13e4:	mvi	a,001h		;; 13e4: 3e 01       >.
	jmp	L13e0		;; 13e6: c3 e0 13    ...

L13e9:	mvi	a,002h		;; 13e9: 3e 02       >.
	jmp	L13e0		;; 13eb: c3 e0 13    ...

L13ee:	call	L1314		;; 13ee: cd 14 13    ...
	inx	h		;; 13f1: 23          #
	mov	m,a		;; 13f2: 77          w
	ret			;; 13f3: c9          .

L13f4:	push	h		;; 13f4: e5          .
	push	d		;; 13f5: d5          .
	push	b		;; 13f6: c5          .
	lda	L2136+4		;; 13f7: 3a 3a 21    ::.
	sta	L1532		;; 13fa: 32 32 15    22.
	adi	'0'		;; 13fd: c6 30       .0
	sta	L1443		;; 13ff: 32 43 14    2C.
	lxi	d,L1433		;; 1402: 11 33 14    .3.
	mvi	c,009h		;; 1405: 0e 09       ..
	call	L0c5e		;; 1407: cd 5e 0c    .^.
	lda	L2136+8		;; 140a: 3a 3e 21    :>.
	mov	c,a		;; 140d: 4f          O
	lxi	h,L2136+10	;; 140e: 21 40 21    .@.
L1411:	dcr	c		;; 1411: 0d          .
	jm	L1424		;; 1412: fa 24 14    .$.
	push	b		;; 1415: c5          .
	mvi	c,002h		;; 1416: 0e 02       ..
	mov	a,m		;; 1418: 7e          ~
	mov	e,a		;; 1419: 5f          _
	push	h		;; 141a: e5          .
	call	L0c5e		;; 141b: cd 5e 0c    .^.
	pop	h		;; 141e: e1          .
	inx	h		;; 141f: 23          #
	pop	b		;; 1420: c1          .
	jmp	L1411		;; 1421: c3 11 14    ...

L1424:	call	L1cc0		;; 1424: cd c0 1c    ...
	lxi	h,L1531		;; 1427: 21 31 15    .1.
	call	L0f26		;; 142a: cd 26 0f    .&.
	pop	b		;; 142d: c1          .
	pop	d		;; 142e: d1          .
	pop	h		;; 142f: e1          .
	jmp	L0b66		;; 1430: c3 66 0b    .f.

L1433:	db	';;Msg from node '
L1443:	db	'x -',7,'$'
L1448:	db	0aah
L1449:	call	L14ec		;; 1449: cd ec 14    ...
	push	d		;; 144c: d5          .
	lda	L1448		;; 144d: 3a 48 14    :H.
	ani	03fh		;; 1450: e6 3f       .?
	inr	a		;; 1452: 3c          <
	mov	d,a		;; 1453: 57          W
L1454:	dcx	d		;; 1454: 1b          .
	call	L0302		;; 1455: cd 02 03    ...
	mov	a,d		;; 1458: 7a          z
	ana	a		;; 1459: a7          .
	jrz	L1463		;; 145a: 28 07       (.
	mvi	a,032h		;; 145c: 3e 32       >2
L145e:	dcr	a		;; 145e: 3d          =
	jrnz	L145e		;; 145f: 20 fd        .
	jr	L1454		;; 1461: 18 f1       ..

L1463:	pop	d		;; 1463: d1          .
	mvi	a,001h		;; 1464: 3e 01       >.
	push	psw		;; 1466: f5          .
L1467:	lda	L1cee		;; 1467: 3a ee 1c    :..
	cpi	030h		;; 146a: fe 30       .0
	jz	L150f		;; 146c: ca 0f 15    ...
	call	L153f		;; 146f: cd 3f 15    .?.
L1472:	call	L131e		;; 1472: cd 1e 13    ...
	jrnc	L1467		;; 1475: 30 f0       0.
	mvi	a,010h		;; 1477: 3e 10       >.
	out	006h		;; 1479: d3 06       ..
L147a	equ	$-1
	out	006h		;; 147b: d3 06       ..
L147c	equ	$-1
	in	006h		;; 147d: db 06       ..
L147e	equ	$-1
	ani	008h		;; 147f: e6 08       ..
	jz	L1472		;; 1481: ca 72 14    .r.
	pop	psw		;; 1484: f1          .
	mvi	a,002h		;; 1485: 3e 02       >.
	mvi	b,012h		;; 1487: 06 12       ..
L1489:	dcr	b		;; 1489: 05          .
	jm	L149b		;; 148a: fa 9b 14    ...
	call	L130a		;; 148d: cd 0a 13    ...
	jc	L150f		;; 1490: da 0f 15    ...
	cpi	002h		;; 1493: fe 02       ..
	jnz	L1449		;; 1495: c2 49 14    .I.
	jmp	L1489		;; 1498: c3 89 14    ...

L149b:	mov	a,m		;; 149b: 7e          ~
	sta	L1530		;; 149c: 32 30 15    20.
	call	L130a		;; 149f: cd 0a 13    ...
	call	L1308		;; 14a2: cd 08 13    ...
	inx	h		;; 14a5: 23          #
	inx	h		;; 14a6: 23          #
	inx	h		;; 14a7: 23          #
	mov	a,m		;; 14a8: 7e          ~
	ana	a		;; 14a9: a7          .
	jrnz	L14af		;; 14aa: 20 03        .
	lda	L13a3		;; 14ac: 3a a3 13    :..
L14af:	call	L130a		;; 14af: cd 0a 13    ...
	lda	L13a3		;; 14b2: 3a a3 13    :..
	call	L130a		;; 14b5: cd 0a 13    ...
	inx	h		;; 14b8: 23          #
	inx	h		;; 14b9: 23          #
	call	L1308		;; 14ba: cd 08 13    ...
	lda	L1530		;; 14bd: 3a 30 15    :0.
	ani	040h		;; 14c0: e6 40       .@
	jnz	L14ec		;; 14c2: c2 ec 14    ...
	call	L1308		;; 14c5: cd 08 13    ...
	mov	c,a		;; 14c8: 4f          O
	inx	h		;; 14c9: 23          #
	inr	c		;; 14ca: 0c          .
	mvi	e,000h		;; 14cb: 1e 00       ..
L14cd:	dcr	c		;; 14cd: 0d          .
	jrz	L14e8		;; 14ce: 28 18       (.
	inx	h		;; 14d0: 23          #
	mov	a,m		;; 14d1: 7e          ~
	add	e		;; 14d2: 83          .
	mov	e,a		;; 14d3: 5f          _
L14d4:	in	006h		;; 14d4: db 06       ..
L14d5	equ	$-1
	ani	004h		;; 14d6: e6 04       ..
L14d7	equ	$-1
	jrz	L14d4		;; 14d8: 28 fa       (.
	mov	a,m		;; 14da: 7e          ~
	out	004h		;; 14db: d3 04       ..
L14dc	equ	$-1
L14dd:	in	006h		;; 14dd: db 06       ..
L14de	equ	$-1
	ani	001h		;; 14df: e6 01       ..
L14e0	equ	$-1
	jrz	L14dd		;; 14e1: 28 fa       (.
	in	004h		;; 14e3: db 04       ..
L14e4	equ	$-1
	jmp	L14cd		;; 14e5: c3 cd 14    ...

L14e8:	mov	a,e		;; 14e8: 7b          {
	call	L130a		;; 14e9: cd 0a 13    ...
L14ec:	in	006h		;; 14ec: db 06       ..
L14ed	equ	$-1
	ani	004h		;; 14ee: e6 04       ..
	jrz	L14ec		;; 14f0: 28 fa       (.
	call	L14f8		;; 14f2: cd f8 14    ...
	call	L14f8		;; 14f5: cd f8 14    ...
L14f8:	mvi	a,005h		;; 14f8: 3e 05       >.
	out	006h		;; 14fa: d3 06       ..
L14fb	equ	$-1
	mvi	a,06ah		;; 14fc: 3e 6a       >j
	out	006h		;; 14fe: d3 06       ..
L14ff	equ	$-1
	mvi	a,003h		;; 1500: 3e 03       >.
L1502:	dcr	a		;; 1502: 3d          =
	jnz	L1502		;; 1503: c2 02 15    ...
	mvi	a,005h		;; 1506: 3e 05       >.
	out	006h		;; 1508: d3 06       ..
L1509	equ	$-1
	mvi	a,0eah		;; 150a: 3e ea       >.
L150b	equ	$-1
	out	006h		;; 150c: d3 06       ..
L150d	equ	$-1
	ret			;; 150e: c9          .

L150f:	call	L14ec		;; 150f: cd ec 14    ...
	lxi	d,L151e		;; 1512: 11 1e 15    ...
	call	L1bfd		;; 1515: cd fd 1b    ...
	call	L18b4		;; 1518: cd b4 18    ...
	jmp	L033e		;; 151b: c3 3e 03    .>.

L151e:	db	'?NET NOT READY',0dh,0ah,7,'$'
L1530:	db	0
L1531:	db	'@'
L1532:	db	0,0,0,0,0,0,'g>',0ffh,'=',0c2h,';',15h
L153f:	in	011h		;; 153f: db 11       ..
L1540	equ	$-1
	ani	002h		;; 1541: e6 02       ..
L1542	equ	$-1
	rz			;; 1543: c8          .
	in	010h		;; 1544: db 10       ..
L1545	equ	$-1
	jmp	L153f		;; 1546: c3 3f 15    .?.

L1549:	pop	psw		;; 1549: f1          .
	lspd	L2022		;; 154a: ed 7b 22 20 .{" 
	push	psw		;; 154e: f5          .
	push	b		;; 154f: c5          .
	push	d		;; 1550: d5          .
	push	h		;; 1551: e5          .
	sspd	L1d54		;; 1552: ed 73 54 1d .sT.
	lxi	sp,L20dc	;; 1556: 31 dc 20    1. 
	mvi	a,031h		;; 1559: 3e 31       >1
	sta	L1d56		;; 155b: 32 56 1d    2V.
	lxi	h,00080h	;; 155e: 21 80 00    ...
	lxi	d,L1f6e		;; 1561: 11 6e 1f    .n.
	lxi	b,00051h	;; 1564: 01 51 00    .Q.
	ldir			;; 1567: ed b0       ..
	jmp	L03fd		;; 1569: c3 fd 03    ...

L156c:	lxi	h,L1d67		;; 156c: 21 67 1d    .g.
	pop	psw		;; 156f: f1          .
	ret			;; 1570: c9          .

L1571:	lxi	h,L203b		;; 1571: 21 3b 20    .; 
	pop	psw		;; 1574: f1          .
	ret			;; 1575: c9          .

L1576:	inx	h		;; 1576: 23          #
	mov	a,m		;; 1577: 7e          ~
	cpi	041h		;; 1578: fe 41       .A
	jrz	L15a7		;; 157a: 28 2b       (+
	cpi	050h		;; 157c: fe 50       .P
	jz	L163f		;; 157e: ca 3f 16    .?.
	cpi	055h		;; 1581: fe 55       .U
	jz	L1656		;; 1583: ca 56 16    .V.
	cpi	054h		;; 1586: fe 54       .T
	jnz	L1777		;; 1588: c2 77 17    .w.
	lxi	h,L1f71		;; 158b: 21 71 1f    .q.
	lxi	d,L15a3		;; 158e: 11 a3 15    ...
	call	L1759		;; 1591: cd 59 17    .Y.
	lxi	d,00080h	;; 1594: 11 80 00    ...
	call	L1be7		;; 1597: cd e7 1b    ...
	call	L1bcc		;; 159a: cd cc 1b    ...
	call	L0100		;; 159d: cd 00 01    ...
	jmp	L033e		;; 15a0: c3 3e 03    .>.

L15a3:	db	'ART '
L15a7:	lxi	h,L1f71		;; 15a7: 21 71 1f    .q.
	lxi	d,L162a		;; 15aa: 11 2a 16    .*.
	call	L1759		;; 15ad: cd 59 17    .Y.
	lxi	h,00000h	;; 15b0: 21 00 00    ...
	lda	0005dh		;; 15b3: 3a 5d 00    :].
	call	L162d		;; 15b6: cd 2d 16    .-.
	lda	0005eh		;; 15b9: 3a 5e 00    :^.
	call	L162d		;; 15bc: cd 2d 16    .-.
	lda	0005fh		;; 15bf: 3a 5f 00    :_.
	call	L162d		;; 15c2: cd 2d 16    .-.
	shld	L202f		;; 15c5: 22 2f 20    "/ 
	lxi	h,0006ch	;; 15c8: 21 6c 00    .l.
	lxi	d,0005ch	;; 15cb: 11 5c 00    .\.
	lxi	b,00010h	;; 15ce: 01 10 00    ...
	ldir			;; 15d1: ed b0       ..
	xra	a		;; 15d3: af          .
	sta	0007ch		;; 15d4: 32 7c 00    2|.
	lxi	h,L0100		;; 15d7: 21 00 01    ...
	shld	L202d		;; 15da: 22 2d 20    "- 
	lxi	d,0005ch	;; 15dd: 11 5c 00    .\.
	mvi	c,013h		;; 15e0: 0e 13       ..
	call	00005h		;; 15e2: cd 05 00    ...
	lxi	d,0005ch	;; 15e5: 11 5c 00    .\.
	mvi	c,016h		;; 15e8: 0e 16       ..
	call	00005h		;; 15ea: cd 05 00    ...
	inr	a		;; 15ed: 3c          <
	jz	L098e		;; 15ee: ca 8e 09    ...
L15f1:	lhld	L202f		;; 15f1: 2a 2f 20    */ 
	mov	a,h		;; 15f4: 7c          |
	ana	a		;; 15f5: a7          .
	jrnz	L15fc		;; 15f6: 20 04        .
	mov	a,l		;; 15f8: 7d          }
	ana	a		;; 15f9: a7          .
	jrz	L161f		;; 15fa: 28 23       (#
L15fc:	dcx	h		;; 15fc: 2b          +
	shld	L202f		;; 15fd: 22 2f 20    "/ 
	lhld	L202d		;; 1600: 2a 2d 20    *- 
	push	h		;; 1603: e5          .
	lxi	d,00080h	;; 1604: 11 80 00    ...
	dad	d		;; 1607: 19          .
	shld	L202d		;; 1608: 22 2d 20    "- 
	pop	d		;; 160b: d1          .
	mvi	c,01ah		;; 160c: 0e 1a       ..
	call	00005h		;; 160e: cd 05 00    ...
	lxi	d,0005ch	;; 1611: 11 5c 00    .\.
	mvi	c,015h		;; 1614: 0e 15       ..
	call	00005h		;; 1616: cd 05 00    ...
	ana	a		;; 1619: a7          .
	jrz	L15f1		;; 161a: 28 d5       (.
	jmp	L098e		;; 161c: c3 8e 09    ...

L161f:	lxi	d,0005ch	;; 161f: 11 5c 00    .\.
	mvi	c,010h		;; 1622: 0e 10       ..
	call	00005h		;; 1624: cd 05 00    ...
	jmp	L033e		;; 1627: c3 3e 03    .>.

L162a:	db	'VE '
L162d:	cpi	020h		;; 162d: fe 20       . 
	rz			;; 162f: c8          .
	push	h		;; 1630: e5          .
	dad	h		;; 1631: 29          )
	dad	h		;; 1632: 29          )
	dad	h		;; 1633: 29          )
	xchg			;; 1634: eb          .
	pop	h		;; 1635: e1          .
	dad	h		;; 1636: 29          )
	dad	d		;; 1637: 19          .
	mvi	d,000h		;; 1638: 16 00       ..
	sui	030h		;; 163a: d6 30       .0
	mov	e,a		;; 163c: 5f          _
	dad	d		;; 163d: 19          .
	ret			;; 163e: c9          .

L163f:	lxi	h,L1f71		;; 163f: 21 71 1f    .q.
	lxi	d,L1650		;; 1642: 11 50 16    .P.
	call	L1759		;; 1645: cd 59 17    .Y.
	lxi	h,L164e		;; 1648: 21 4e 16    .N.
	jmp	L0809		;; 164b: c3 09 08    ...

L164e:	db	'SP'
L1650:	db	'OOL   '
L1656:	lxi	h,L1f71		;; 1656: 21 71 1f    .q.
	lxi	d,L1665		;; 1659: 11 65 16    .e.
	call	L1759		;; 165c: cd 59 17    .Y.
	lxi	h,L166a		;; 165f: 21 6a 16    .j.
	jmp	L0809		;; 1662: c3 09 08    ...

L1665:	db	'BMIT '
L166a:	db	'OSUB    '
L1672:	inx	h		;; 1672: 23          #
	mov	a,m		;; 1673: 7e          ~
	cpi	054h		;; 1674: fe 54       .T
	jrz	L167f		;; 1676: 28 07       (.
	cpi	059h		;; 1678: fe 59       .Y
	jrz	L16bd		;; 167a: 28 41       (A
	jmp	L1777		;; 167c: c3 77 17    .w.

L167f:	lxi	h,L1f71		;; 167f: 21 71 1f    .q.
	lxi	d,L0814		;; 1682: 11 14 08    ...
	call	L1759		;; 1685: cd 59 17    .Y.
	lxi	h,0005dh	;; 1688: 21 5d 00    .].
	mov	a,m		;; 168b: 7e          ~
	cpi	020h		;; 168c: fe 20       . 
	jz	L1ab5		;; 168e: ca b5 1a    ...
	cpi	047h		;; 1691: fe 47       .G
	jrz	L16af		;; 1693: 28 1a       (.
	cpi	04eh		;; 1695: fe 4e       .N
	jrz	L16b3		;; 1697: 28 1a       (.
	cpi	043h		;; 1699: fe 43       .C
	jrz	L16a4		;; 169b: 28 07       (.
	cpi	054h		;; 169d: fe 54       .T
	jrz	L16a8		;; 169f: 28 07       (.
	jmp	L1ac7		;; 16a1: c3 c7 1a    ...

L16a4:	mvi	a,001h		;; 16a4: 3e 01       >.
	jr	L16a9		;; 16a6: 18 01       ..

L16a8:	xra	a		;; 16a8: af          .
L16a9:	sta	L1d63		;; 16a9: 32 63 1d    2c.
	jmp	L039d		;; 16ac: c3 9d 03    ...

L16af:	mvi	a,001h		;; 16af: 3e 01       >.
	jr	L16b4		;; 16b1: 18 01       ..

L16b3:	xra	a		;; 16b3: af          .
L16b4:	sta	L1d62		;; 16b4: 32 62 1d    2b.
	jmp	L039d		;; 16b7: c3 9d 03    ...

L16ba:	db	'PE '
L16bd:	lxi	h,L1f71		;; 16bd: 21 71 1f    .q.
	lxi	d,L16ba		;; 16c0: 11 ba 16    ...
	call	L1759		;; 16c3: cd 59 17    .Y.
	call	L1bcc		;; 16c6: cd cc 1b    ...
	jmp	L0850		;; 16c9: c3 50 08    .P.

L16cc:	db	'SER '
L16d0:	lxi	h,L1f70		;; 16d0: 21 70 1f    .p.
	lxi	d,L16cc		;; 16d3: 11 cc 16    ...
	call	L1759		;; 16d6: cd 59 17    .Y.
	lda	0005dh		;; 16d9: 3a 5d 00    :].
	cpi	020h		;; 16dc: fe 20       . 
	jz	L09c7		;; 16de: ca c7 09    ...
	lda	L1d71		;; 16e1: 3a 71 1d    :q.
	ani	002h		;; 16e4: e6 02       ..
	jz	L18ca		;; 16e6: ca ca 18    ...
	lxi	h,00000h	;; 16e9: 21 00 00    ...
	lda	0005dh		;; 16ec: 3a 5d 00    :].
	call	L162d		;; 16ef: cd 2d 16    .-.
	lda	0005eh		;; 16f2: 3a 5e 00    :^.
	call	L162d		;; 16f5: cd 2d 16    .-.
	mov	a,l		;; 16f8: 7d          }
	ana	a		;; 16f9: a7          .
	jm	L0956		;; 16fa: fa 56 09    .V.
	cpi	010h		;; 16fd: fe 10       ..
	jnc	L0956		;; 16ff: d2 56 09    .V.
	sta	L1d67		;; 1702: 32 67 1d    2g.
	sta	L1d53		;; 1705: 32 53 1d    2S.
	call	L1bcc		;; 1708: cd cc 1b    ...
	call	L04e9		;; 170b: cd e9 04    ...
	jmp	L09c7		;; 170e: c3 c7 09    ...

L1711:	lxi	h,L1f70		;; 1711: 21 70 1f    .p.
	lxi	d,L1720		;; 1714: 11 20 17    . .
	call	L1759		;; 1717: cd 59 17    .Y.
L171a:	lxi	h,L1725		;; 171a: 21 25 17    .%.
	jmp	L0809		;; 171d: c3 09 08    ...

L1720:	db	'HERE '
L1725:	db	'NETUTIL '
L172d:	lxi	h,L1f72		;; 172d: 21 72 1f    .r.
	lxi	d,L1739		;; 1730: 11 39 17    .9.
	call	L1759		;; 1733: cd 59 17    .Y.
	jmp	L171a		;; 1736: c3 1a 17    ...

L1739:	db	'ATE '
L173d:	lxi	h,L1f70		;; 173d: 21 70 1f    .p.
	lxi	d,L174e		;; 1740: 11 4e 17    .N.
	call	L1759		;; 1743: cd 59 17    .Y.
	lxi	h,L174c		;; 1746: 21 4c 17    .L.
	jmp	L0809		;; 1749: c3 09 08    ...

L174c:	db	'OX'
L174e:	db	'SUB   '
	mvi	a,030h		;; 1754: 3e 30       >0
	jmp	L175b		;; 1756: c3 5b 17    .[.

L1759:	mvi	a,031h		;; 1759: 3e 31       >1
L175b:	sta	L176b		;; 175b: 32 6b 17    2k.
L175e:	mov	a,m		;; 175e: 7e          ~
	cpi	030h		;; 175f: fe 30       .0
	rc			;; 1761: d8          .
	mov	b,a		;; 1762: 47          G
	ldax	d		;; 1763: 1a          .
	cmp	b		;; 1764: b8          .
	jrnz	L176c		;; 1765: 20 05        .
	inx	h		;; 1767: 23          #
	inx	d		;; 1768: 13          .
	jr	L175e		;; 1769: 18 f3       ..

L176b:	db	'1'
L176c:	lda	L176b		;; 176c: 3a 6b 17    :k.
	cpi	030h		;; 176f: fe 30       .0
	jz	L1ac7		;; 1771: ca c7 1a    ...
	lxi	sp,L20dc	;; 1774: 31 dc 20    1. 
L1777:	xra	a		;; 1777: af          .
	sta	L1d5b		;; 1778: 32 5b 1d    2[.
	inr	a		;; 177b: 3c          <
	sta	L187a		;; 177c: 32 7a 18    2z.
	jr	L1786		;; 177f: 18 05       ..

L1781:	mvi	a,001h		;; 1781: 3e 01       >.
	sta	L1d5b		;; 1783: 32 5b 1d    2[.
L1786:	lda	L1d67		;; 1786: 3a 67 1d    :g.
	sta	L1d53		;; 1789: 32 53 1d    2S.
	lxi	h,L1ff2		;; 178c: 21 f2 1f    ...
	mvi	a,047h		;; 178f: 3e 47       >G
	cmp	m		;; 1791: be          .
	jrnz	L179f		;; 1792: 20 0b        .
	inx	h		;; 1794: 23          #
	mvi	a,020h		;; 1795: 3e 20       > 
	cmp	m		;; 1797: be          .
	jrnz	L179f		;; 1798: 20 05        .
	mvi	a,0ffh		;; 179a: 3e ff       >.
	sta	L1d53		;; 179c: 32 53 1d    2S.
L179f:	lda	L1d67		;; 179f: 3a 67 1d    :g.
	sta	L1a13		;; 17a2: 32 13 1a    2..
	lda	L1fef		;; 17a5: 3a ef 1f    :..
	ana	a		;; 17a8: a7          .
	jrnz	L17b2		;; 17a9: 20 07        .
	lda	L1d79		;; 17ab: 3a 79 1d    :y.
	inr	a		;; 17ae: 3c          <
	sta	L1fef		;; 17af: 32 ef 1f    2..
L17b2:	lda	L1ff0		;; 17b2: 3a f0 1f    :..
	cpi	020h		;; 17b5: fe 20       . 
	jz	L1ab5		;; 17b7: ca b5 1a    ...
	lda	L0a3b		;; 17ba: 3a 3b 0a    :;.
	ana	a		;; 17bd: a7          .
	jrnz	L17c6		;; 17be: 20 06        .
	lda	L187a		;; 17c0: 3a 7a 18    :z.
	ana	a		;; 17c3: a7          .
	jrnz	L17c9		;; 17c4: 20 03        .
L17c6:	call	L186e		;; 17c6: cd 6e 18    .n.
L17c9:	xra	a		;; 17c9: af          .
	sta	L187a		;; 17ca: 32 7a 18    2z.
	mvi	c,020h		;; 17cd: 0e 20       . 
	mvi	e,0ffh		;; 17cf: 1e ff       ..
	call	L0c5e		;; 17d1: cd 5e 0c    .^.
	sta	L2020		;; 17d4: 32 20 20    2  
	xra	a		;; 17d7: af          .
	sta	L186d		;; 17d8: 32 6d 18    2m.
L17db:	xra	a		;; 17db: af          .
	sta	L1ffb		;; 17dc: 32 fb 1f    2..
	sta	L1ffd		;; 17df: 32 fd 1f    2..
	lxi	h,L1fef		;; 17e2: 21 ef 1f    ...
	lxi	d,L1de3		;; 17e5: 11 e3 1d    ...
	lxi	b,00024h	;; 17e8: 01 24 00    .$.
	ldir			;; 17eb: ed b0       ..
	lxi	d,L1de3		;; 17ed: 11 e3 1d    ...
	call	L1bf7		;; 17f0: cd f7 1b    ...
	inr	a		;; 17f3: 3c          <
	jz	L1853		;; 17f4: ca 53 18    .S.
	xra	a		;; 17f7: af          .
	sta	L1e03		;; 17f8: 32 03 1e    2..
	sta	L1def		;; 17fb: 32 ef 1d    2..
	lxi	h,L0100		;; 17fe: 21 00 01    ...
L1801:	shld	L1878		;; 1801: 22 78 18    "x.
	lded	L1878		;; 1804: ed 5b 78 18 .[x.
	call	L1be7		;; 1808: cd e7 1b    ...
	lda	00007h		;; 180b: 3a 07 00    :..
	dcr	a		;; 180e: 3d          =
	cmp	h		;; 180f: bc          .
	jz	L098e		;; 1810: ca 8e 09    ...
	lhld	L1878		;; 1813: 2a 78 18    *x.
	lxi	d,00080h	;; 1816: 11 80 00    ...
	dad	d		;; 1819: 19          .
	shld	L1878		;; 181a: 22 78 18    "x.
	lxi	d,L1de3		;; 181d: 11 e3 1d    ...
	call	L1bef		;; 1820: cd ef 1b    ...
	ora	a		;; 1823: b7          .
	jrz	L1801		;; 1824: 28 db       (.
	lxi	d,00080h	;; 1826: 11 80 00    ...
	call	L1be7		;; 1829: cd e7 1b    ...
	lda	L1a13		;; 182c: 3a 13 1a    :..
	sta	L1d67		;; 182f: 32 67 1d    2g.
	call	L1bcc		;; 1832: cd cc 1b    ...
	call	L04e9		;; 1835: cd e9 04    ...
	lda	L1d5b		;; 1838: 3a 5b 1d    :[.
	ana	a		;; 183b: a7          .
	jnz	L039d		;; 183c: c2 9d 03    ...
	lda	L1d56		;; 183f: 3a 56 1d    :V.
	cpi	031h		;; 1842: fe 31       .1
	jz	L184d		;; 1844: ca 4d 18    .M.
	lda	L1fef		;; 1847: 3a ef 1f    :..
	sta	L2021		;; 184a: 32 21 20    2. 
L184d:	call	L0100		;; 184d: cd 00 01    ...
	jmp	L033e		;; 1850: c3 3e 03    .>.

L1853:	lda	L186d		;; 1853: 3a 6d 18    :m.
	ana	a		;; 1856: a7          .
	jnz	L187b		;; 1857: c2 7b 18    .{.
	inr	a		;; 185a: 3c          <
	sta	L186d		;; 185b: 32 6d 18    2m.
	mvi	a,001h		;; 185e: 3e 01       >.
	sta	L1fef		;; 1860: 32 ef 1f    2..
	call	L186e		;; 1863: cd 6e 18    .n.
	xra	a		;; 1866: af          .
	sta	L2020		;; 1867: 32 20 20    2  
	jmp	L17db		;; 186a: c3 db 17    ...

L186d:	db	0
L186e:	xra	a		;; 186e: af          .
	sta	L1d67		;; 186f: 32 67 1d    2g.
	call	L1bcc		;; 1872: cd cc 1b    ...
	jmp	L04e9		;; 1875: c3 e9 04    ...

L1878:	db	0,0
L187a:	db	0
L187b:	lda	L1a13		;; 187b: 3a 13 1a    :..
	sta	L1d67		;; 187e: 32 67 1d    2g.
	call	L1bcc		;; 1881: cd cc 1b    ...
	call	L04e9		;; 1884: cd e9 04    ...
	mvi	a,03fh		;; 1887: 3e 3f       >?
	sta	L1fef		;; 1889: 32 ef 1f    2..
	sta	L1ff8		;; 188c: 32 f8 1f    2..
	mvi	a,024h		;; 188f: 3e 24       >$
	sta	L1ff9		;; 1891: 32 f9 1f    2..
	lxi	d,L1fef		;; 1894: 11 ef 1f    ...
	call	L1bfd		;; 1897: cd fd 1b    ...
	call	L1cc0		;; 189a: cd c0 1c    ...
	mvi	a,001h		;; 189d: 3e 01       >.
	sta	L1fef		;; 189f: 32 ef 1f    2..
	mvi	a,043h		;; 18a2: 3e 43       >C
	sta	L1ff8		;; 18a4: 32 f8 1f    2..
	mvi	a,04fh		;; 18a7: 3e 4f       >O
	sta	L1ff9		;; 18a9: 32 f9 1f    2..
	jmp	L033e		;; 18ac: c3 3e 03    .>.

L18af:	call	L18b4		;; 18af: cd b4 18    ...
	jr	L18c7		;; 18b2: 18 13       ..

L18b4:	xra	a		;; 18b4: af          .
	sta	L1e9d		;; 18b5: 32 9d 1e    2..
	inr	a		;; 18b8: 3c          <
	sta	L1e9c		;; 18b9: 32 9c 1e    2..
	xra	a		;; 18bc: af          .
	call	L04ec		;; 18bd: cd ec 04    ...
	sta	L1d79		;; 18c0: 32 79 1d    2y.
	sta	L1d78		;; 18c3: 32 78 1d    2x.
	ret			;; 18c6: c9          .

L18c7:	lxi	sp,L20dc	;; 18c7: 31 dc 20    1. 
L18ca:	lxi	d,L18d0		;; 18ca: 11 d0 18    ...
	jmp	L0714		;; 18cd: c3 14 07    ...

L18d0:	db	'?Not privleged$'
L18df:	lda	L1d71		;; 18df: 3a 71 1d    :q.
	ani	001h		;; 18e2: e6 01       ..
	rz			;; 18e4: c8          .
	lda	L1d67		;; 18e5: 3a 67 1d    :g.
	adi	030h		;; 18e8: c6 30       .0
	sta	L1916		;; 18ea: 32 16 19    2..
	mvi	e,05bh		;; 18ed: 1e 5b       .[
	mvi	c,002h		;; 18ef: 0e 02       ..
	call	L0c5e		;; 18f1: cd 5e 0c    .^.
	lda	L1916		;; 18f4: 3a 16 19    :..
	cpi	03ah		;; 18f7: fe 3a       .:
	jrc	L1907		;; 18f9: 38 0c       8.
	sui	00ah		;; 18fb: d6 0a       ..
	sta	L1916		;; 18fd: 32 16 19    2..
	mvi	e,031h		;; 1900: 1e 31       .1
	mvi	c,002h		;; 1902: 0e 02       ..
	call	L0c5e		;; 1904: cd 5e 0c    .^.
L1907:	lxi	d,L1916		;; 1907: 11 16 19    ...
	call	L1bfd		;; 190a: cd fd 1b    ...
	lxi	d,L1d68		;; 190d: 11 68 1d    .h.
	call	L1bfd		;; 1910: cd fd 1b    ...
	jmp	L1cc0		;; 1913: c3 c0 1c    ...

L1916:	nop			;; 1916: 00          .
	mov	e,l		;; 1917: 5d          ]
	jrnz	L193a		;; 1918: 20 20         
	mov	d,l		;; 191a: 55          U
	mov	m,e		;; 191b: 73          s
	mov	h,l		;; 191c: 65          e
	mov	m,d		;; 191d: 72          r
	lda	L2420		;; 191e: 3a 20 24    : $
L1921:	push	b		;; 1921: c5          .
	push	d		;; 1922: d5          .
	push	h		;; 1923: e5          .
	call	L1d7c		;; 1924: cd 7c 1d    .|.
	inr	a		;; 1927: 3c          <
	jrz	L1930		;; 1928: 28 06       (.
L192a:	pop	h		;; 192a: e1          .
	pop	d		;; 192b: d1          .
	pop	b		;; 192c: c1          .
	jmp	L0b02		;; 192d: c3 02 0b    ...

L1930:	lda	L1a6d		;; 1930: 3a 6d 1a    :m.
	ana	a		;; 1933: a7          .
	jnz	L19cd		;; 1934: c2 cd 19    ...
	lxi	h,L2047		;; 1937: 21 47 20    .G 
L193a:	lxi	d,L2037		;; 193a: 11 37 20    .7 
	lxi	b,00004h	;; 193d: 01 04 00    ...
	ldir			;; 1940: ed b0       ..
	lda	L2047		;; 1942: 3a 47 20    :G 
	push	psw		;; 1945: f5          .
	ani	0f0h		;; 1946: e6 f0       ..
	sta	L2035		;; 1948: 32 35 20    25 
	jrz	L1959		;; 194b: 28 0c       (.
	sta	L1d5e		;; 194d: 32 5e 1d    2^.
	pop	psw		;; 1950: f1          .
	ani	00fh		;; 1951: e6 0f       ..
	sta	L2047		;; 1953: 32 47 20    2G 
	jmp	L192a		;; 1956: c3 2a 19    .*.

L1959:	pop	psw		;; 1959: f1          .
	lda	L2048		;; 195a: 3a 48 20    :H 
	sta	L2034		;; 195d: 32 34 20    24 
	mov	e,a		;; 1960: 5f          _
	call	L1bd4		;; 1961: cd d4 1b    ...
	lda	L2047		;; 1964: 3a 47 20    :G 
	ani	00fh		;; 1967: e6 0f       ..
	sta	L2036		;; 1969: 32 36 20    26 
	lda	L2049		;; 196c: 3a 49 20    :I 
	sta	L1eb8		;; 196f: 32 b8 1e    2..
	lda	L204a		;; 1972: 3a 4a 20    :J 
	sta	L1eb9		;; 1975: 32 b9 1e    2..
L1978:	xra	a		;; 1978: af          .
	sta	L2047		;; 1979: 32 47 20    2G 
	sta	L2048		;; 197c: 32 48 20    2H 
	sta	L2049		;; 197f: 32 49 20    2I 
	sta	L204a		;; 1982: 32 4a 20    2J 
	lxi	d,L203b		;; 1985: 11 3b 20    .; 
	mvi	c,00fh		;; 1988: 0e 0f       ..
	call	L1a14		;; 198a: cd 14 1a    ...
	call	L1bcc		;; 198d: cd cc 1b    ...
	mvi	a,001h		;; 1990: 3e 01       >.
	sta	L1a6d		;; 1992: 32 6d 1a    2m.
	xra	a		;; 1995: af          .
	sta	L205b		;; 1996: 32 5b 20    2[ 
	lded	L1d57		;; 1999: ed 5b 57 1d .[W.
	sded	L1d59		;; 199d: ed 53 59 1d .SY.
L19a1:	lda	L203b		;; 19a1: 3a 3b 20    :; 
	ana	a		;; 19a4: a7          .
	jz	L1a1d		;; 19a5: ca 1d 1a    ...
	lxi	d,L1e18		;; 19a8: 11 18 1e    ...
	mvi	c,01ah		;; 19ab: 0e 1a       ..
	call	L1a14		;; 19ad: cd 14 1a    ...
	lda	L2034		;; 19b0: 3a 34 20    :4 
	mov	e,a		;; 19b3: 5f          _
	call	L1bd4		;; 19b4: cd d4 1b    ...
	lxi	d,L203b		;; 19b7: 11 3b 20    .; 
	mvi	c,014h		;; 19ba: 0e 14       ..
	call	L1a14		;; 19bc: cd 14 1a    ...
	ana	a		;; 19bf: a7          .
	jnz	L1a1d		;; 19c0: c2 1d 1a    ...
	call	L1bcc		;; 19c3: cd cc 1b    ...
	lxi	h,L1e18		;; 19c6: 21 18 1e    ...
	mvi	c,080h		;; 19c9: 0e 80       ..
	jr	L19dc		;; 19cb: 18 0f       ..

L19cd:	lded	L1d57		;; 19cd: ed 5b 57 1d .[W.
	sded	L1d59		;; 19d1: ed 53 59 1d .SY.
	lhld	L1a6b		;; 19d5: 2a 6b 1a    *k.
	lda	L1a6a		;; 19d8: 3a 6a 1a    :j.
	mov	c,a		;; 19db: 4f          O
L19dc:	mov	a,m		;; 19dc: 7e          ~
	cpi	01ah		;; 19dd: fe 1a       ..
	jrnz	L19e9		;; 19df: 20 08        .
	inx	h		;; 19e1: 23          #
	mov	a,m		;; 19e2: 7e          ~
	cpi	01ah		;; 19e3: fe 1a       ..
	jrz	L1a1d		;; 19e5: 28 36       (6
	dcx	h		;; 19e7: 2b          +
	mov	a,m		;; 19e8: 7e          ~
L19e9:	mov	e,a		;; 19e9: 5f          _
	push	h		;; 19ea: e5          .
	push	b		;; 19eb: c5          .
	mvi	c,005h		;; 19ec: 0e 05       ..
	call	L1a14		;; 19ee: cd 14 1a    ...
	pop	b		;; 19f1: c1          .
	pop	h		;; 19f2: e1          .
	inx	h		;; 19f3: 23          #
	dcr	c		;; 19f4: 0d          .
	jz	L19a1		;; 19f5: ca a1 19    ...
	shld	L1a6b		;; 19f8: 22 6b 1a    "k.
	mov	a,c		;; 19fb: 79          y
	sta	L1a6a		;; 19fc: 32 6a 1a    2j.
L19ff:	lded	L1d59		;; 19ff: ed 5b 59 1d .[Y.
	sded	L1d57		;; 1a03: ed 53 57 1d .SW.
	mvi	c,01ah		;; 1a07: 0e 1a       ..
	call	L1a14		;; 1a09: cd 14 1a    ...
	call	L1bcc		;; 1a0c: cd cc 1b    ...
	jmp	L192a		;; 1a0f: c3 2a 19    .*.

	db	0
L1a13:	db	0
L1a14:	push	psw		;; 1a14: f5          .
	mvi	a,001h		;; 1a15: 3e 01       >.
	sta	L0da3		;; 1a17: 32 a3 0d    2..
	jmp	L0b66		;; 1a1a: c3 66 0b    .f.

L1a1d:	mvi	e,00ch		;; 1a1d: 1e 0c       ..
	mvi	c,005h		;; 1a1f: 0e 05       ..
	call	L1a14		;; 1a21: cd 14 1a    ...
	lda	L2036		;; 1a24: 3a 36 20    :6 
	dcr	a		;; 1a27: 3d          =
	sta	L2036		;; 1a28: 32 36 20    26 
	jnz	L1978		;; 1a2b: c2 78 19    .x.
	mvi	a,020h		;; 1a2e: 3e 20       > 
	sta	L203c		;; 1a30: 32 3c 20    2< 
	xra	a		;; 1a33: af          .
	sta	L1a6d		;; 1a34: 32 6d 1a    2m.
	lda	L2060		;; 1a37: 3a 60 20    :` 
	cpi	020h		;; 1a3a: fe 20       . 
	jz	L19ff		;; 1a3c: ca ff 19    ...
	lxi	h,L205f		;; 1a3f: 21 5f 20    ._ 
	lxi	d,L203b		;; 1a42: 11 3b 20    .; 
	lxi	b,00024h	;; 1a45: 01 24 00    .$.
	ldir			;; 1a48: ed b0       ..
	mvi	a,020h		;; 1a4a: 3e 20       > 
	sta	L2060		;; 1a4c: 32 60 20    2` 
	lda	L2084		;; 1a4f: 3a 84 20    :. 
	cpi	020h		;; 1a52: fe 20       . 
	jz	L19ff		;; 1a54: ca ff 19    ...
	lxi	h,L2083		;; 1a57: 21 83 20    .. 
	lxi	d,L205f		;; 1a5a: 11 5f 20    ._ 
	lxi	b,00010h	;; 1a5d: 01 10 00    ...
	ldir			;; 1a60: ed b0       ..
	mvi	a,020h		;; 1a62: 3e 20       > 
	sta	L2084		;; 1a64: 32 84 20    2. 
	jmp	L19ff		;; 1a67: c3 ff 19    ...

L1a6a:	db	0
L1a6b:	db	0,0
L1a6d:	db	0
L1a6e:	cpi	020h		;; 1a6e: fe 20       . 
	jrc	L1a85		;; 1a70: 38 13       8.
	mvi	a,03fh		;; 1a72: 3e 3f       >?
	sta	L1f6e		;; 1a74: 32 6e 1f    2n.
	sta	L1f70		;; 1a77: 32 70 1f    2p.
	mvi	a,024h		;; 1a7a: 3e 24       >$
	sta	L1f71		;; 1a7c: 32 71 1f    2q.
L1a7f:	lxi	d,L1f6e		;; 1a7f: 11 6e 1f    .n.
	jmp	L0714		;; 1a82: c3 14 07    ...

L1a85:	cpi	01ah		;; 1a85: fe 1a       ..
	jz	L1b4f		;; 1a87: ca 4f 1b    .O.
	mvi	a,03fh		;; 1a8a: 3e 3f       >?
	sta	L1f6e		;; 1a8c: 32 6e 1f    2n.
	sta	L1f71		;; 1a8f: 32 71 1f    2q.
	lda	L1f6f		;; 1a92: 3a 6f 1f    :o.
	adi	040h		;; 1a95: c6 40       .@
	sta	L1f70		;; 1a97: 32 70 1f    2p.
	mvi	a,05eh		;; 1a9a: 3e 5e       >^
	sta	L1f6f		;; 1a9c: 32 6f 1f    2o.
	mvi	a,024h		;; 1a9f: 3e 24       >$
	sta	L1f72		;; 1aa1: 32 72 1f    2r.
	jr	L1a7f		;; 1aa4: 18 d9       ..

	lxi	d,L1d3d		;; 1aa6: 11 3d 1d    .=.
	call	L1bfd		;; 1aa9: cd fd 1b    ...
	lxi	h,0005ch	;; 1aac: 21 5c 00    .\.
	call	L1afe		;; 1aaf: cd fe 1a    ...
	jmp	L039d		;; 1ab2: c3 9d 03    ...

L1ab5:	lxi	d,L1d2f		;; 1ab5: 11 2f 1d    ./.
	jmp	L0714		;; 1ab8: c3 14 07    ...

	lxi	d,L1d1a		;; 1abb: 11 1a 1d    ...
	call	L1bfd		;; 1abe: cd fd 1b    ...
	call	L1afe		;; 1ac1: cd fe 1a    ...
	jmp	L039d		;; 1ac4: c3 9d 03    ...

L1ac7:	mvi	e,03fh		;; 1ac7: 1e 3f       .?
	call	L1b5f		;; 1ac9: cd 5f 1b    ._.
	lxi	h,00081h	;; 1acc: 21 81 00    ...
L1acf:	mov	a,m		;; 1acf: 7e          ~
	ana	a		;; 1ad0: a7          .
	jrz	L1ada		;; 1ad1: 28 07       (.
	mov	e,a		;; 1ad3: 5f          _
	call	L1b5f		;; 1ad4: cd 5f 1b    ._.
	inx	h		;; 1ad7: 23          #
	jr	L1acf		;; 1ad8: 18 f5       ..

L1ada:	mvi	e,03fh		;; 1ada: 1e 3f       .?
	call	L1b5f		;; 1adc: cd 5f 1b    ._.
	jmp	L039d		;; 1adf: c3 9d 03    ...

	push	h		;; 1ae2: e5          .
L1ae3:	mov	a,m		;; 1ae3: 7e          ~
	cpi	020h		;; 1ae4: fe 20       . 
	jrz	L1aef		;; 1ae6: 28 07       (.
	mov	e,a		;; 1ae8: 5f          _
	call	L1b5f		;; 1ae9: cd 5f 1b    ._.
	inx	h		;; 1aec: 23          #
	jr	L1ae3		;; 1aed: 18 f4       ..

L1aef:	mvi	e,03ah		;; 1aef: 1e 3a       .:
	call	L1b5f		;; 1af1: cd 5f 1b    ._.
	mvi	e,020h		;; 1af4: 1e 20       . 
	call	L1b5f		;; 1af6: cd 5f 1b    ._.
	lxi	h,0005ch	;; 1af9: 21 5c 00    .\.
	jr	L1aff		;; 1afc: 18 01       ..

L1afe:	push	h		;; 1afe: e5          .
L1aff:	mov	a,m		;; 1aff: 7e          ~
	ana	a		;; 1b00: a7          .
	jrnz	L1b0c		;; 1b01: 20 09        .
	xra	a		;; 1b03: af          .
	sta	L1b3e		;; 1b04: 32 3e 1b    2>.
	sta	L1b3f		;; 1b07: 32 3f 1b    2?.
	jr	L1b16		;; 1b0a: 18 0a       ..

L1b0c:	adi	040h		;; 1b0c: c6 40       .@
	sta	L1b3e		;; 1b0e: 32 3e 1b    2>.
	mvi	a,03ah		;; 1b11: 3e 3a       >:
	sta	L1b3f		;; 1b13: 32 3f 1b    2?.
L1b16:	lxi	d,L1b40		;; 1b16: 11 40 1b    .@.
	inx	h		;; 1b19: 23          #
	lxi	b,00008h	;; 1b1a: 01 08 00    ...
	ldir			;; 1b1d: ed b0       ..
	inx	d		;; 1b1f: 13          .
	lxi	b,00003h	;; 1b20: 01 03 00    ...
	ldir			;; 1b23: ed b0       ..
	lxi	h,L1b3d		;; 1b25: 21 3d 1b    .=.
	mvi	c,00eh		;; 1b28: 0e 0e       ..
L1b2a:	mov	a,m		;; 1b2a: 7e          ~
	cpi	020h		;; 1b2b: fe 20       . 
	jrnz	L1b31		;; 1b2d: 20 02        .
	mvi	m,000h		;; 1b2f: 36 00       6.
L1b31:	inx	h		;; 1b31: 23          #
	dcr	c		;; 1b32: 0d          .
	jrnz	L1b2a		;; 1b33: 20 f5        .
	lxi	d,L1b3d		;; 1b35: 11 3d 1b    .=.
	call	L1bfd		;; 1b38: cd fd 1b    ...
	pop	h		;; 1b3b: e1          .
	ret			;; 1b3c: c9          .

L1b3d:	db	' '
L1b3e:	db	'A'
L1b3f:	db	':'
L1b40:	db	'FILENAME.j  ',0dh,0ah,'$'
L1b4f:	mov	e,a		;; 1b4f: 5f          _
	call	L1b5f		;; 1b50: cd 5f 1b    ._.
	jmp	L03a2		;; 1b53: c3 a2 03    ...

L1b56:	db	0
L1b57:	db	0
L1b58:	mov	a,e		;; 1b58: 7b          {
	cpi	0ffh		;; 1b59: fe ff       ..
	jz	L0c5d		;; 1b5b: ca 5d 0c    .].
	pop	psw		;; 1b5e: f1          .
L1b5f:	push	psw		;; 1b5f: f5          .
	push	h		;; 1b60: e5          .
	mov	a,e		;; 1b61: 7b          {
	cpi	00ah		;; 1b62: fe 0a       ..
	jrz	L1b93		;; 1b64: 28 2d       (-
	cpi	00dh		;; 1b66: fe 0d       ..
	jrz	L1b8f		;; 1b68: 28 25       (%
	cpi	01ah		;; 1b6a: fe 1a       ..
	jrz	L1b8f		;; 1b6c: 28 21       (.
	cpi	009h		;; 1b6e: fe 09       ..
	jrz	L1b7b		;; 1b70: 28 09       (.
	lda	L1b56		;; 1b72: 3a 56 1b    :V.
	inr	a		;; 1b75: 3c          <
	sta	L1b56		;; 1b76: 32 56 1b    2V.
	jr	L1b93		;; 1b79: 18 18       ..

L1b7b:	mvi	e,020h		;; 1b7b: 1e 20       . 
	mvi	c,006h		;; 1b7d: 0e 06       ..
	call	L0c5e		;; 1b7f: cd 5e 0c    .^.
	lda	L1b56		;; 1b82: 3a 56 1b    :V.
	inr	a		;; 1b85: 3c          <
	sta	L1b56		;; 1b86: 32 56 1b    2V.
	ani	007h		;; 1b89: e6 07       ..
	jrnz	L1b7b		;; 1b8b: 20 ee        .
	jr	L1b98		;; 1b8d: 18 09       ..

L1b8f:	xra	a		;; 1b8f: af          .
	sta	L1b56		;; 1b90: 32 56 1b    2V.
L1b93:	mvi	c,006h		;; 1b93: 0e 06       ..
	call	L0c5e		;; 1b95: cd 5e 0c    .^.
L1b98:	lda	L1b57		;; 1b98: 3a 57 1b    :W.
	ana	a		;; 1b9b: a7          .
	jrnz	L1bbb		;; 1b9c: 20 1d        .
	mvi	e,0ffh		;; 1b9e: 1e ff       ..
	mvi	c,006h		;; 1ba0: 0e 06       ..
	call	L0c5e		;; 1ba2: cd 5e 0c    .^.
	ana	a		;; 1ba5: a7          .
	jrz	L1bbb		;; 1ba6: 28 13       (.
	cpi	013h		;; 1ba8: fe 13       ..
	jrnz	L1bbe		;; 1baa: 20 12        .
L1bac:	mvi	c,006h		;; 1bac: 0e 06       ..
	mvi	e,0ffh		;; 1bae: 1e ff       ..
	call	L0aef		;; 1bb0: cd ef 0a    ...
	ana	a		;; 1bb3: a7          .
	jrz	L1bac		;; 1bb4: 28 f6       (.
	cpi	003h		;; 1bb6: fe 03       ..
	jz	L1ca9		;; 1bb8: ca a9 1c    ...
L1bbb:	pop	h		;; 1bbb: e1          .
	pop	psw		;; 1bbc: f1          .
	ret			;; 1bbd: c9          .

L1bbe:	sta	L1b57		;; 1bbe: 32 57 1b    2W.
	jr	L1bbb		;; 1bc1: 18 f8       ..

	mvi	a,001h		;; 1bc3: 3e 01       >.
	sta	L1be6		;; 1bc5: 32 e6 1b    2..
	mvi	e,000h		;; 1bc8: 1e 00       ..
	jr	L1bd4		;; 1bca: 18 08       ..

L1bcc:	xra	a		;; 1bcc: af          .
	sta	L1be6		;; 1bcd: 32 e6 1b    2..
	lda	L1d67		;; 1bd0: 3a 67 1d    :g.
	mov	e,a		;; 1bd3: 5f          _
L1bd4:	mvi	c,020h		;; 1bd4: 0e 20       . 
	jmp	L0c5e		;; 1bd6: c3 5e 0c    .^.

L1bd9:	push	h		;; 1bd9: e5          .
	push	d		;; 1bda: d5          .
	mvi	c,020h		;; 1bdb: 0e 20       . 
	mvi	a,0ffh		;; 1bdd: 3e ff       >.
	mov	e,a		;; 1bdf: 5f          _
	call	L0c8b		;; 1be0: cd 8b 0c    ...
	pop	d		;; 1be3: d1          .
	pop	h		;; 1be4: e1          .
	ret			;; 1be5: c9          .

L1be6:	db	0
L1be7:	push	h		;; 1be7: e5          .
	mvi	c,01ah		;; 1be8: 0e 1a       ..
	call	L1a14		;; 1bea: cd 14 1a    ...
	pop	h		;; 1bed: e1          .
	ret			;; 1bee: c9          .

L1bef:	push	h		;; 1bef: e5          .
	mvi	c,014h		;; 1bf0: 0e 14       ..
	call	00005h		;; 1bf2: cd 05 00    ...
	pop	h		;; 1bf5: e1          .
	ret			;; 1bf6: c9          .

L1bf7:	mvi	c,00fh		;; 1bf7: 0e 0f       ..
	jmp	00005h		;; 1bf9: c3 05 00    ...

L1bfc:	pop	psw		;; 1bfc: f1          .
L1bfd:	push	psw		;; 1bfd: f5          .
	push	h		;; 1bfe: e5          .
	xchg			;; 1bff: eb          .
L1c00:	mov	a,m		;; 1c00: 7e          ~
	cpi	024h		;; 1c01: fe 24       .$
	jrz	L1c0c		;; 1c03: 28 07       (.
	mov	e,a		;; 1c05: 5f          _
	call	L1b5f		;; 1c06: cd 5f 1b    ._.
	inx	h		;; 1c09: 23          #
	jr	L1c00		;; 1c0a: 18 f4       ..

L1c0c:	pop	h		;; 1c0c: e1          .
	pop	psw		;; 1c0d: f1          .
	ret			;; 1c0e: c9          .

L1c0f:	pop	psw		;; 1c0f: f1          .
L1c10:	lda	L1b57		;; 1c10: 3a 57 1b    :W.
	ana	a		;; 1c13: a7          .
	jrnz	L1c1e		;; 1c14: 20 08        .
	mvi	c,00bh		;; 1c16: 0e 0b       ..
	call	L0aef		;; 1c18: cd ef 0a    ...
	ana	a		;; 1c1b: a7          .
	jrz	L1c10		;; 1c1c: 28 f2       (.
L1c1e:	mvi	c,001h		;; 1c1e: 0e 01       ..
	jmp	L0c5e		;; 1c20: c3 5e 0c    .^.

L1c23:	pop	psw		;; 1c23: f1          .
L1c24:	ldax	d		;; 1c24: 1a          .
	sta	L1c5c		;; 1c25: 32 5c 1c    2\.
	inx	d		;; 1c28: 13          .
	sded	L20aa		;; 1c29: ed 53 aa 20 .S. 
	mvi	b,000h		;; 1c2d: 06 00       ..
L1c2f:	push	b		;; 1c2f: c5          .
	push	d		;; 1c30: d5          .
	call	L1c10		;; 1c31: cd 10 1c    ...
	pop	d		;; 1c34: d1          .
	pop	b		;; 1c35: c1          .
	ani	07fh		;; 1c36: e6 7f       ..
	cpi	003h		;; 1c38: fe 03       ..
	jz	L1ca9		;; 1c3a: ca a9 1c    ...
	cpi	008h		;; 1c3d: fe 08       ..
	jrz	L1c72		;; 1c3f: 28 31       (1
	cpi	018h		;; 1c41: fe 18       ..
	jrz	L1c86		;; 1c43: 28 41       (A
	cpi	015h		;; 1c45: fe 15       ..
	jrz	L1c86		;; 1c47: 28 3d       (=
	cpi	07fh		;; 1c49: fe 7f       ..
	jrz	L1c63		;; 1c4b: 28 16       (.
	cpi	00ah		;; 1c4d: fe 0a       ..
	jz	L1cb9		;; 1c4f: ca b9 1c    ...
	cpi	00dh		;; 1c52: fe 0d       ..
	jz	L1cb9		;; 1c54: ca b9 1c    ...
	inr	b		;; 1c57: 04          .
	inx	d		;; 1c58: 13          .
	stax	d		;; 1c59: 12          .
	mov	a,b		;; 1c5a: 78          x
	cpi	07fh		;; 1c5b: fe 7f       ..
L1c5c	equ	$-1
	jnz	L1c2f		;; 1c5d: c2 2f 1c    ./.
	jmp	L1cb9		;; 1c60: c3 b9 1c    ...

L1c63:	push	d		;; 1c63: d5          .
	push	b		;; 1c64: c5          .
	lxi	d,L1cb5		;; 1c65: 11 b5 1c    ...
	call	L1bfd		;; 1c68: cd fd 1b    ...
	mvi	e,008h		;; 1c6b: 1e 08       ..
	call	L1b5f		;; 1c6d: cd 5f 1b    ._.
	pop	b		;; 1c70: c1          .
	pop	d		;; 1c71: d1          .
L1c72:	mov	a,b		;; 1c72: 78          x
	ana	a		;; 1c73: a7          .
	jz	L1c9b		;; 1c74: ca 9b 1c    ...
	push	b		;; 1c77: c5          .
	push	d		;; 1c78: d5          .
	lxi	d,L1cb6		;; 1c79: 11 b6 1c    ...
	call	L1bfd		;; 1c7c: cd fd 1b    ...
	pop	d		;; 1c7f: d1          .
	pop	b		;; 1c80: c1          .
	dcx	d		;; 1c81: 1b          .
	dcr	b		;; 1c82: 05          .
	jmp	L1c2f		;; 1c83: c3 2f 1c    ./.

L1c86:	dcr	b		;; 1c86: 05          .
	jm	L1c97		;; 1c87: fa 97 1c    ...
	dcx	d		;; 1c8a: 1b          .
	push	b		;; 1c8b: c5          .
	push	d		;; 1c8c: d5          .
	lxi	d,L1cb5		;; 1c8d: 11 b5 1c    ...
	call	L1bfd		;; 1c90: cd fd 1b    ...
	pop	d		;; 1c93: d1          .
	pop	b		;; 1c94: c1          .
	jr	L1c86		;; 1c95: 18 ef       ..

L1c97:	inr	b		;; 1c97: 04          .
	jmp	L1c2f		;; 1c98: c3 2f 1c    ./.

L1c9b:	push	b		;; 1c9b: c5          .
	push	d		;; 1c9c: d5          .
	mvi	e,03eh		;; 1c9d: 1e 3e       .>
	mvi	c,006h		;; 1c9f: 0e 06       ..
	call	L0c5e		;; 1ca1: cd 5e 0c    .^.
	pop	d		;; 1ca4: d1          .
	pop	b		;; 1ca5: c1          .
	jmp	L1c2f		;; 1ca6: c3 2f 1c    ./.

L1ca9:	lxi	d,L1cb2		;; 1ca9: 11 b2 1c    ...
	call	L1bfd		;; 1cac: cd fd 1b    ...
	jmp	L033e		;; 1caf: c3 3e 03    .>.

L1cb2:	db	'^C$'
L1cb5:	db	8
L1cb6:	db	' ',8,'$'
L1cb9:	lded	L20aa		;; 1cb9: ed 5b aa 20 .[. 
	mov	a,b		;; 1cbd: 78          x
	stax	d		;; 1cbe: 12          .
	ret			;; 1cbf: c9          .

L1cc0:	lxi	d,L1d0f		;; 1cc0: 11 0f 1d    ...
	jmp	L1bfd		;; 1cc3: c3 fd 1b    ...

L1cc6:	mov	m,a		;; 1cc6: 77          w
	inx	h		;; 1cc7: 23          #
	dcr	c		;; 1cc8: 0d          .
	jrnz	L1cc6		;; 1cc9: 20 fb        .
	ret			;; 1ccb: c9          .

L1ccc:	db	'ULC-OPSnet v1.85 Gatekeeper, Node '
L1cee:	db	'0',0dh,0ah,'OPSnet (c) 1985 by Aquinas Inc'
L1d0f:	db	0dh,0ah,'$'
L1d12:	db	0dh,0ah,'<'
L1d15:	db	'X$'
L1d17:	db	'0>$'
L1d1a:	db	'?No such file(s) as $'
L1d2f:	db	'?Too few args$'
L1d3d:	db	'?File already exist: $'
L1d53:	db	0ffh
L1d54:	db	1,0
L1d56:	db	'0'
L1d57:	db	80h,0
L1d59:	db	80h,0
L1d5b:	db	0
L1d5c:	db	0
L1d5d:	db	0
L1d5e:	db	0
L1d5f:	db	7,'('
L1d61:	db	0
L1d62:	db	0
L1d63:	db	1
L1d64:	db	0
L1d65:	db	0
L1d66:	db	'N'
L1d67:	db	0
L1d68:	db	19h,16h,'B5AUT  '
L1d71:	db	'0990$'
L1d76:	db	'0'
L1d77:	db	0
L1d78:	db	0
L1d79:	db	0
L1d7a:	db	0
L1d7b:	db	0
L1d7c:	jmp	00000h		;; 1d7c: c3 00 00    ...
L1d7d	equ	$-2

; Gatekeeper Table...
L1d7f:	db	'G'-'0',0,0	; 17h == gatekeeper (this node)?
	db	0,0,0
	db	0,0,0
	db	0,0,0
	db	0,0,0
	db	0,0,0
	db	0,0,0
	db	0,0,0
	db	0,0,0
	db	0,0,0
	db	0,0,0
	db	0,0,0
	db	0,0,0
	db	0,0,0
	db	0,0,0
	db	0,0,0
	db	0,0,0
	db	0,0,0
	db	0,0,0
	db	0,0,0
	db	0,0

L1dbd:	db	1,'$$$     SUB',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
L1dde:	db	0ffh,0ffh,0
L1de1:	db	0
L1de2:	db	0
L1de3:	db	0
L1de4:	db	5,'BDOSQ 3'
L1dec:	db	1ah,14h,'C'
L1def:	db	95h,'BDO'

; network vector block
L1df3:	db	'SS 3',4,0bah,8,'bBDOSV'

L1e00:	db	' ',13h,1
L1e03:	db	0cdh,1,95h,'BDOSX 3',0ch,'^',21h,'GBDOSXP3'
L1e18:	db	0ch,95h,21h,88h,'BDOSXV',13h,0ch,8bh,21h,83h,'BDOSZ ',13h,1
	db	0d6h,1,99h,'BDRERH3',2,5,2,'7BDRERR3',2,'3',2,'bBERET 3',2
	db	0bh,2,'@BERR  3',2,'e',2,84h,'BERRET',13h,2,'#',2,'TBFRERH3'
	db	2,9,2,'9BFRERR3',2,'8',2,'dBLANK 3',1bh,'OEIBOOT  ',3,0,0,0
	db	4,'BP1',1ah
L1e99:	db	0
L1e9a:	db	0,0
L1e9c:	db	0
L1e9d:	db	0
L1e9e:	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
L1eb8:	db	0
L1eb9:	db	0,0,0
L1ebc:	db	0
L1ebd:	db	0,0,0,0,0,0
L1ec3:	db	0
L1ec4:	db	0,0
L1ec6:	db	0
L1ec7:	db	0
L1ec8:	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0
L1ee8:	db	0,0,0
L1eeb:	db	0
L1eec:	db	0
L1eed:	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7fh,7fh,7fh,7fh,7fh
	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
L1f6d:	db	7fh
L1f6e:	db	7fh
L1f6f:	db	7fh
L1f70:	db	7fh
L1f71:	db	7fh
L1f72:	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh,7fh,7fh,7fh,7fh
L1fef:	db	7fh
L1ff0:	db	7fh,7fh
L1ff2:	db	7fh,7fh,7fh,7fh,7fh,7fh
L1ff8:	db	7fh
L1ff9:	db	7fh,7fh
L1ffb:	db	7fh,7fh
L1ffd:	db	7fh,7fh,7fh
L2000:	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh,7fh
L2020:	db	7fh
L2021:	db	7fh
L2022:	db	7fh,7fh
L2024:	db	7fh,7fh
L2026:	db	7fh,7fh
L2028:	db	7fh
L2029:	db	7fh,7fh,7fh,7fh
L202d:	db	7fh,7fh
L202f:	db	7fh,7fh
L2031:	db	7fh
L2032:	db	7fh,7fh
L2034:	db	7fh
L2035:	db	7fh
L2036:	db	7fh
L2037:	db	7fh,7fh,7fh,7fh
L203b:	db	7fh
L203c:	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
L2047:	db	7fh
L2048:	db	7fh
L2049:	db	7fh
L204a:	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh,7fh
L205b:	db	7fh,7fh,7fh,7fh
L205f:	db	7fh
L2060:	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh,7fh,7fh,7fh,7fh
L2083:	db	7fh
L2084:	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh,7fh,7fh,7fh,7fh,7fh
L20a8:	db	7fh
L20a9:	db	7fh
L20aa:	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh,7fh,7fh,7fh,7fh
L20dc:	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh,7fh,7fh
L210c:	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
L2124:	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
L212e:	db	7fh,7fh,7fh,7fh,7fh,7fh
L2134:	db	7fh

L2135:	db	7fh	; message status
; recv message buffer?
L2136:	db	7fh	; +0: format/msg type
	db	7fh	; +1: destination (us)
	db	7fh,7fh
	db	7fh	; +4: new node id?
	db	7fh,7fh	; +5:
	db	7fh	; +7: func
	db	7fh,7fh
	; payload begin?
	db	7fh	; +10:
	db	7fh	; +11:
	db	7fh	; +12:
	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh	; +22:
	db	7fh	; +23:
	db	7fh	; +24:
	db	7fh	; +25:
	db	7fh,7fh

L2152:	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh
L2162:	db	7fh,7fh,7fh
L2165:	db	7fh
L2166:	db	7fh
L2167:	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	ds	672
L2420:	ds	1
	end

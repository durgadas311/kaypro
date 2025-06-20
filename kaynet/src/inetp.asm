	org	00100h
	mvi	c,069h		;; 0100: 0e 69       .i
	call	00005h		;; 0102: cd 05 00    ...
	push	h		;; 0105: e5          .
	pop	d		;; 0106: d1          .
	lxi	h,L0127		;; 0107: 21 27 01    .'.
	lxi	b,00005h	;; 010a: 01 05 00    ...
	ldir			;; 010d: ed b0       ..
	mvi	c,078h		;; 010f: 0e 78       .x
	call	00005h		;; 0111: cd 05 00    ...
	lda	0005dh		;; 0114: 3a 5d 00    :].
	cpi	04bh		;; 0117: fe 4b       .K
	jz	L0279		;; 0119: ca 79 02    .y.
	lxi	d,L012c		;; 011c: 11 2c 01    .,.
	mvi	c,009h		;; 011f: 0e 09       ..
	call	00005h		;; 0121: cd 05 00    ...
	jmp	00000h		;; 0124: c3 00 00    ...

L0127:	db	'1.84 '
L012c:	db	'? Unknown system type.$'
	mvi	a,005h		;; 0143: 3e 05       >.
	mov	m,a		;; 0145: 77          w
	inx	h		;; 0146: 23          #
	mov	m,a		;; 0147: 77          w
	inx	h		;; 0148: 23          #
	mov	m,a		;; 0149: 77          w
	inx	h		;; 014a: 23          #
	mov	m,a		;; 014b: 77          w
	dcr	a		;; 014c: 3d          =
	inx	h		;; 014d: 23          #
	mov	m,a		;; 014e: 77          w
	inx	h		;; 014f: 23          #
	mov	m,a		;; 0150: 77          w
	inx	h		;; 0151: 23          #
	mov	m,a		;; 0152: 77          w
	inx	h		;; 0153: 23          #
	mov	m,a		;; 0154: 77          w
	mvi	a,004h		;; 0155: 3e 04       >.
	inx	h		;; 0157: 23          #
	mov	m,a		;; 0158: 77          w
	mvi	a,001h		;; 0159: 3e 01       >.
	inx	h		;; 015b: 23          #
	mov	m,a		;; 015c: 77          w
	inx	h		;; 015d: 23          #
	mov	m,a		;; 015e: 77          w
	inx	h		;; 015f: 23          #
	mov	m,a		;; 0160: 77          w
	lda	0006dh		;; 0161: 3a 6d 00    :m.
	sui	030h		;; 0164: d6 30       .0
	inx	h		;; 0166: 23          #
	shld	L037b		;; 0167: 22 7b 03    "{.
	mov	m,a		;; 016a: 77          w
	inx	h		;; 016b: 23          #
	mvi	a,001h		;; 016c: 3e 01       >.
	mov	m,a		;; 016e: 77          w
	lxi	h,L0448		;; 016f: 21 48 04    .H.
L0172:	mov	a,m		;; 0172: 7e          ~
	cpi	0ffh		;; 0173: fe ff       ..
	jz	L017e		;; 0175: ca 7e 01    .~.
	out	005h		;; 0178: d3 05       ..
	inx	h		;; 017a: 23          #
	jmp	L0172		;; 017b: c3 72 01    .r.

L017e:	in	005h		;; 017e: db 05       ..
	ani	001h		;; 0180: e6 01       ..
	jz	L018a		;; 0182: ca 8a 01    ...
	in	004h		;; 0185: db 04       ..
	jmp	L017e		;; 0187: c3 7e 01    .~.

L018a:	mvi	a,057h		;; 018a: 3e 57       >W
	out	00ch		;; 018c: d3 0c       ..
	mvi	a,006h		;; 018e: 3e 06       >.
	out	00ch		;; 0190: d3 0c       ..
	mvi	a,005h		;; 0192: 3e 05       >.
	sta	L02e2		;; 0194: 32 e2 02    2..
	sta	L02e6		;; 0197: 32 e6 02    2..
	sta	L02ea		;; 019a: 32 ea 02    2..
	sta	L0349		;; 019d: 32 49 03    2I.
	sta	L034d		;; 01a0: 32 4d 03    2M.
	sta	L0351		;; 01a3: 32 51 03    2Q.
	sta	L02f4		;; 01a6: 32 f4 02    2..
	sta	L02f8		;; 01a9: 32 f8 02    2..
	jmp	L02d0		;; 01ac: c3 d0 02    ...

	mvi	a,002h		;; 01af: 3e 02       >.
	mov	m,a		;; 01b1: 77          w
	inx	h		;; 01b2: 23          #
	mov	m,a		;; 01b3: 77          w
	inx	h		;; 01b4: 23          #
	mov	m,a		;; 01b5: 77          w
	inx	h		;; 01b6: 23          #
	mov	m,a		;; 01b7: 77          w
	mvi	a,003h		;; 01b8: 3e 03       >.
	inx	h		;; 01ba: 23          #
	mov	m,a		;; 01bb: 77          w
	inx	h		;; 01bc: 23          #
	mov	m,a		;; 01bd: 77          w
	inx	h		;; 01be: 23          #
	mov	m,a		;; 01bf: 77          w
	mvi	a,003h		;; 01c0: 3e 03       >.
	inx	h		;; 01c2: 23          #
	mov	m,a		;; 01c3: 77          w
	mvi	a,001h		;; 01c4: 3e 01       >.
	inx	h		;; 01c6: 23          #
	mov	m,a		;; 01c7: 77          w
	mvi	a,002h		;; 01c8: 3e 02       >.
	inx	h		;; 01ca: 23          #
	mov	m,a		;; 01cb: 77          w
	inx	h		;; 01cc: 23          #
	mov	m,a		;; 01cd: 77          w
	inx	h		;; 01ce: 23          #
	mov	m,a		;; 01cf: 77          w
	lda	0006dh		;; 01d0: 3a 6d 00    :m.
	sui	030h		;; 01d3: d6 30       .0
	inx	h		;; 01d5: 23          #
	mov	m,a		;; 01d6: 77          w
	adi	030h		;; 01d7: c6 30       .0
	inx	h		;; 01d9: 23          #
	mov	m,a		;; 01da: 77          w
	mvi	b,003h		;; 01db: 06 03       ..
	xra	a		;; 01dd: af          .
L01de:	out	002h		;; 01de: d3 02       ..
	nop			;; 01e0: 00          .
	nop			;; 01e1: 00          .
	dcr	b		;; 01e2: 05          .
	jnz	L01de		;; 01e3: c2 de 01    ...
	mvi	a,040h		;; 01e6: 3e 40       >@
	out	002h		;; 01e8: d3 02       ..
	nop			;; 01ea: 00          .
	nop			;; 01eb: 00          .
	nop			;; 01ec: 00          .
	nop			;; 01ed: 00          .
	nop			;; 01ee: 00          .
	mvi	a,0feh		;; 01ef: 3e fe       >.
	out	002h		;; 01f1: d3 02       ..
	nop			;; 01f3: 00          .
	nop			;; 01f4: 00          .
	nop			;; 01f5: 00          .
	nop			;; 01f6: 00          .
	nop			;; 01f7: 00          .
	mvi	a,037h		;; 01f8: 3e 37       >7
	out	002h		;; 01fa: d3 02       ..
	nop			;; 01fc: 00          .
	nop			;; 01fd: 00          .
L01fe:	mvi	c,077h		;; 01fe: 0e 77       .w
	call	00005h		;; 0200: cd 05 00    ...
	lxi	d,L0457		;; 0203: 11 57 04    .W.
	mvi	c,009h		;; 0206: 0e 09       ..
	call	00005h		;; 0208: cd 05 00    ...
	jmp	00000h		;; 020b: c3 00 00    ...

	mvi	a,0f6h		;; 020e: 3e f6       >.
	mov	m,a		;; 0210: 77          w
	inx	h		;; 0211: 23          #
	mov	m,a		;; 0212: 77          w
	inx	h		;; 0213: 23          #
	mov	m,a		;; 0214: 77          w
	inx	h		;; 0215: 23          #
	mov	m,a		;; 0216: 77          w
	mvi	a,0f4h		;; 0217: 3e f4       >.
	inx	h		;; 0219: 23          #
	mov	m,a		;; 021a: 77          w
	inx	h		;; 021b: 23          #
	mov	m,a		;; 021c: 77          w
	inx	h		;; 021d: 23          #
	mov	m,a		;; 021e: 77          w
	mvi	a,0f4h		;; 021f: 3e f4       >.
	inx	h		;; 0221: 23          #
	mov	m,a		;; 0222: 77          w
	mvi	a,004h		;; 0223: 3e 04       >.
	inx	h		;; 0225: 23          #
	mov	m,a		;; 0226: 77          w
	mvi	a,001h		;; 0227: 3e 01       >.
	inx	h		;; 0229: 23          #
	mov	m,a		;; 022a: 77          w
	inx	h		;; 022b: 23          #
	mov	m,a		;; 022c: 77          w
	inx	h		;; 022d: 23          #
	mov	m,a		;; 022e: 77          w
	lda	0006dh		;; 022f: 3a 6d 00    :m.
	sui	030h		;; 0232: d6 30       .0
	inx	h		;; 0234: 23          #
	mov	m,a		;; 0235: 77          w
	adi	030h		;; 0236: c6 30       .0
	inx	h		;; 0238: 23          #
	mov	m,a		;; 0239: 77          w
	mvi	a,00fh		;; 023a: 3e 0f       >.
	out	0e9h		;; 023c: d3 e9       ..
	lxi	h,L0448		;; 023e: 21 48 04    .H.
L0241:	mov	a,m		;; 0241: 7e          ~
	cpi	0ffh		;; 0242: fe ff       ..
	jz	L024d		;; 0244: ca 4d 02    .M.
	out	0f6h		;; 0247: d3 f6       ..
	inx	h		;; 0249: 23          #
	jmp	L0241		;; 024a: c3 41 02    .A.

L024d:	in	0f6h		;; 024d: db f6       ..
	ani	001h		;; 024f: e6 01       ..
	jz	L0259		;; 0251: ca 59 02    .Y.
	in	0f4h		;; 0254: db f4       ..
	jmp	L024d		;; 0256: c3 4d 02    .M.

L0259:	mvi	c,06eh		;; 0259: 0e 6e       .n
	call	00005h		;; 025b: cd 05 00    ...
	cpi	07bh		;; 025e: fe 7b       .{
	jz	L033b		;; 0260: ca 3b 03    .;.
	mvi	c,077h		;; 0263: 0e 77       .w
	call	00005h		;; 0265: cd 05 00    ...
	mvi	a,030h		;; 0268: 3e 30       >0
	out	0f6h		;; 026a: d3 f6       ..
	mvi	a,005h		;; 026c: 3e 05       >.
	out	0f6h		;; 026e: d3 f6       ..
	mvi	a,06ah		;; 0270: 3e 6a       >j
	out	0f6h		;; 0272: d3 f6       ..
	jmp	L02f9		;; 0274: c3 f9 02    ...

	db	0d3h,69h
L0279:	mvi	a,00eh		;; 0279: 3e 0e       >.
	mov	m,a		;; 027b: 77          w
	inx	h		;; 027c: 23          #
	mov	m,a		;; 027d: 77          w
	inx	h		;; 027e: 23          #
	mov	m,a		;; 027f: 77          w
	inx	h		;; 0280: 23          #
	mov	m,a		;; 0281: 77          w
	mvi	a,00ch		;; 0282: 3e 0c       >.
	inx	h		;; 0284: 23          #
	mov	m,a		;; 0285: 77          w
	inx	h		;; 0286: 23          #
	mov	m,a		;; 0287: 77          w
	inx	h		;; 0288: 23          #
	mov	m,a		;; 0289: 77          w
	mvi	a,00ch		;; 028a: 3e 0c       >.
	inx	h		;; 028c: 23          #
	mov	m,a		;; 028d: 77          w
	mvi	a,004h		;; 028e: 3e 04       >.
	inx	h		;; 0290: 23          #
	mov	m,a		;; 0291: 77          w
	mvi	a,001h		;; 0292: 3e 01       >.
	inx	h		;; 0294: 23          #
	mov	m,a		;; 0295: 77          w
	inx	h		;; 0296: 23          #
	mov	m,a		;; 0297: 77          w
	inx	h		;; 0298: 23          #
	mov	m,a		;; 0299: 77          w
	lda	0006dh		;; 029a: 3a 6d 00    :m.
	sui	030h		;; 029d: d6 30       .0
	inx	h		;; 029f: 23          #
	shld	L037b		;; 02a0: 22 7b 03    "{.
	mov	m,a		;; 02a3: 77          w
	inx	h		;; 02a4: 23          #
	xra	a		;; 02a5: af          .
	mvi	a,001h		;; 02a6: 3e 01       >.
	mov	m,a		;; 02a8: 77          w
	mvi	a,004h		;; 02a9: 3e 04       >.
	out	00eh		;; 02ab: d3 0e       ..
	mvi	a,00fh		;; 02ad: 3e 0f       >.
	out	00eh		;; 02af: d3 0e       ..
	mvi	a,00fh		;; 02b1: 3e 0f       >.
	out	008h		;; 02b3: d3 08       ..
	lxi	h,L0448		;; 02b5: 21 48 04    .H.
L02b8:	mov	a,m		;; 02b8: 7e          ~
	cpi	0ffh		;; 02b9: fe ff       ..
	jz	L02c4		;; 02bb: ca c4 02    ...
	out	00eh		;; 02be: d3 0e       ..
	inx	h		;; 02c0: 23          #
	jmp	L02b8		;; 02c1: c3 b8 02    ...

L02c4:	in	00eh		;; 02c4: db 0e       ..
	ani	001h		;; 02c6: e6 01       ..
	jz	L02d0		;; 02c8: ca d0 02    ...
	in	00ch		;; 02cb: db 0c       ..
	jmp	L02c4		;; 02cd: c3 c4 02    ...

L02d0:	mvi	c,06eh		;; 02d0: 0e 6e       .n
	call	00005h		;; 02d2: cd 05 00    ...
	cpi	07bh		;; 02d5: fe 7b       .{
	jz	L033b		;; 02d7: ca 3b 03    .;.
	mvi	c,077h		;; 02da: 0e 77       .w
	call	00005h		;; 02dc: cd 05 00    ...
	mvi	a,030h		;; 02df: 3e 30       >0
	out	00eh		;; 02e1: d3 0e       ..
L02e2	equ	$-1
	mvi	a,005h		;; 02e3: 3e 05       >.
	out	00eh		;; 02e5: d3 0e       ..
L02e6	equ	$-1
	mvi	a,06ah		;; 02e7: 3e 6a       >j
	out	00eh		;; 02e9: d3 0e       ..
L02ea	equ	$-1
	mvi	a,003h		;; 02eb: 3e 03       >.
L02ed:	dcr	a		;; 02ed: 3d          =
	jnz	L02ed		;; 02ee: c2 ed 02    ...
	mvi	a,005h		;; 02f1: 3e 05       >.
	out	00eh		;; 02f3: d3 0e       ..
L02f4	equ	$-1
	mvi	a,0eah		;; 02f5: 3e ea       >.
	out	00eh		;; 02f7: d3 0e       ..
L02f8	equ	$-1
L02f9:	mvi	c,062h		;; 02f9: 0e 62       .b
	call	00005h		;; 02fb: cd 05 00    ...
	mvi	a,002h		;; 02fe: 3e 02       >.
	mvi	c,07ch		;; 0300: 0e 7c       .|
	shld	L046c		;; 0302: 22 6c 04    "l.
	lxi	h,L0462		;; 0305: 21 62 04    .b.
	call	00005h		;; 0308: cd 05 00    ...
L030b:	mvi	c,07dh		;; 030b: 0e 7d       .}
	call	00005h		;; 030d: cd 05 00    ...
	cpi	001h		;; 0310: fe 01       ..
	jz	L030b		;; 0312: ca 0b 03    ...
	cpi	002h		;; 0315: fe 02       ..
	jnz	L037d		;; 0317: c2 7d 03    .}.
	lda	L0461		;; 031a: 3a 61 04    :a.
	inr	a		;; 031d: 3c          <
	sta	L0461		;; 031e: 32 61 04    2a.
	cpi	005h		;; 0321: fe 05       ..
	jnz	L02f9		;; 0323: c2 f9 02    ...
	lxi	d,L03cf		;; 0326: 11 cf 03    ...
L0329:	lhld	L037b		;; 0329: 2a 7b 03    *{.
	xra	a		;; 032c: af          .
	mov	m,a		;; 032d: 77          w
	mvi	c,077h		;; 032e: 0e 77       .w
	call	00005h		;; 0330: cd 05 00    ...
	mvi	c,009h		;; 0333: 0e 09       ..
	call	00005h		;; 0335: cd 05 00    ...
	jmp	00000h		;; 0338: c3 00 00    ...

L033b:	lhld	L037b		;; 033b: 2a 7b 03    *{.
	mvi	a,017h		;; 033e: 3e 17       >.
	mov	m,a		;; 0340: 77          w
	mvi	c,077h		;; 0341: 0e 77       .w
	call	00005h		;; 0343: cd 05 00    ...
	mvi	a,030h		;; 0346: 3e 30       >0
	out	00eh		;; 0348: d3 0e       ..
L0349	equ	$-1
	mvi	a,005h		;; 034a: 3e 05       >.
	out	00eh		;; 034c: d3 0e       ..
L034d	equ	$-1
	mvi	a,06ah		;; 034e: 3e 6a       >j
	out	00eh		;; 0350: d3 0e       ..
L0351	equ	$-1
	mvi	c,07ch		;; 0352: 0e 7c       .|
	lxi	h,L0462		;; 0354: 21 62 04    .b.
	call	00005h		;; 0357: cd 05 00    ...
	lxi	d,L0365		;; 035a: 11 65 03    .e.
	mvi	c,009h		;; 035d: 0e 09       ..
	call	00005h		;; 035f: cd 05 00    ...
	jmp	00000h		;; 0362: c3 00 00    ...

L0365:	db	'Gatekeeper running...$'
L037b:	db	0,0
L037d:	lxi	d,00007h	;; 037d: 11 07 00    ...
	dad	d		;; 0380: 19          .
	mov	a,m		;; 0381: 7e          ~
	cpi	06fh		;; 0382: fe 6f       .o
	jz	L0392		;; 0384: ca 92 03    ...
	cpi	071h		;; 0387: fe 71       .q
	jz	L01fe		;; 0389: ca fe 01    ...
	lxi	d,L039e		;; 038c: 11 9e 03    ...
	jmp	L0329		;; 038f: c3 29 03    .).

L0392:	lda	0006dh		;; 0392: 3a 6d 00    :m.
	sta	L03be		;; 0395: 32 be 03    2..
	lxi	d,L03b4		;; 0398: 11 b4 03    ...
	jmp	L0329		;; 039b: c3 29 03    .).

L039e:	db	'? Authorization error$'
L03b4:	db	'? Node id '
L03be:	db	'X already in use$'
L03cf:	db	'? Gatekeeper unavailable$'
	mvi	a,0feh		;; 03e8: 3e fe       >.
	mov	m,a		;; 03ea: 77          w
	inx	h		;; 03eb: 23          #
	mov	m,a		;; 03ec: 77          w
	inx	h		;; 03ed: 23          #
	mov	m,a		;; 03ee: 77          w
	inx	h		;; 03ef: 23          #
	mov	m,a		;; 03f0: 77          w
	mvi	a,0fch		;; 03f1: 3e fc       >.
	inx	h		;; 03f3: 23          #
	mov	m,a		;; 03f4: 77          w
	inx	h		;; 03f5: 23          #
	mov	m,a		;; 03f6: 77          w
	inx	h		;; 03f7: 23          #
	mov	m,a		;; 03f8: 77          w
	mvi	a,0fch		;; 03f9: 3e fc       >.
	inx	h		;; 03fb: 23          #
	mov	m,a		;; 03fc: 77          w
	mvi	a,004h		;; 03fd: 3e 04       >.
	inx	h		;; 03ff: 23          #
	mov	m,a		;; 0400: 77          w
	mvi	a,001h		;; 0401: 3e 01       >.
	inx	h		;; 0403: 23          #
	mov	m,a		;; 0404: 77          w
	inx	h		;; 0405: 23          #
	mov	m,a		;; 0406: 77          w
	inx	h		;; 0407: 23          #
	mov	m,a		;; 0408: 77          w
	lda	0006dh		;; 0409: 3a 6d 00    :m.
	sui	030h		;; 040c: d6 30       .0
	inx	h		;; 040e: 23          #
	mov	m,a		;; 040f: 77          w
	adi	030h		;; 0410: c6 30       .0
	inx	h		;; 0412: 23          #
	mov	m,a		;; 0413: 77          w
	lxi	h,L0448		;; 0414: 21 48 04    .H.
L0417:	mov	a,m		;; 0417: 7e          ~
	cpi	0ffh		;; 0418: fe ff       ..
	jz	L0425		;; 041a: ca 25 04    .%.
	out	0feh		;; 041d: d3 fe       ..
	out	0ffh		;; 041f: d3 ff       ..
	inx	h		;; 0421: 23          #
	jmp	L0417		;; 0422: c3 17 04    ...

L0425:	in	0feh		;; 0425: db fe       ..
	ani	001h		;; 0427: e6 01       ..
	jz	L0431		;; 0429: ca 31 04    .1.
	in	0fch		;; 042c: db fc       ..
	jmp	L0425		;; 042e: c3 25 04    .%.

L0431:	mvi	a,030h		;; 0431: 3e 30       >0
	out	0feh		;; 0433: d3 fe       ..
	mvi	a,005h		;; 0435: 3e 05       >.
	out	0feh		;; 0437: d3 fe       ..
	mvi	a,06ah		;; 0439: 3e 6a       >j
	out	0feh		;; 043b: d3 fe       ..
	mvi	a,005h		;; 043d: 3e 05       >.
	out	0ffh		;; 043f: d3 ff       ..
	mvi	a,0eah		;; 0441: 3e ea       >.
	out	0ffh		;; 0443: d3 ff       ..
	jmp	L01fe		;; 0445: c3 fe 01    ...

L0448:	db	0,0,30h,1,0,4,0fh,5,0eah,3,0c1h,10h,10h,30h,0ffh
L0457:	db	'NET READY$'
L0461:	db	0
L0462:	db	0,17h,0,0,0,0,0,6eh,2,0
L046c:	db	1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	end

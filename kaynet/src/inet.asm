	org	00100h

	mvi	c,069h	; 105 - get version string
	call	00005h		;; 0102: cd 05 00    ...
	push	h		;; 0105: e5          .
	pop	d		;; 0106: d1          .
	lxi	h,L0136		;; 0107: 21 36 01    .6.
	lxi	b,5		;; 010a: 01 05 00    ...
	ldir		; copy our version string into OS (why???)
	mvi	c,078h	; 120 - network vector block (HL)
	call	00005h		;; 0111: cd 05 00    ...
	lda	0005dh		;; 0114: 3a 5d 00    :].
	cpi	'D'	; ???
	jz	L0152		;; 0119: ca 52 01    .R.
	cpi	'X'	; XEROX?
	jz	L0286		;; 011e: ca 86 02    ...
	cpi	'K'	; KAYPRO
	jz	kaypro		;; 0123: ca 88 02    ...
	cpi	'C'	; ???
	jz	L021d		;; 0128: ca 1d 02    ...
	lxi	d,L013b	; "Unknown system type"
	mvi	c,009h		;; 012e: 0e 09       ..
	call	00005h		;; 0130: cd 05 00    ...
	jmp	00000h		;; 0133: c3 00 00    ...

L0136:	db	'1.84 '

L013b:	db	'? Unknown system type.$'

; system 'D' setup
L0152:	mvi	a,005h		;; 0152: 3e 05       >.
	mov	m,a		;; 0154: 77          w
	inx	h		;; 0155: 23          #
	mov	m,a		;; 0156: 77          w
	inx	h		;; 0157: 23          #
	mov	m,a		;; 0158: 77          w
	inx	h		;; 0159: 23          #
	mov	m,a		;; 015a: 77          w
	dcr	a		;; 015b: 3d          =
	inx	h		;; 015c: 23          #
	mov	m,a		;; 015d: 77          w
	inx	h		;; 015e: 23          #
	mov	m,a		;; 015f: 77          w
	inx	h		;; 0160: 23          #
	mov	m,a		;; 0161: 77          w
	inx	h		;; 0162: 23          #
	mov	m,a		;; 0163: 77          w
	mvi	a,004h		;; 0164: 3e 04       >.
	inx	h		;; 0166: 23          #
	mov	m,a		;; 0167: 77          w
	mvi	a,001h		;; 0168: 3e 01       >.
	inx	h		;; 016a: 23          #
	mov	m,a		;; 016b: 77          w
	inx	h		;; 016c: 23          #
	mov	m,a		;; 016d: 77          w
	inx	h		;; 016e: 23          #
	mov	m,a		;; 016f: 77          w
	lda	0006dh		;; 0170: 3a 6d 00    :m.
	sui	030h		;; 0173: d6 30       .0
	inx	h		;; 0175: 23          #
	shld	nidptr		;; 0176: 22 8a 03    "..
	mov	m,a		;; 0179: 77          w
	inx	h		;; 017a: 23          #
	mvi	a,001h		;; 017b: 3e 01       >.
	mov	m,a		;; 017d: 77          w
	lxi	h,L0457		;; 017e: 21 57 04    .W.
L0181:	mov	a,m		;; 0181: 7e          ~
	cpi	0ffh		;; 0182: fe ff       ..
	jz	L018d		;; 0184: ca 8d 01    ...
	out	005h		;; 0187: d3 05       ..
	inx	h		;; 0189: 23          #
	jmp	L0181		;; 018a: c3 81 01    ...

L018d:	in	005h		;; 018d: db 05       ..
	ani	001h		;; 018f: e6 01       ..
	jz	L0199		;; 0191: ca 99 01    ...
	in	004h		;; 0194: db 04       ..
	jmp	L018d		;; 0196: c3 8d 01    ...

L0199:	mvi	a,'W'		;; 0199: 3e 57       >W
	out	00ch	; serial printer...???
	mvi	a,006h		;; 019d: 3e 06       >.
	out	00ch		;; 019f: d3 0c       ..
	mvi	a,005h		;; 01a1: 3e 05       >.
	sta	L02f0+1		;; 01a3: 32 f1 02    2..
	sta	L02f4+1		;; 01a6: 32 f5 02    2..
	sta	L02f8+1		;; 01a9: 32 f9 02    2..
	sta	L0357+1		;; 01ac: 32 58 03    2X.
	sta	L035b+1		;; 01af: 32 5c 03    2\.
	sta	L035f+1		;; 01b2: 32 60 03    2`.
	sta	L0302+1		;; 01b5: 32 03 03    2..
	sta	L0306+1		;; 01b8: 32 07 03    2..
	jmp	L02df		;; 01bb: c3 df 02    ...

	mvi	a,002h		;; 01be: 3e 02       >.
	mov	m,a		;; 01c0: 77          w
	inx	h		;; 01c1: 23          #
	mov	m,a		;; 01c2: 77          w
	inx	h		;; 01c3: 23          #
	mov	m,a		;; 01c4: 77          w
	inx	h		;; 01c5: 23          #
	mov	m,a		;; 01c6: 77          w
	mvi	a,003h		;; 01c7: 3e 03       >.
	inx	h		;; 01c9: 23          #
	mov	m,a		;; 01ca: 77          w
	inx	h		;; 01cb: 23          #
	mov	m,a		;; 01cc: 77          w
	inx	h		;; 01cd: 23          #
	mov	m,a		;; 01ce: 77          w
	mvi	a,003h		;; 01cf: 3e 03       >.
	inx	h		;; 01d1: 23          #
	mov	m,a		;; 01d2: 77          w
	mvi	a,001h		;; 01d3: 3e 01       >.
	inx	h		;; 01d5: 23          #
	mov	m,a		;; 01d6: 77          w
	mvi	a,002h		;; 01d7: 3e 02       >.
	inx	h		;; 01d9: 23          #
	mov	m,a		;; 01da: 77          w
	inx	h		;; 01db: 23          #
	mov	m,a		;; 01dc: 77          w
	inx	h		;; 01dd: 23          #
	mov	m,a		;; 01de: 77          w
	lda	0006dh		;; 01df: 3a 6d 00    :m.
	sui	'0'		;; 01e2: d6 30       .0
	inx	h		;; 01e4: 23          #
	mov	m,a		;; 01e5: 77          w
	adi	'0'		;; 01e6: c6 30       .0
	inx	h		;; 01e8: 23          #
	mov	m,a		;; 01e9: 77          w
	mvi	b,003h		;; 01ea: 06 03       ..
	xra	a		;; 01ec: af          .
L01ed:	out	002h	; WD1943 - baud select
	nop			;; 01ef: 00          .
	nop			;; 01f0: 00          .
	dcr	b		;; 01f1: 05          .
	jnz	L01ed		;; 01f2: c2 ed 01    ...
	mvi	a,040h		;; 01f5: 3e 40       >@
	out	002h		;; 01f7: d3 02       ..
	nop			;; 01f9: 00          .
	nop			;; 01fa: 00          .
	nop			;; 01fb: 00          .
	nop			;; 01fc: 00          .
	nop			;; 01fd: 00          .
	mvi	a,0feh		;; 01fe: 3e fe       >.
	out	002h		;; 0200: d3 02       ..
	nop			;; 0202: 00          .
	nop			;; 0203: 00          .
	nop			;; 0204: 00          .
	nop			;; 0205: 00          .
	nop			;; 0206: 00          .
	mvi	a,037h		;; 0207: 3e 37       >7
	out	002h		;; 0209: d3 02       ..
	nop			;; 020b: 00          .
	nop			;; 020c: 00          .

; network ready - success: init and finish
netrdy:	mvi	c,077h	; init from net vec blk
	call	00005h		;; 020f: cd 05 00    ...
	lxi	d,L0466	; "NET READY"
	mvi	c,009h		;; 0215: 0e 09       ..
	call	00005h		;; 0217: cd 05 00    ...
	jmp	00000h		;; 021a: c3 00 00    ...

L021d:	mvi	a,0f6h		;; 021d: 3e f6       >.
	mov	m,a		;; 021f: 77          w
	inx	h		;; 0220: 23          #
	mov	m,a		;; 0221: 77          w
	inx	h		;; 0222: 23          #
	mov	m,a		;; 0223: 77          w
	inx	h		;; 0224: 23          #
	mov	m,a		;; 0225: 77          w
	mvi	a,0f4h		;; 0226: 3e f4       >.
	inx	h		;; 0228: 23          #
	mov	m,a		;; 0229: 77          w
	inx	h		;; 022a: 23          #
	mov	m,a		;; 022b: 77          w
	inx	h		;; 022c: 23          #
	mov	m,a		;; 022d: 77          w
	mvi	a,0f4h		;; 022e: 3e f4       >.
	inx	h		;; 0230: 23          #
	mov	m,a		;; 0231: 77          w
	mvi	a,004h		;; 0232: 3e 04       >.
	inx	h		;; 0234: 23          #
	mov	m,a		;; 0235: 77          w
	mvi	a,001h		;; 0236: 3e 01       >.
	inx	h		;; 0238: 23          #
	mov	m,a		;; 0239: 77          w
	inx	h		;; 023a: 23          #
	mov	m,a		;; 023b: 77          w
	inx	h		;; 023c: 23          #
	mov	m,a		;; 023d: 77          w
	lda	0006dh		;; 023e: 3a 6d 00    :m.
	sui	030h		;; 0241: d6 30       .0
	inx	h		;; 0243: 23          #
	mov	m,a		;; 0244: 77          w
	adi	030h		;; 0245: c6 30       .0
	inx	h		;; 0247: 23          #
	mov	m,a		;; 0248: 77          w
	mvi	a,00fh		;; 0249: 3e 0f       >.
	out	0e9h		;; 024b: d3 e9       ..
	lxi	h,L0457		;; 024d: 21 57 04    .W.
L0250:	mov	a,m		;; 0250: 7e          ~
	cpi	0ffh		;; 0251: fe ff       ..
	jz	L025c		;; 0253: ca 5c 02    .\.
	out	0f6h		;; 0256: d3 f6       ..
	inx	h		;; 0258: 23          #
	jmp	L0250		;; 0259: c3 50 02    .P.

L025c:	in	0f6h		;; 025c: db f6       ..
	ani	001h		;; 025e: e6 01       ..
	jz	L0268		;; 0260: ca 68 02    .h.
	in	0f4h		;; 0263: db f4       ..
	jmp	L025c		;; 0265: c3 5c 02    .\.

L0268:	mvi	c,06eh	; func 110 - gatekeeper info
	call	00005h		;; 026a: cd 05 00    ...
	cpi	07bh		;; 026d: fe 7b       .{
	jz	L034a		;; 026f: ca 4a 03    .J.
	mvi	c,077h	; init from net vec blk
	call	00005h		;; 0274: cd 05 00    ...
	mvi	a,030h		;; 0277: 3e 30       >0
	out	0f6h		;; 0279: d3 f6       ..
	mvi	a,005h		;; 027b: 3e 05       >.
	out	0f6h		;; 027d: d3 f6       ..
	mvi	a,06ah		;; 027f: 3e 6a       >j
	out	0f6h		;; 0281: d3 f6       ..
	jmp	L0308		;; 0283: c3 08 03    ...

L0286:	out	069h		;; 0286: d3 69       .i

; fill-in network vector block for KAYPRO
;	6,6,6,4,4,4,4,1,1,1,nid,1,
kaypro:	mvi	a,006h		;; 0288: 3e 06       >.
	mov	m,a	; +0: ctl/sts port
	inx	h		;; 028b: 23          #
	mov	m,a	; +1:
	inx	h		;; 028d: 23          #
	mov	m,a	; +2:
	inx	h		;; 028f: 23          #
	mov	m,a	; +3:
	mvi	a,004h		;; 0291: 3e 04       >.
	inx	h		;; 0293: 23          #
	mov	m,a	; +4: input data port
	inx	h		;; 0295: 23          #
	mov	m,a	; +5:
	inx	h		;; 0297: 23          #
	mov	m,a	; +6:
	mvi	a,004h		;; 0299: 3e 04       >.
	inx	h		;; 029b: 23          #
	mov	m,a	; +7: output data port
	mvi	a,004h		;; 029d: 3e 04       >.
	inx	h		;; 029f: 23          #
	mov	m,a	; +8: TxE mask
	mvi	a,001h		;; 02a1: 3e 01       >.
	inx	h		;; 02a3: 23          #
	mov	m,a	; +9: RxA mask
	inx	h		;; 02a5: 23          #
	mov	m,a	; +10:
	inx	h		;; 02a7: 23          #
	mov	m,a	; +11:
	lda	0006dh		;; 02a9: 3a 6d 00    :m.
	sui	'0'		;; 02ac: d6 30       .0
	inx	h		;; 02ae: 23          #
	shld	nidptr		;; 02af: 22 8a 03    "..
	mov	m,a	; +12: node id (binary)
	inx	h		;; 02b3: 23          #
	xra	a		;; 02b4: af          .
	mvi	a,001h		;; 02b5: 3e 01       >.
	mov	m,a	; +13: flag (std DTR)
	; SIO...
	mvi	a,004h	; WR4
	out	006h		;; 02ba: d3 06       ..
	mvi	a,00fh	; 1x clock, 8-bit sync, 2 stop, even parity
	out	006h		;; 02be: d3 06       ..
	mvi	a,00fh	; baud... 19.2K (WD1943 @ 5.0688MHz)
	out	000h		;; 02c2: d3 00       ..

	; re-init SIO...
	lxi	h,L0457		;; 02c4: 21 57 04    .W.
L02c7:	mov	a,m		;; 02c7: 7e          ~
	cpi	0ffh		;; 02c8: fe ff       ..
	jz	flush		;; 02ca: ca d3 02    ...
	out	006h		;; 02cd: d3 06       ..
	inx	h		;; 02cf: 23          #
	jmp	L02c7		;; 02d0: c3 c7 02    ...

; runout any chars in SIO fifo
flush:	in	006h		;; 02d3: db 06       ..
	ani	001h		;; 02d5: e6 01       ..
	jz	L02df		;; 02d7: ca df 02    ...
	in	004h		;; 02da: db 04       ..
	jmp	flush		;; 02dc: c3 d3 02    ...

L02df:	mvi	c,06eh	; 110 - return gatekeeper info (HL=GTAB)
	call	00005h		;; 02e1: cd 05 00    ...
	cpi	07bh	; 123 == gatekeeper
	jz	L034a		;; 02e6: ca 4a 03    .J.
	; kaypro workstation node...
	mvi	c,077h	; 119 - init from net vec blk
	call	00005h		;; 02eb: cd 05 00    ...
	mvi	a,030h	; error reset
L02f0:	out	006h		;; 02f0: d3 06       ..
	mvi	a,005h		;; 02f2: 3e 05       >.
L02f4:	out	006h		;; 02f4: d3 06       ..
	mvi	a,06ah	; DTR off
L02f8:	out	006h		;; 02f8: d3 06       ..
	mvi	a,003h		;; 02fa: 3e 03       >.
L02fc:	dcr	a		;; 02fc: 3d          =
	jnz	L02fc		;; 02fd: c2 fc 02    ...
	mvi	a,005h	; WR5
L0302:	out	006h		;; 0302: d3 06       ..
	mvi	a,0eah	; DTR on
L0306:	out	006h		;; 0306: d3 06       ..
L0308:	mvi	c,062h	; 98 - get node GUID?
	call	00005h		;; 030a: cd 05 00    ...
	; should return HL = (L0203 + (L0205 << 8))
	mvi	a,002h		;; 030d: 3e 02       >.
	mvi	c,07ch	; 124 - send packet
	shld	L0471+10	; send GTAB in packet (filled in by resp?)
	lxi	h,L0471		;; 0314: 21 71 04    .q.
	call	00005h		;; 0317: cd 05 00    ...
L031a:	mvi	c,07dh	; 125 - recv packet
	call	00005h		;; 031c: cd 05 00    ...
	cpi	001h		;; 031f: fe 01       ..
	jz	L031a	; keep recving?
	cpi	002h		;; 0324: fe 02       ..
	jnz	L038c	; recv OK?
	lda	retry		;; 0329: 3a 70 04    :p.
	inr	a		;; 032c: 3c          <
	sta	retry		;; 032d: 32 70 04    2p.
	cpi	005h		;; 0330: fe 05       ..
	jnz	L0308	; send again
	lxi	d,L03de	; "Gatekeeper unavailable"
; DE=error message, deinit (node id = 0) and finish
neterr:	lhld	nidptr		;; 0338: 2a 8a 03    *..
	xra	a		;; 033b: af          .
	mov	m,a		;; 033c: 77          w
	mvi	c,077h	; 119 - init from net vec blk
	call	00005h		;; 033f: cd 05 00    ...
	mvi	c,009h		;; 0342: 0e 09       ..
	call	00005h		;; 0344: cd 05 00    ...
	jmp	00000h		;; 0347: c3 00 00    ...

; we are a kaypro gatekeeper
L034a:	lhld	nidptr		;; 034a: 2a 8a 03    *..
	mvi	a,'G'-'0'	;; 034d: 3e 17       >.
	mov	m,a		;; 034f: 77          w
	mvi	c,077h	; 119 - init from net vec blk
	call	00005h		;; 0352: cd 05 00    ...
	mvi	a,030h	; err reset
L0357:	out	006h		;; 0357: d3 06       ..
	mvi	a,005h	; WR5
L035b:	out	006h		;; 035b: d3 06       ..
	mvi	a,06ah	; DTR off
L035f:	out	006h		;; 035f: d3 06       ..
	mvi	c,07ch	; 124 - send packet
	lxi	h,L0471		;; 0363: 21 71 04    .q.
	call	00005h		;; 0366: cd 05 00    ...
	lxi	d,L0374	; "Gatekeeper running"
	mvi	c,009h		;; 036c: 0e 09       ..
	call	00005h		;; 036e: cd 05 00    ...
	jmp	00000h		;; 0371: c3 00 00    ...

L0374:	db	'Gatekeeper running...$'

nidptr:	db	0,0	; ptr to node id in net vec blk (in OS)

; response recv'ed OK
L038c:	lxi	d,7		;; 038c: 11 07 00    ...
	dad	d		;; 038f: 19          .
	mov	a,m		;; 0390: 7e          ~
	cpi	'o'		;; 0391: fe 6f       .o
	jz	L03a1	; node in use
	cpi	'q'		;; 0396: fe 71       .q
	jz	netrdy	; success!
	lxi	d,L03ad	; "Authorization error"
	jmp	neterr		;; 039e: c3 38 03    .8.

L03a1:	lda	0006dh		;; 03a1: 3a 6d 00    :m.
	sta	L03cd		;; 03a4: 32 cd 03    2..
	lxi	d,L03c3	; "Node id X already in use"
	jmp	neterr		;; 03aa: c3 38 03    .8.

L03ad:	db	'? Authorization error$'
L03c3:	db	'? Node id '
L03cd:	db	'X already in use$'
L03de:	db	'? Gatekeeper unavailable$'

	mvi	a,0feh		;; 03f7: 3e fe       >.
	mov	m,a		;; 03f9: 77          w
	inx	h		;; 03fa: 23          #
	mov	m,a		;; 03fb: 77          w
	inx	h		;; 03fc: 23          #
	mov	m,a		;; 03fd: 77          w
	inx	h		;; 03fe: 23          #
	mov	m,a		;; 03ff: 77          w
	mvi	a,0fch		;; 0400: 3e fc       >.
	inx	h		;; 0402: 23          #
	mov	m,a		;; 0403: 77          w
	inx	h		;; 0404: 23          #
	mov	m,a		;; 0405: 77          w
	inx	h		;; 0406: 23          #
	mov	m,a		;; 0407: 77          w
	mvi	a,0fch		;; 0408: 3e fc       >.
	inx	h		;; 040a: 23          #
	mov	m,a		;; 040b: 77          w
	mvi	a,004h		;; 040c: 3e 04       >.
	inx	h		;; 040e: 23          #
	mov	m,a		;; 040f: 77          w
	mvi	a,001h		;; 0410: 3e 01       >.
	inx	h		;; 0412: 23          #
	mov	m,a		;; 0413: 77          w
	inx	h		;; 0414: 23          #
	mov	m,a		;; 0415: 77          w
	inx	h		;; 0416: 23          #
	mov	m,a		;; 0417: 77          w
	lda	0006dh		;; 0418: 3a 6d 00    :m.
	sui	030h		;; 041b: d6 30       .0
	inx	h		;; 041d: 23          #
	mov	m,a		;; 041e: 77          w
	adi	030h		;; 041f: c6 30       .0
	inx	h		;; 0421: 23          #
	mov	m,a		;; 0422: 77          w
	lxi	h,L0457		;; 0423: 21 57 04    .W.
L0426:	mov	a,m		;; 0426: 7e          ~
	cpi	0ffh		;; 0427: fe ff       ..
	jz	L0434		;; 0429: ca 34 04    .4.
	out	0feh		;; 042c: d3 fe       ..
	out	0ffh		;; 042e: d3 ff       ..
	inx	h		;; 0430: 23          #
	jmp	L0426		;; 0431: c3 26 04    .&.

L0434:	in	0feh		;; 0434: db fe       ..
	ani	001h		;; 0436: e6 01       ..
	jz	L0440		;; 0438: ca 40 04    .@.
	in	0fch		;; 043b: db fc       ..
	jmp	L0434		;; 043d: c3 34 04    .4.

L0440:	mvi	a,030h		;; 0440: 3e 30       >0
	out	0feh		;; 0442: d3 fe       ..
	mvi	a,005h		;; 0444: 3e 05       >.
	out	0feh		;; 0446: d3 fe       ..
	mvi	a,06ah		;; 0448: 3e 6a       >j
	out	0feh		;; 044a: d3 fe       ..
	mvi	a,005h		;; 044c: 3e 05       >.
	out	0ffh		;; 044e: d3 ff       ..
	mvi	a,0eah		;; 0450: 3e ea       >.
	out	0ffh		;; 0452: d3 ff       ..
	jmp	netrdy		;; 0454: c3 0d 02    ...

; standard SIO init for KayNet
L0457:	db	0,0,30h	; err reset
	db	1,0	; no interrupts
	db	4,0fh	; 1x clock, 2 stop, even parity
	db	5,0eah	; DTR, 8 bits, Tx ena, RTS
	db	3,0c1h	; Rx 8, Rx ena
	db	10h,10h,30h	; resets
	db	0ffh

L0466:	db	'NET READY$'

retry:	db	0

; gatekeeper sends this but expects no response (forces loopback)
; workstations send this and expect 071h in response
L0471:	db	0
	db	'G'-'0'	; destination node - gatekeeper
	db	0,0,0,0,0
	db	6eh	; func 110 - get gatekeeper info
	db	2,0
	dw	1	; GTAB if workstation...
	db	0,0,0

	end

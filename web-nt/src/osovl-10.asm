	maclib	z80

	org	0c100h
	lhld	00001h		;; c100: 2a 01 00    *..
	shld	Ld7c7		;; c103: 22 c7 d7    "..
	inx	h		;; c106: 23          #
	mov	e,m		;; c107: 5e          ^
	inx	h		;; c108: 23          #
	mov	d,m		;; c109: 56          V
	sded	Ld7cd		;; c10a: ed 53 cd d7 .S..
	inx	h		;; c10e: 23          #
	inx	h		;; c10f: 23          #
	mov	e,m		;; c110: 5e          ^
	inx	h		;; c111: 23          #
	mov	d,m		;; c112: 56          V
	sded	Ld7d0		;; c113: ed 53 d0 d7 .S..
	inx	h		;; c117: 23          #
	inx	h		;; c118: 23          #
	mov	e,m		;; c119: 5e          ^
	inx	h		;; c11a: 23          #
	mov	d,m		;; c11b: 56          V
	sded	Ld7d3		;; c11c: ed 53 d3 d7 .S..
	lxi	d,Lcfe6		;; c120: 11 e6 cf    ...
	mov	m,d		;; c123: 72          r
	dcx	h		;; c124: 2b          +
	mov	m,e		;; c125: 73          s
	dcx	h		;; c126: 2b          +
	dcx	h		;; c127: 2b          +
	lxi	d,Lcff0		;; c128: 11 f0 cf    ...
	mov	m,d		;; c12b: 72          r
	dcx	h		;; c12c: 2b          +
	mov	m,e		;; c12d: 73          s
	dcx	h		;; c12e: 2b          +
	dcx	h		;; c12f: 2b          +
	lxi	d,Ld109		;; c130: 11 09 d1    ...
	mov	m,d		;; c133: 72          r
	dcx	h		;; c134: 2b          +
	mov	m,e		;; c135: 73          s
	lhld	00006h		;; c136: 2a 06 00    *..
	shld	Ld7ca		;; c139: 22 ca d7    "..
	jmp	Ld11d		;; c13c: c3 1d d1    ...

	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
Lc206:	pushix			;; c206: dd e5       ..
	sspd	Ld785		;; c208: ed 73 85 d7 .s..
	lxi	sp,Ld7c7	;; c20c: 31 c7 d7    1..
	mov	a,c		;; c20f: 79          y
	sta	Ld5ec		;; c210: 32 ec d5    2..
	sded	Ld5ed		;; c213: ed 53 ed d5 .S..
	call	Lcff0		;; c217: cd f0 cf    ...
	lda	Ld5ec		;; c21a: 3a ec d5    :..
	ora	a		;; c21d: b7          .
	jz	Ld109		;; c21e: ca 09 d1    ...
	cpi	00dh		;; c221: fe 0d       ..
	jc	Lcc50		;; c223: da 50 cc    .P.
	cpi	02ch		;; c226: fe 2c       .,
	jrnc	Lc243		;; c228: 30 19       0.
	sui	00dh		;; c22a: d6 0d       ..
	lxix	Ld611		;; c22c: dd 21 11 d6 ....
	lxi	h,Lcf3d		;; c230: 21 3d cf    .=.
	jmp	Lc3d2		;; c233: c3 d2 c3    ...

Lc236:	lxi	h,00000h	;; c236: 21 00 00    ...
Lc239:	mov	a,l		;; c239: 7d          }
Lc23a:	mov	l,a		;; c23a: 6f          o
	mov	b,h		;; c23b: 44          D
	lspd	Ld785		;; c23c: ed 7b 85 d7 .{..
	popix			;; c240: dd e1       ..
	ret			;; c242: c9          .

Lc243:	sui	0c8h		;; c243: d6 c8       ..
	jrc	Lc236		;; c245: 38 ef       8.
	cpi	00ah		;; c247: fe 0a       ..
	jrnc	Lc236		;; c249: 30 eb       0.
	lxi	h,Lcf7b		;; c24b: 21 7b cf    .{.
	jmp	Lc3d2		;; c24e: c3 d2 c3    ...

Lc251:	lxi	h,Ld5b5		;; c251: 21 b5 d5    ...
	jr	Lc239		;; c254: 18 e3       ..

Lc256:	lxi	h,Ld5f1		;; c256: 21 f1 d5    ...
	jr	Lc239		;; c259: 18 de       ..

Lc25b:	lxi	h,Ld580		;; c25b: 21 80 d5    ...
	jr	Lc239		;; c25e: 18 d9       ..

Lc260:	lda	Ld5ed		;; c260: 3a ed d5    :..
	inr	a		;; c263: 3c          <
	jz	Lcd05		;; c264: ca 05 cd    ...
	mvi	a,020h		;; c267: 3e 20       > 
	sta	Ld5ec		;; c269: 32 ec d5    2..
	jmp	Lcd1b		;; c26c: c3 1b cd    ...

Lc26f:	lhld	Ld5ed		;; c26f: 2a ed d5    *..
	call	Ld286		;; c272: cd 86 d2    ...
	jr	Lc23a		;; c275: 18 c3       ..

Lc277:	lhld	Ld5ed		;; c277: 2a ed d5    *..
	call	Ld0cf		;; c27a: cd cf d0    ...
	jrz	Lc236		;; c27d: 28 b7       (.
	inx	h		;; c27f: 23          #
	inx	h		;; c280: 23          #
	inx	h		;; c281: 23          #
	jr	Lc239		;; c282: 18 b5       ..

Lc284:	call	Ld04c		;; c284: cd 4c d0    .L.
	jr	Lc23a		;; c287: 18 b1       ..

Lc289:	call	Ld530		;; c289: cd 30 d5    .0.
	jr	Lc23a		;; c28c: 18 ac       ..

Lc28e:	call	Ld106		;; c28e: cd 06 d1    ...
	jr	Lc23a		;; c291: 18 a7       ..

Lc293:	lxi	d,Lcf04		;; c293: 11 04 cf    ...
	call	Lc861		;; c296: cd 61 c8    .a.
	lxi	h,Ld5f1		;; c299: 21 f1 d5    ...
	lxi	b,01040h	;; c29c: 01 40 10    .@.
Lc29f:	inr	c		;; c29f: 0c          .
	inx	h		;; c2a0: 23          #
	mov	a,m		;; c2a1: 7e          ~
	ora	a		;; c2a2: b7          .
	jrz	Lc2cf		;; c2a3: 28 2a       (*
	mov	a,c		;; c2a5: 79          y
	call	Lc2e4		;; c2a6: cd e4 c2    ...
	lxi	d,Lcf31		;; c2a9: 11 31 cf    .1.
	call	Lc2d5		;; c2ac: cd d5 c2    ...
	mov	a,m		;; c2af: 7e          ~
	adi	040h		;; c2b0: c6 40       .@
	call	Lc2e4		;; c2b2: cd e4 c2    ...
	mvi	a,03ah		;; c2b5: 3e 3a       >:
	call	Lc2e4		;; c2b7: cd e4 c2    ...
	dcx	h		;; c2ba: 2b          +
	mov	a,m		;; c2bb: 7e          ~
	cpi	0ffh		;; c2bc: fe ff       ..
	jrnz	Lc2c8		;; c2be: 20 08        .
	lxi	d,Lcf36		;; c2c0: 11 36 cf    .6.
	call	Lc2d5		;; c2c3: cd d5 c2    ...
	jr	Lc2cb		;; c2c6: 18 03       ..

Lc2c8:	call	Lc38d		;; c2c8: cd 8d c3    ...
Lc2cb:	call	Lc2dd		;; c2cb: cd dd c2    ...
	inx	h		;; c2ce: 23          #
Lc2cf:	inx	h		;; c2cf: 23          #
	djnz	Lc29f		;; c2d0: 10 cd       ..
	jmp	Lc23a		;; c2d2: c3 3a c2    .:.

Lc2d5:	push	b		;; c2d5: c5          .
	push	h		;; c2d6: e5          .
	call	Lc861		;; c2d7: cd 61 c8    .a.
	pop	h		;; c2da: e1          .
	pop	b		;; c2db: c1          .
	ret			;; c2dc: c9          .

Lc2dd:	mvi	a,00dh		;; c2dd: 3e 0d       >.
	call	Lc2e4		;; c2df: cd e4 c2    ...
	mvi	a,00ah		;; c2e2: 3e 0a       >.
Lc2e4:	push	b		;; c2e4: c5          .
	mvi	c,002h		;; c2e5: 0e 02       ..
	ani	07fh		;; c2e7: e6 7f       ..
	mov	e,a		;; c2e9: 5f          _
	push	h		;; c2ea: e5          .
	call	Ld7c9		;; c2eb: cd c9 d7    ...
	pop	h		;; c2ee: e1          .
	pop	b		;; c2ef: c1          .
	ret			;; c2f0: c9          .

Lc2f1:	shld	Ld5ad		;; c2f1: 22 ad d5    "..
	lxi	b,00009h	;; c2f4: 01 09 00    ...
	dad	b		;; c2f7: 09          .
	mov	a,m		;; c2f8: 7e          ~
	cpi	010h		;; c2f9: fe 10       ..
	jz	Lc304		;; c2fb: ca 04 c3    ...
	cpi	020h		;; c2fe: fe 20       . 
	jz	Lc3bc		;; c300: ca bc c3    ...
	ret			;; c303: c9          .

Lc304:	lda	Ld5b4		;; c304: 3a b4 d5    :..
	ora	a		;; c307: b7          .
	rz			;; c308: c8          .
	pushix			;; c309: dd e5       ..
	lixd	Ld5ad		;; c30b: dd 2a ad d5 .*..
	inx	h		;; c30f: 23          #
	inx	h		;; c310: 23          #
	push	h		;; c311: e5          .
	mvi	c,009h		;; c312: 0e 09       ..
	lxi	d,Lc367		;; c314: 11 67 c3    .g.
	call	Ld7c9		;; c317: cd c9 d7    ...
	ldx	a,+3		;; c31a: dd 7e 03    .~.
	cpi	0ffh		;; c31d: fe ff       ..
	jrz	Lc326		;; c31f: 28 05       (.
	call	Lc38d		;; c321: cd 8d c3    ...
	jr	Lc32e		;; c324: 18 08       ..

Lc326:	mvi	c,009h		;; c326: 0e 09       ..
	lxi	d,Lc376		;; c328: 11 76 c3    .v.
	call	Ld7c9		;; c32b: cd c9 d7    ...
Lc32e:	mvi	c,009h		;; c32e: 0e 09       ..
	lxi	d,Lc37a		;; c330: 11 7a c3    .z.
	call	Ld7c9		;; c333: cd c9 d7    ...
	ldx	a,+6		;; c336: dd 7e 06    .~.
	call	Lc38d		;; c339: cd 8d c3    ...
	mvi	c,009h		;; c33c: 0e 09       ..
	lxi	d,Lc381		;; c33e: 11 81 c3    ...
	call	Ld7c9		;; c341: cd c9 d7    ...
	pop	h		;; c344: e1          .
	mov	b,m		;; c345: 46          F
	mvi	m,001h		;; c346: 36 01       6.
	mvi	c,002h		;; c348: 0e 02       ..
Lc34a:	inx	h		;; c34a: 23          #
	mov	e,m		;; c34b: 5e          ^
	push	h		;; c34c: e5          .
	push	b		;; c34d: c5          .
	call	Ld7c9		;; c34e: cd c9 d7    ...
	pop	b		;; c351: c1          .
	pop	h		;; c352: e1          .
	djnz	Lc34a		;; c353: 10 f5       ..
	mvi	c,009h		;; c355: 0e 09       ..
	lxi	d,Lc386		;; c357: 11 86 c3    ...
	call	Ld7c9		;; c35a: cd c9 d7    ...
	ldx	a,+3		;; c35d: dd 7e 03    .~.
	inr	a		;; c360: 3c          <
	cnz	Lc3a3		;; c361: c4 a3 c3    ...
	popix			;; c364: dd e1       ..
	ret			;; c366: c9          .

Lc367:	db	7,0dh,0ah,'Message to $'
Lc376:	db	'all$'
Lc37a:	db	' from $'
Lc381:	db	':',0dh,0ah,9,'$'
Lc386:	db	0dh,0ah,'... $'
Lc38d:	push	psw		;; c38d: f5          .
	rrc			;; c38e: 0f          .
	rrc			;; c38f: 0f          .
	rrc			;; c390: 0f          .
	rrc			;; c391: 0f          .
	call	Lc396		;; c392: cd 96 c3    ...
	pop	psw		;; c395: f1          .
Lc396:	ani	00fh		;; c396: e6 0f       ..
	cpi	00ah		;; c398: fe 0a       ..
	jrc	Lc39e		;; c39a: 38 02       8.
	adi	007h		;; c39c: c6 07       ..
Lc39e:	adi	030h		;; c39e: c6 30       .0
	jmp	Lc2e4		;; c3a0: c3 e4 c2    ...

Lc3a3:	ldx	a,+6		;; c3a3: dd 7e 06    .~.
	stx	a,+3		;; c3a6: dd 77 03    .w.
	lda	Ld5b3		;; c3a9: 3a b3 d5    :..
	stx	a,+6		;; c3ac: dd 77 06    .w.
	setx	0,+9		;; c3af: dd cb 09 c6 ....
	lhld	Ld5ad		;; c3b3: 2a ad d5    *..
	inx	h		;; c3b6: 23          #
	inx	h		;; c3b7: 23          #
	inx	h		;; c3b8: 23          #
	jmp	Ld286		;; c3b9: c3 86 d2    ...

Lc3bc:	pushix			;; c3bc: dd e5       ..
	lixd	Ld5ad		;; c3be: dd 2a ad d5 .*..
	ldx	a,+12		;; c3c2: dd 7e 0c    .~.
	sui	00fh		;; c3c5: d6 0f       ..
	jc	Lc48c		;; c3c7: da 8c c4    ...
	cpi	01dh		;; c3ca: fe 1d       ..
	jnc	Lc48c		;; c3cc: d2 8c c4    ...
	lxi	h,Lc65a		;; c3cf: 21 5a c6    .Z.
Lc3d2:	add	a		;; c3d2: 87          .
	mov	e,a		;; c3d3: 5f          _
	mvi	d,000h		;; c3d4: 16 00       ..
	dad	d		;; c3d6: 19          .
	mov	e,m		;; c3d7: 5e          ^
	inx	h		;; c3d8: 23          #
	mov	d,m		;; c3d9: 56          V
	xchg			;; c3da: eb          .
	pchl			;; c3db: e9          .

Lc3dc:	mvi	c,020h		;; c3dc: 0e 20       . 
	ldx	e,+13		;; c3de: dd 5e 0d    .^.
	jmp	Ld7c9		;; c3e1: c3 c9 d7    ...

Lc3e4:	lhld	Ld5ad		;; c3e4: 2a ad d5    *..
	lxi	d,0000fh	;; c3e7: 11 0f 00    ...
	dad	d		;; c3ea: 19          .
	xchg			;; c3eb: eb          .
	ret			;; c3ec: c9          .

Lc3ed:	mvi	c,020h		;; c3ed: 0e 20       . 
	lda	Ld5b0		;; c3ef: 3a b0 d5    :..
	mov	e,a		;; c3f2: 5f          _
	jmp	Ld7c9		;; c3f3: c3 c9 d7    ...

Lc3f6:	mvi	c,01ah		;; c3f6: 0e 1a       ..
	lhld	Ld5ad		;; c3f8: 2a ad d5    *..
	lxi	d,00033h	;; c3fb: 11 33 00    .3.
	dad	d		;; c3fe: 19          .
	xchg			;; c3ff: eb          .
	jmp	Ld7c9		;; c400: c3 c9 d7    ...

Lc403:	mvi	c,01ah		;; c403: 0e 1a       ..
	lded	Ld5b1		;; c405: ed 5b b1 d5 .[..
	jmp	Ld7c9		;; c409: c3 c9 d7    ...

Lc40c:	call	Lc3e4		;; c40c: cd e4 c3    ...
Lc40f:	ldx	c,+12		;; c40f: dd 4e 0c    .N.
	call	Ld7c9		;; c412: cd c9 d7    ...
	stx	a,+14		;; c415: dd 77 0e    .w.
	ret			;; c418: c9          .

Lc419:	mvi	c,019h		;; c419: 0e 19       ..
	call	Ld7c9		;; c41b: cd c9 d7    ...
	sta	Ld5b6		;; c41e: 32 b6 d5    2..
	ldx	e,+14		;; c421: dd 5e 0e    .^.
	mvi	c,00eh		;; c424: 0e 0e       ..
	jmp	Ld7c9		;; c426: c3 c9 d7    ...

Lc429:	lda	Ld5b6		;; c429: 3a b6 d5    :..
	mov	e,a		;; c42c: 5f          _
	mvi	c,00eh		;; c42d: 0e 0e       ..
	jmp	Ld7c9		;; c42f: c3 c9 d7    ...

Lc432:	call	Lc3dc		;; c432: cd dc c3    ...
	call	Lc3f6		;; c435: cd f6 c3    ...
Lc438:	call	Lc3e4		;; c438: cd e4 c3    ...
	mvi	c,011h		;; c43b: 0e 11       ..
	call	Ld7c9		;; c43d: cd c9 d7    ...
Lc440:	cpi	0ffh		;; c440: fe ff       ..
	rz			;; c442: c8          .
	add	a		;; c443: 87          .
	add	a		;; c444: 87          .
	add	a		;; c445: 87          .
	add	a		;; c446: 87          .
	add	a		;; c447: 87          .
	lhld	Ld5ad		;; c448: 2a ad d5    *..
	lxi	d,00033h	;; c44b: 11 33 00    .3.
	dad	d		;; c44e: 19          .
	mov	e,a		;; c44f: 5f          _
	mvi	d,000h		;; c450: 16 00       ..
	dad	d		;; c452: 19          .
	inr	a		;; c453: 3c          <
	ret			;; c454: c9          .

Lc455:	call	Lc432		;; c455: cd 32 c4    .2.
	jrz	Lc49f		;; c458: 28 45       (E
	mov	d,h		;; c45a: 54          T
	mov	e,l		;; c45b: 5d          ]
	inx	h		;; c45c: 23          #
	bit	7,m		;; c45d: cb 7e       .~
	jrnz	Lc495		;; c45f: 20 34        4
	inx	h		;; c461: 23          #
	bit	7,m		;; c462: cb 7e       .~
	jrz	Lc473		;; c464: 28 0d       (.
	inx	h		;; c466: 23          #
	bit	7,m		;; c467: cb 7e       .~
	jrnz	Lc49b		;; c469: 20 30        0
	setb	7,m		;; c46b: cb fe       ..
	call	Lc4a9		;; c46d: cd a9 c4    ...
	call	Lc6e6		;; c470: cd e6 c6    ...
Lc473:	call	Lc40c		;; c473: cd 0c c4    ...
Lc476:	mvix	027h,+11	;; c476: dd 36 0b 27 .6.'
Lc47a:	call	Lc403		;; c47a: cd 03 c4    ...
Lc47d:	call	Lc3ed		;; c47d: cd ed c3    ...
Lc480:	call	Lc3a3		;; c480: cd a3 c3    ...
	ldx	a,+3		;; c483: dd 7e 03    .~.
	sta	Ld5af		;; c486: 32 af d5    2..
	call	Lc516		;; c489: cd 16 c5    ...
Lc48c:	popix			;; c48c: dd e1       ..
	ret			;; c48e: c9          .

Lc48f:	mvix	012h,+8		;; c48f: dd 36 08 12 .6..
	jr	Lc49f		;; c493: 18 0a       ..

Lc495:	mvix	011h,+8		;; c495: dd 36 08 11 .6..
	jr	Lc49f		;; c499: 18 04       ..

Lc49b:	mvix	010h,+8		;; c49b: dd 36 08 10 .6..
Lc49f:	mvix	0ffh,+14	;; c49f: dd 36 0e ff .6..
Lc4a3:	mvix	003h,+11	;; c4a3: dd 36 0b 03 .6..
	jr	Lc47a		;; c4a7: 18 d1       ..

Lc4a9:	ldx	a,+15		;; c4a9: dd 7e 0f    .~.
	stax	d		;; c4ac: 12          .
	mvi	c,01eh		;; c4ad: 0e 1e       ..
	jmp	Ld7c9		;; c4af: c3 c9 d7    ...

Lc4b2:	pop	b		;; c4b2: c1          .
	inx	h		;; c4b3: 23          #
	bit	7,m		;; c4b4: cb 7e       .~
	jrnz	Lc495		;; c4b6: 20 dd        .
	inx	h		;; c4b8: 23          #
	inx	h		;; c4b9: 23          #
	bit	7,m		;; c4ba: cb 7e       .~
	jrnz	Lc49b		;; c4bc: 20 dd        .
	lxi	d,00006h	;; c4be: 11 06 00    ...
	dad	d		;; c4c1: 19          .
	bit	7,m		;; c4c2: cb 7e       .~
	jrnz	Lc48f		;; c4c4: 20 c9        .
	push	b		;; c4c6: c5          .
	ret			;; c4c7: c9          .

Lc4c8:	call	Lc432		;; c4c8: cd 32 c4    .2.
	jrz	Lc49f		;; c4cb: 28 d2       (.
	call	Lc4b2		;; c4cd: cd b2 c4    ...
	call	Lc3e4		;; c4d0: cd e4 c3    ...
	xchg			;; c4d3: eb          .
	call	Lca39		;; c4d4: cd 39 ca    .9.
	jrnz	Lc49f		;; c4d7: 20 c6        .
	call	Lc40c		;; c4d9: cd 0c c4    ...
	jr	Lc4a3		;; c4dc: 18 c5       ..

Lc4de:	call	Lc432		;; c4de: cd 32 c4    .2.
	jrz	Lc49f		;; c4e1: 28 bc       (.
Lc4e3:	call	Lc4b2		;; c4e3: cd b2 c4    ...
	mvi	c,012h		;; c4e6: 0e 12       ..
	call	Ld7c9		;; c4e8: cd c9 d7    ...
	call	Lc440		;; c4eb: cd 40 c4    .@.
	jrnz	Lc4e3		;; c4ee: 20 f3        .
	call	Lc40c		;; c4f0: cd 0c c4    ...
	jmp	Lc4a3		;; c4f3: c3 a3 c4    ...

Lc4f6:	mvi	b,008h		;; c4f6: 06 08       ..
	lxi	h,Ld5dc		;; c4f8: 21 dc d5    ...
Lc4fb:	mov	a,m		;; c4fb: 7e          ~
	cmp	c		;; c4fc: b9          .
	inx	h		;; c4fd: 23          #
	rz			;; c4fe: c8          .
	inx	h		;; c4ff: 23          #
	djnz	Lc4fb		;; c500: 10 f9       ..
	dcx	h		;; c502: 2b          +
	ret			;; c503: c9          .

Lc504:	push	h		;; c504: e5          .
	lxi	d,Ld5dd		;; c505: 11 dd d5    ...
	ora	a		;; c508: b7          .
	dsbc	d		;; c509: ed 52       .R
	pop	d		;; c50b: d1          .
	rz			;; c50c: c8          .
	mov	b,h		;; c50d: 44          D
	mov	c,l		;; c50e: 4d          M
	mov	h,d		;; c50f: 62          b
	mov	l,e		;; c510: 6b          k
	dcx	h		;; c511: 2b          +
	dcx	h		;; c512: 2b          +
	lddr			;; c513: ed b8       ..
	ret			;; c515: c9          .

Lc516:	mov	c,a		;; c516: 4f          O
	push	psw		;; c517: f5          .
	call	Lc4f6		;; c518: cd f6 c4    ...
	call	Lc504		;; c51b: cd 04 c5    ...
	pop	psw		;; c51e: f1          .
	lxi	h,Ld5dc		;; c51f: 21 dc d5    ...
	mov	m,a		;; c522: 77          w
	inx	h		;; c523: 23          #
	ldx	a,+10		;; c524: dd 7e 0a    .~.
	mov	m,a		;; c527: 77          w
	ret			;; c528: c9          .

Lc529:	ldx	c,+6		;; c529: dd 4e 06    .N.
	call	Lc4f6		;; c52c: cd f6 c4    ...
	jrnz	Lc53e		;; c52f: 20 0d        .
	mov	a,m		;; c531: 7e          ~
	cmpx	+10		;; c532: dd be 0a    ...
	jrnz	Lc53e		;; c535: 20 07        .
	mvix	001h,+8		;; c537: dd 36 08 01 .6..
	jmp	Lc49f		;; c53b: c3 9f c4    ...

Lc53e:	call	Lc3dc		;; c53e: cd dc c3    ...
	call	Lc3f6		;; c541: cd f6 c3    ...
	call	Lc40c		;; c544: cd 0c c4    ...
	bitx	7,+18		;; c547: dd cb 12 7e ...~
	jnz	Lc476		;; c54b: c2 76 c4    .v.
	setx	7,+18		;; c54e: dd cb 12 fe ....
	call	Lc438		;; c552: cd 38 c4    .8.
	jz	Lc476		;; c555: ca 76 c4    .v.
	mov	d,h		;; c558: 54          T
	mov	e,l		;; c559: 5d          ]
	inx	h		;; c55a: 23          #
	inx	h		;; c55b: 23          #
	inx	h		;; c55c: 23          #
	setb	7,m		;; c55d: cb fe       ..
	call	Lc4a9		;; c55f: cd a9 c4    ...
	call	Lc6e6		;; c562: cd e6 c6    ...
	jmp	Lc476		;; c565: c3 76 c4    .v.

Lc568:	call	Lc3dc		;; c568: cd dc c3    ...
	call	Lc40c		;; c56b: cd 0c c4    ...
	call	Lc432		;; c56e: cd 32 c4    .2.
	mov	d,h		;; c571: 54          T
	mov	e,l		;; c572: 5d          ]
	inx	h		;; c573: 23          #
	inx	h		;; c574: 23          #
	inx	h		;; c575: 23          #
	res	7,m		;; c576: cb be       ..
	call	Lc4a9		;; c578: cd a9 c4    ...
	call	Lc70b		;; c57b: cd 0b c7    ...
	jmp	Lc4a3		;; c57e: c3 a3 c4    ...

Lc581:	call	Lc3dc		;; c581: cd dc c3    ...
	call	Lc3f6		;; c584: cd f6 c3    ...
	call	Lc40c		;; c587: cd 0c c4    ...
	mvix	0a7h,+11	;; c58a: dd 36 0b a7 .6..
	jmp	Lc47a		;; c58e: c3 7a c4    .z.

Lc591:	call	Lc432		;; c591: cd 32 c4    .2.
	jnz	Lc49f		;; c594: c2 9f c4    ...
Lc597:	call	Lc3dc		;; c597: cd dc c3    ...
	call	Lc40c		;; c59a: cd 0c c4    ...
	mvix	027h,+11	;; c59d: dd 36 0b 27 .6.'
	jmp	Lc47d		;; c5a1: c3 7d c4    .}.

Lc5a4:	call	Lc419		;; c5a4: cd 19 c4    ...
	ldx	c,+12		;; c5a7: dd 4e 0c    .N.
	call	Ld7c9		;; c5aa: cd c9 d7    ...
	xchg			;; c5ad: eb          .
	lhld	Ld5ad		;; c5ae: 2a ad d5    *..
	lxi	b,0000fh	;; c5b1: 01 0f 00    ...
	dad	b		;; c5b4: 09          .
	mvix	012h,+11	;; c5b5: dd 36 0b 12 .6..
	xchg			;; c5b9: eb          .
	ldx	a,+12		;; c5ba: dd 7e 0c    .~.
	cpi	01fh		;; c5bd: fe 1f       ..
	jrz	Lc5c8		;; c5bf: 28 07       (.
	lxi	b,0008eh	;; c5c1: 01 8e 00    ...
	mvix	091h,+11	;; c5c4: dd 36 0b 91 .6..
Lc5c8:	ldir			;; c5c8: ed b0       ..
	call	Lc429		;; c5ca: cd 29 c4    .).
	jmp	Lc480		;; c5cd: c3 80 c4    ...

Lc5d0:	call	Lc64d		;; c5d0: cd 4d c6    .M.
	ldx	a,+15		;; c5d3: dd 7e 0f    .~.
	cpi	03fh		;; c5d6: fe 3f       .?
	push	psw		;; c5d8: f5          .
	cz	Lc419		;; c5d9: cc 19 c4    ...
	call	Lc3f6		;; c5dc: cd f6 c3    ...
	call	Lc3dc		;; c5df: cd dc c3    ...
Lc5e2:	lxi	d,Ld5b7		;; c5e2: 11 b7 d5    ...
	call	Lc40f		;; c5e5: cd 0f c4    ...
	pop	psw		;; c5e8: f1          .
	cz	Lc429		;; c5e9: cc 29 c4    .).
Lc5ec:	mvix	0a7h,+11	;; c5ec: dd 36 0b a7 .6..
	jmp	Lc47a		;; c5f0: c3 7a c4    .z.

Lc5f3:	lda	Ld5d8		;; c5f3: 3a d8 d5    :..
	inr	a		;; c5f6: 3c          <
	cmpx	+48		;; c5f7: dd be 30    ..0
	jrz	Lc601		;; c5fa: 28 05       (.
	mvi	a,0ffh		;; c5fc: 3e ff       >.
	sta	Ld5af		;; c5fe: 32 af d5    2..
Lc601:	call	Lc64d		;; c601: cd 4d c6    .M.
	call	Lc419		;; c604: cd 19 c4    ...
	call	Lc3f6		;; c607: cd f6 c3    ...
	call	Lc3dc		;; c60a: cd dc c3    ...
	lxi	d,Ld5b7		;; c60d: 11 b7 d5    ...
	lda	Ld5af		;; c610: 3a af d5    :..
	cmpx	+6		;; c613: dd be 06    ...
	jrz	Lc627		;; c616: 28 0f       (.
	ldax	d		;; c618: 1a          .
	push	psw		;; c619: f5          .
	mvi	c,011h		;; c61a: 0e 11       ..
	call	Ld7c9		;; c61c: cd c9 d7    ...
	pop	psw		;; c61f: f1          .
	cpi	03fh		;; c620: fe 3f       .?
	jrz	Lc62e		;; c622: 28 0a       (.
	lxi	d,Ld5b7		;; c624: 11 b7 d5    ...
Lc627:	call	Lcc2f		;; c627: cd 2f cc    ./.
	xra	a		;; c62a: af          .
	push	psw		;; c62b: f5          .
	jr	Lc5e2		;; c62c: 18 b4       ..

Lc62e:	ldx	b,+48		;; c62e: dd 46 30    .F0
	mvi	c,012h		;; c631: 0e 12       ..
Lc633:	push	b		;; c633: c5          .
	call	Ld7c9		;; c634: cd c9 d7    ...
	pop	b		;; c637: c1          .
	djnz	Lc633		;; c638: 10 f9       ..
	stx	a,+14		;; c63a: dd 77 0e    .w.
	ldx	a,+49		;; c63d: dd 7e 31    .~1
	ora	a		;; c640: b7          .
	jrz	Lc648		;; c641: 28 05       (.
	dcrx	+49		;; c643: dd 35 31    .51
	jr	Lc633		;; c646: 18 eb       ..

Lc648:	call	Lc429		;; c648: cd 29 c4    .).
	jr	Lc5ec		;; c64b: 18 9f       ..

Lc64d:	call	Lc3e4		;; c64d: cd e4 c3    ...
	lxi	h,Ld5b7		;; c650: 21 b7 d5    ...
	xchg			;; c653: eb          .
	lxi	b,00024h	;; c654: 01 24 00    .$.
	ldir			;; c657: ed b0       ..
	ret			;; c659: c9          .

Lc65a:	dw	Lc455
	dw	Lc568
	dw	Lc5d0
	dw	Lc5f3
	dw	Lc4de
	dw	Lc581
	dw	Lc529
	dw	Lc591
	dw	Lc4c8
	dw	Lc48c
	dw	Lc48c
	dw	Lc48c
	dw	Lc5a4
	dw	Lc48c
	dw	Lc48c
	dw	Lc597
	dw	Lc5a4
	dw	Lc48c
	dw	Lc581
	dw	Lc529
	dw	Lc597
	dw	Lc597
	dw	Lc48c
	dw	Lc48c
	dw	Lc48c
	dw	Lc529
	dw	Lc48c
	dw	Lc48c
	dw	Lc48c
Lc694:	mov	a,m		;; c694: 7e          ~
	cpi	0ffh		;; c695: fe ff       ..
	inx	h		;; c697: 23          #
	jrz	Lc69d		;; c698: 28 03       (.
	inx	h		;; c69a: 23          #
	jr	Lc694		;; c69b: 18 f7       ..

Lc69d:	mov	a,m		;; c69d: 7e          ~
	cmp	b		;; c69e: b8          .
	inx	h		;; c69f: 23          #
	jrc	Lc694		;; c6a0: 38 f2       8.
	ret			;; c6a2: c9          .

Lc6a3:	mov	a,m		;; c6a3: 7e          ~
	cmp	c		;; c6a4: b9          .
	rnc			;; c6a5: d0          .
	inx	h		;; c6a6: 23          #
	inx	h		;; c6a7: 23          #
	jr	Lc6a3		;; c6a8: 18 f9       ..

Lc6aa:	push	b		;; c6aa: c5          .
	push	h		;; c6ab: e5          .
	ora	a		;; c6ac: b7          .
	xchg			;; c6ad: eb          .
	lxi	h,Ld5a7		;; c6ae: 21 a7 d5    ...
	dsbc	d		;; c6b1: ed 52       .R
	jrc	Lc6c7		;; c6b3: 38 12       8.
	inx	h		;; c6b5: 23          #
	mov	b,h		;; c6b6: 44          D
	mov	c,l		;; c6b7: 4d          M
	lxi	d,Ld5a9		;; c6b8: 11 a9 d5    ...
	lxi	h,Ld5a7		;; c6bb: 21 a7 d5    ...
	lddr			;; c6be: ed b8       ..
	pop	h		;; c6c0: e1          .
	pop	b		;; c6c1: c1          .
	mov	m,c		;; c6c2: 71          q
	inx	h		;; c6c3: 23          #
	mov	m,b		;; c6c4: 70          p
	inx	h		;; c6c5: 23          #
	ret			;; c6c6: c9          .

Lc6c7:	pop	h		;; c6c7: e1          .
	pop	b		;; c6c8: c1          .
	ret			;; c6c9: c9          .

Lc6ca:	push	h		;; c6ca: e5          .
	xchg			;; c6cb: eb          .
	lxi	h,Ld5aa		;; c6cc: 21 aa d5    ...
	ora	a		;; c6cf: b7          .
	dsbc	d		;; c6d0: ed 52       .R
	mov	b,h		;; c6d2: 44          D
	mov	c,l		;; c6d3: 4d          M
	mov	h,d		;; c6d4: 62          b
	mov	l,e		;; c6d5: 6b          k
	inx	h		;; c6d6: 23          #
	inx	h		;; c6d7: 23          #
	ldir			;; c6d8: ed b0       ..
	pop	h		;; c6da: e1          .
	ret			;; c6db: c9          .

	lxi	h,0ffffh	;; c6dc: 21 ff ff    ...
	shld	Ld580		;; c6df: 22 80 d5    "..
	shld	Ld5aa		;; c6e2: 22 aa d5    "..
	ret			;; c6e5: c9          .

Lc6e6:	ldx	b,+15		;; c6e6: dd 46 0f    .F.
	lxi	h,Ld580		;; c6e9: 21 80 d5    ...
	call	Lc694		;; c6ec: cd 94 c6    ...
	jrz	Lc700		;; c6ef: 28 0f       (.
	dcx	h		;; c6f1: 2b          +
	dcx	h		;; c6f2: 2b          +
	mvi	c,0ffh		;; c6f3: 0e ff       ..
	call	Lc6aa		;; c6f5: cd aa c6    ...
	ldx	c,+6		;; c6f8: dd 4e 06    .N.
Lc6fb:	mvi	b,001h		;; c6fb: 06 01       ..
	jmp	Lc6aa		;; c6fd: c3 aa c6    ...

Lc700:	ldx	c,+6		;; c700: dd 4e 06    .N.
	call	Lc6a3		;; c703: cd a3 c6    ...
	jrnz	Lc6fb		;; c706: 20 f3        .
	inx	h		;; c708: 23          #
	inr	m		;; c709: 34          4
	ret			;; c70a: c9          .

Lc70b:	ldx	b,+15		;; c70b: dd 46 0f    .F.
	lxi	h,Ld580		;; c70e: 21 80 d5    ...
	call	Lc694		;; c711: cd 94 c6    ...
	rnz			;; c714: c0          .
	ldx	c,+6		;; c715: dd 4e 06    .N.
	call	Lc6a3		;; c718: cd a3 c6    ...
	rnz			;; c71b: c0          .
	inx	h		;; c71c: 23          #
	dcr	m		;; c71d: 35          5
	rnz			;; c71e: c0          .
	dcx	h		;; c71f: 2b          +
	call	Lc6ca		;; c720: cd ca c6    ...
	mvi	a,0ffh		;; c723: 3e ff       >.
	cmp	m		;; c725: be          .
	rnz			;; c726: c0          .
	dcx	h		;; c727: 2b          +
	dcx	h		;; c728: 2b          +
	cmp	m		;; c729: be          .
	rnz			;; c72a: c0          .
	jmp	Lc6ca		;; c72b: c3 ca c6    ...

Lc72e:	lda	Ld581		;; c72e: 3a 81 d5    :..
	cpi	0ffh		;; c731: fe ff       ..
	jrz	Lc74e		;; c733: 28 19       (.
	lxi	d,Lcdff		;; c735: 11 ff cd    ...
	call	Lc861		;; c738: cd 61 c8    .a.
Lc73b:	lxi	d,00080h	;; c73b: 11 80 00    ...
	sded	Ld5b1		;; c73e: ed 53 b1 d5 .S..
	mvi	c,01ah		;; c742: 0e 1a       ..
	call	Ld7c9		;; c744: cd c9 d7    ...
	xra	a		;; c747: af          .
	sta	Ld5ed		;; c748: 32 ed d5    2..
	jmp	Lc793		;; c74b: c3 93 c7    ...

Lc74e:	lxi	h,Ld5f2		;; c74e: 21 f2 d5    ...
	mvi	b,010h		;; c751: 06 10       ..
Lc753:	res	7,m		;; c753: cb be       ..
	res	6,m		;; c755: cb b6       ..
	inx	h		;; c757: 23          #
	inx	h		;; c758: 23          #
	djnz	Lc753		;; c759: 10 f8       ..
	mvi	c,00dh		;; c75b: 0e 0d       ..
	call	Ld7c9		;; c75d: cd c9 d7    ...
	jr	Lc73b		;; c760: 18 d9       ..

Lc762:	lxi	h,Ld5f1		;; c762: 21 f1 d5    ...
	add	a		;; c765: 87          .
Lc766:	add	l		;; c766: 85          .
	mov	l,a		;; c767: 6f          o
	rnc			;; c768: d0          .
	inr	h		;; c769: 24          $
	ret			;; c76a: c9          .

Lc76b:	cpi	010h		;; c76b: fe 10       ..
	jrnc	Lc778		;; c76d: 30 09       0.
	call	Lc762		;; c76f: cd 62 c7    .b.
	inx	h		;; c772: 23          #
	mov	a,m		;; c773: 7e          ~
	ora	a		;; c774: b7          .
	jnz	Lc783		;; c775: c2 83 c7    ...
Lc778:	lxi	d,Lce33		;; c778: 11 33 ce    .3.
	call	Lc9b1		;; c77b: cd b1 c9    ...
	jz	Ld109		;; c77e: ca 09 d1    ...
	jr	Lc78e		;; c781: 18 0b       ..

Lc783:	setb	7,m		;; c783: cb fe       ..
	ani	00fh		;; c785: e6 0f       ..
	dcx	h		;; c787: 2b          +
	ret			;; c788: c9          .

Lc789:	mvi	c,009h		;; c789: 0e 09       ..
	call	Ld7c9		;; c78b: cd c9 d7    ...
Lc78e:	mvi	a,0ffh		;; c78e: 3e ff       >.
	jmp	Lc23a		;; c790: c3 3a c2    .:.

Lc793:	lda	Ld5ed		;; c793: 3a ed d5    :..
	call	Lc76b		;; c796: cd 6b c7    .k.
	dcr	a		;; c799: 3d          =
	mov	e,a		;; c79a: 5f          _
	lda	Ld5ed		;; c79b: 3a ed d5    :..
	sta	Ld5ef		;; c79e: 32 ef d5    2..
	mvi	a,0ffh		;; c7a1: 3e ff       >.
	sta	Ld5af		;; c7a3: 32 af d5    2..
	sta	Ld5ac		;; c7a6: 32 ac d5    2..
	mov	a,m		;; c7a9: 7e          ~
	inr	a		;; c7aa: 3c          <
	jrnz	Lc7b6		;; c7ab: 20 09        .
	mov	a,e		;; c7ad: 7b          {
	sta	Ld5ac		;; c7ae: 32 ac d5    2..
	mvi	c,00eh		;; c7b1: 0e 0e       ..
	call	Ld7c9		;; c7b3: cd c9 d7    ...
Lc7b6:	jmp	Lc23a		;; c7b6: c3 3a c2    .:.

Lc7b9:	lxi	d,Ld644		;; c7b9: 11 44 d6    .D.
	mvi	c,01ah		;; c7bc: 0e 1a       ..
	jmp	Ld7c9		;; c7be: c3 c9 d7    ...

Lc7c1:	rrc			;; c7c1: 0f          .
	rrc			;; c7c2: 0f          .
	rrc			;; c7c3: 0f          .
	lxi	h,Ld644		;; c7c4: 21 44 d6    .D.
	jmp	Lc766		;; c7c7: c3 66 c7    .f.

Lc7ca:	call	Lc7b9		;; c7ca: cd b9 c7    ...
	lded	Ld5ed		;; c7cd: ed 5b ed d5 .[..
	mvi	c,011h		;; c7d1: 0e 11       ..
	call	Ld7c9		;; c7d3: cd c9 d7    ...
	cpi	0ffh		;; c7d6: fe ff       ..
	jrz	Lc7de		;; c7d8: 28 04       (.
	call	Lc7c1		;; c7da: cd c1 c7    ...
	inr	a		;; c7dd: 3c          <
Lc7de:	push	psw		;; c7de: f5          .
	push	h		;; c7df: e5          .
	call	Lc403		;; c7e0: cd 03 c4    ...
	pop	h		;; c7e3: e1          .
	pop	psw		;; c7e4: f1          .
	ret			;; c7e5: c9          .

Lc7e6:	lhld	Ld5ed		;; c7e6: 2a ed d5    *..
	mov	a,m		;; c7e9: 7e          ~
	xchg			;; c7ea: eb          .
	sta	Ld5f0		;; c7eb: 32 f0 d5    2..
	ora	a		;; c7ee: b7          .
	jrnz	Lc7fd		;; c7ef: 20 0c        .
	lda	Ld5ac		;; c7f1: 3a ac d5    :..
	inr	a		;; c7f4: 3c          <
	jrz	Lc7f9		;; c7f5: 28 02       (.
	xra	a		;; c7f7: af          .
	ret			;; c7f8: c9          .

Lc7f9:	lda	Ld5ef		;; c7f9: 3a ef d5    :..
	inr	a		;; c7fc: 3c          <
Lc7fd:	dcr	a		;; c7fd: 3d          =
	call	Lc76b		;; c7fe: cd 6b c7    .k.
	mov	b,m		;; c801: 46          F
	inr	b		;; c802: 04          .
	jrnz	Lc807		;; c803: 20 02        .
	stax	d		;; c805: 12          .
	ret			;; c806: c9          .

Lc807:	dcr	b		;; c807: 05          .
	stx	b,+3		;; c808: dd 70 03    .p.
	stx	a,+15		;; c80b: dd 77 0f    .w.
	xchg			;; c80e: eb          .
	inx	h		;; c80f: 23          #
	lxi	d,Ld621		;; c810: 11 21 d6    ...
	lxi	b,00023h	;; c813: 01 23 00    .#.
	ldir			;; c816: ed b0       ..
	lda	Ld5ec		;; c818: 3a ec d5    :..
	stx	a,+12		;; c81b: dd 77 0c    .w.
	lda	Ld5b3		;; c81e: 3a b3 d5    :..
	stx	a,+6		;; c821: dd 77 06    .w.
	call	Lc837		;; c824: cd 37 c8    .7.
	lda	Ld5b0		;; c827: 3a b0 d5    :..
	stx	a,+13		;; c82a: dd 77 0d    .w.
	mvix	027h,+11	;; c82d: dd 36 0b 27 .6.'
	mvix	020h,+9		;; c831: dd 36 09 20 .6. 
	inr	a		;; c835: 3c          <
	ret			;; c836: c9          .

Lc837:	mvix	000h,+8		;; c837: dd 36 08 00 .6..
	lda	Ld5db		;; c83b: 3a db d5    :..
	inr	a		;; c83e: 3c          <
	sta	Ld5db		;; c83f: 32 db d5    2..
	stx	a,+10		;; c842: dd 77 0a    .w.
	ret			;; c845: c9          .

Lc846:	lded	Ld5ed		;; c846: ed 5b ed d5 .[..
	push	d		;; c84a: d5          .
	lda	Ld5ec		;; c84b: 3a ec d5    :..
	mov	c,a		;; c84e: 4f          O
	call	Ld7c9		;; c84f: cd c9 d7    ...
	pop	d		;; c852: d1          .
Lc853:	mov	b,a		;; c853: 47          G
	mvi	a,0ffh		;; c854: 3e ff       >.
	sta	Ld5af		;; c856: 32 af d5    2..
	lda	Ld5f0		;; c859: 3a f0 d5    :..
	stax	d		;; c85c: 12          .
	mov	a,b		;; c85d: 78          x
	jmp	Lc23a		;; c85e: c3 3a c2    .:.

Lc861:	mvi	c,009h		;; c861: 0e 09       ..
	jmp	Ld7c9		;; c863: c3 c9 d7    ...

Lc866:	push	b		;; c866: c5          .
	lxi	h,Ld614		;; c867: 21 14 d6    ...
	call	Ld286		;; c86a: cd 86 d2    ...
	ora	a		;; c86d: b7          .
	jrz	Lc877		;; c86e: 28 07       (.
	pop	b		;; c870: c1          .
	lxi	d,Lced7		;; c871: 11 d7 ce    ...
	jmp	Lc789		;; c874: c3 89 c7    ...

Lc877:	lxi	h,007d0h	;; c877: 21 d0 07    ...
	call	Ld0cf		;; c87a: cd cf d0    ...
	pop	b		;; c87d: c1          .
	jrnz	Lc88a		;; c87e: 20 0a        .
Lc880:	djnz	Lc866		;; c880: 10 e4       ..
	xra	a		;; c882: af          .
	inr	a		;; c883: 3c          <
	ret			;; c884: c9          .

Lc885:	call	Ld04c		;; c885: cd 4c d0    .L.
	jr	Lc880		;; c888: 18 f6       ..

Lc88a:	xchg			;; c88a: eb          .
	lxi	h,00006h	;; c88b: 21 06 00    ...
	dad	d		;; c88e: 19          .
	mov	a,m		;; c88f: 7e          ~
	cmpx	+3		;; c890: dd be 03    ...
	jrnz	Lc885		;; c893: 20 f0        .
	inx	h		;; c895: 23          #
	inx	h		;; c896: 23          #
	inx	h		;; c897: 23          #
	mov	a,m		;; c898: 7e          ~
	cpi	021h		;; c899: fe 21       ..
	jrnz	Lc885		;; c89b: 20 e8        .
	inx	h		;; c89d: 23          #
	lda	Ld5db		;; c89e: 3a db d5    :..
	cmp	m		;; c8a1: be          .
	jrnz	Lc885		;; c8a2: 20 e1        .
	lxi	h,0000eh	;; c8a4: 21 0e 00    ...
	dad	d		;; c8a7: 19          .
	mov	a,m		;; c8a8: 7e          ~
	inx	h		;; c8a9: 23          #
	inx	h		;; c8aa: 23          #
	ret			;; c8ab: c9          .

Lc8ac:	call	Lc7ca		;; c8ac: cd ca c7    ...
	rnz			;; c8af: c0          .
	lded	Ld5ed		;; c8b0: ed 5b ed d5 .[..
	jmp	Lc853		;; c8b4: c3 53 c8    .S.

Lc8b7:	lda	Ld5b5		;; c8b7: 3a b5 d5    :..
	ana	b		;; c8ba: a0          .
	rnz			;; c8bb: c0          .
	pop	d		;; c8bc: d1          .
	lxi	d,Lcd51		;; c8bd: 11 51 cd    .Q.
	jmp	Lc789		;; c8c0: c3 89 c7    ...

Lc8c3:	call	Lc8b7		;; c8c3: cd b7 c8    ...
	mvi	b,008h		;; c8c6: 06 08       ..
Lc8c8:	call	Lc866		;; c8c8: cd 66 c8    .f.
	rz			;; c8cb: c8          .
	pop	d		;; c8cc: d1          .
	lxi	d,Lcd27		;; c8cd: 11 27 cd    .'.
	jmp	Lc789		;; c8d0: c3 89 c7    ...

Lc8d3:	push	d		;; c8d3: d5          .
	lded	Ld5ed		;; c8d4: ed 5b ed d5 .[..
	inx	d		;; c8d8: 13          .
	lxi	b,00020h	;; c8d9: 01 20 00    . .
	lda	Ld5ec		;; c8dc: 3a ec d5    :..
	cpi	021h		;; c8df: fe 21       ..
	jrc	Lc8e6		;; c8e1: 38 03       8.
	inr	c		;; c8e3: 0c          .
	inr	c		;; c8e4: 0c          .
	inr	c		;; c8e5: 0c          .
Lc8e6:	ldir			;; c8e6: ed b0       ..
	pop	d		;; c8e8: d1          .
	ret			;; c8e9: c9          .

Lc8ea:	lhld	Ld5ed		;; c8ea: 2a ed d5    *..
	mov	a,m		;; c8ed: 7e          ~
	stax	d		;; c8ee: 12          .
	mvi	c,01eh		;; c8ef: 0e 1e       ..
	jmp	Ld7c9		;; c8f1: c3 c9 d7    ...

Lc8f4:	call	Lc7e6		;; c8f4: cd e6 c7    ...
	jrnz	Lc920		;; c8f7: 20 27        '
	call	Lc8ac		;; c8f9: cd ac c8    ...
	mov	d,h		;; c8fc: 54          T
	mov	e,l		;; c8fd: 5d          ]
	inx	h		;; c8fe: 23          #
	inx	h		;; c8ff: 23          #
	bit	7,m		;; c900: cb 7e       .~
	jrz	Lc91d		;; c902: 28 19       (.
	inx	h		;; c904: 23          #
	bit	7,m		;; c905: cb 7e       .~
	jrz	Lc918		;; c907: 28 0f       (.
	lxi	d,Lce61		;; c909: 11 61 ce    .a.
	call	Lc861		;; c90c: cd 61 c8    .a.
	mvi	a,0ffh		;; c90f: 3e ff       >.
	lded	Ld5ed		;; c911: ed 5b ed d5 .[..
	jmp	Lc853		;; c915: c3 53 c8    .S.

Lc918:	setb	7,m		;; c918: cb fe       ..
	call	Lc8ea		;; c91a: cd ea c8    ...
Lc91d:	jmp	Lc846		;; c91d: c3 46 c8    .F.

Lc920:	mvi	b,00ch		;; c920: 06 0c       ..
Lc922:	call	Lc8c3		;; c922: cd c3 c8    ...
	push	psw		;; c925: f5          .
	inr	a		;; c926: 3c          <
	cz	Lc934		;; c927: cc 34 c9    .4.
	cnz	Lc8d3		;; c92a: c4 d3 c8    ...
	call	Ld04c		;; c92d: cd 4c d0    .L.
	pop	psw		;; c930: f1          .
	jmp	Lc23a		;; c931: c3 3a c2    .:.

Lc934:	push	psw		;; c934: f5          .
	push	d		;; c935: d5          .
	lxi	h,00008h	;; c936: 21 08 00    ...
	dad	d		;; c939: 19          .
	mov	a,m		;; c93a: 7e          ~
	cpi	010h		;; c93b: fe 10       ..
	jrnz	Lc947		;; c93d: 20 08        .
	lxi	d,Lce61		;; c93f: 11 61 ce    .a.
	call	Lc861		;; c942: cd 61 c8    .a.
	jr	Lc95d		;; c945: 18 16       ..

Lc947:	cpi	011h		;; c947: fe 11       ..
	jrnz	Lc953		;; c949: 20 08        .
	lxi	d,Lce76		;; c94b: 11 76 ce    .v.
	call	Lc861		;; c94e: cd 61 c8    .a.
	jr	Lc95d		;; c951: 18 0a       ..

Lc953:	cpi	012h		;; c953: fe 12       ..
	jrnz	Lc95d		;; c955: 20 06        .
	lxi	d,Lcebe		;; c957: 11 be ce    ...
	call	Lc861		;; c95a: cd 61 c8    .a.
Lc95d:	pop	d		;; c95d: d1          .
	pop	psw		;; c95e: f1          .
	ret			;; c95f: c9          .

Lc960:	lhld	Ld5ed		;; c960: 2a ed d5    *..
	inx	h		;; c963: 23          #
	inx	h		;; c964: 23          #
	inx	h		;; c965: 23          #
	res	7,m		;; c966: cb be       ..
	call	Lc7e6		;; c968: cd e6 c7    ...
	jrnz	Lc97d		;; c96b: 20 10        .
	call	Lc8ac		;; c96d: cd ac c8    ...
	mov	d,h		;; c970: 54          T
	mov	e,l		;; c971: 5d          ]
	inx	h		;; c972: 23          #
	inx	h		;; c973: 23          #
	inx	h		;; c974: 23          #
	res	7,m		;; c975: cb be       ..
	call	Lc8ea		;; c977: cd ea c8    ...
	jmp	Lc846		;; c97a: c3 46 c8    .F.

Lc97d:	mvi	b,008h		;; c97d: 06 08       ..
	call	Lc8b7		;; c97f: cd b7 c8    ...
Lc982:	mvi	b,008h		;; c982: 06 08       ..
	call	Lc866		;; c984: cd 66 c8    .f.
	jrz	Lc99d		;; c987: 28 14       (.
	lxi	d,Lcd27		;; c989: 11 27 cd    .'.
	call	Lc861		;; c98c: cd 61 c8    .a.
	lxi	d,Lcd81		;; c98f: 11 81 cd    ...
Lc992:	call	Lc9b1		;; c992: cd b1 c9    ...
	jrnz	Lc982		;; c995: 20 eb        .
	lxi	d,Lcd4e		;; c997: 11 4e cd    .N.
	jmp	Lc789		;; c99a: c3 89 c7    ...

Lc99d:	push	psw		;; c99d: f5          .
	inr	a		;; c99e: 3c          <
	jrnz	Lc9aa		;; c99f: 20 09        .
	call	Ld04c		;; c9a1: cd 4c d0    .L.
	lxi	d,Lcd95		;; c9a4: 11 95 cd    ...
	pop	psw		;; c9a7: f1          .
	jr	Lc992		;; c9a8: 18 e8       ..

Lc9aa:	call	Ld04c		;; c9aa: cd 4c d0    .L.
	pop	psw		;; c9ad: f1          .
	jmp	Lc23a		;; c9ae: c3 3a c2    .:.

Lc9b1:	call	Lc861		;; c9b1: cd 61 c8    .a.
	mvi	c,001h		;; c9b4: 0e 01       ..
	call	Ld7c9		;; c9b6: cd c9 d7    ...
	ani	05fh		;; c9b9: e6 5f       ._
	cpi	04eh		;; c9bb: fe 4e       .N
	ret			;; c9bd: c9          .

Lc9be:	call	Lcad8		;; c9be: cd d8 ca    ...
	call	Lc7e6		;; c9c1: cd e6 c7    ...
	jrnz	Lca28		;; c9c4: 20 62        b
	call	Lc7b9		;; c9c6: cd b9 c7    ...
	lded	Ld5ed		;; c9c9: ed 5b ed d5 .[..
	mvi	c,011h		;; c9cd: 0e 11       ..
	call	Ld7c9		;; c9cf: cd c9 d7    ...
	cpi	0ffh		;; c9d2: fe ff       ..
	jrz	Lca08		;; c9d4: 28 32       (2
Lc9d6:	call	Lc7c1		;; c9d6: cd c1 c7    ...
	inx	h		;; c9d9: 23          #
	inx	h		;; c9da: 23          #
	inx	h		;; c9db: 23          #
	bit	7,m		;; c9dc: cb 7e       .~
	jrnz	Lca02		;; c9de: 20 22        "
	mvi	c,012h		;; c9e0: 0e 12       ..
	call	Ld7c9		;; c9e2: cd c9 d7    ...
	cpi	0ffh		;; c9e5: fe ff       ..
	jrnz	Lc9d6		;; c9e7: 20 ed        .
	call	Lc403		;; c9e9: cd 03 c4    ...
	jmp	Lc846		;; c9ec: c3 46 c8    .F.

Lc9ef:	call	Lcad8		;; c9ef: cd d8 ca    ...
	call	Lc7e6		;; c9f2: cd e6 c7    ...
	jrnz	Lca28		;; c9f5: 20 31        1
	call	Lc8ac		;; c9f7: cd ac c8    ...
	inx	h		;; c9fa: 23          #
	inx	h		;; c9fb: 23          #
	inx	h		;; c9fc: 23          #
	bit	7,m		;; c9fd: cb 7e       .~
	jz	Lca14		;; c9ff: ca 14 ca    ...
Lca02:	lxi	d,Lcdc6		;; ca02: 11 c6 cd    ...
	call	Lc861		;; ca05: cd 61 c8    .a.
Lca08:	call	Lc403		;; ca08: cd 03 c4    ...
	lded	Ld5ed		;; ca0b: ed 5b ed d5 .[..
	mvi	a,0ffh		;; ca0f: 3e ff       >.
	jmp	Lc853		;; ca11: c3 53 c8    .S.

Lca14:	call	Lc7b9		;; ca14: cd b9 c7    ...
	lhld	Ld5ed		;; ca17: 2a ed d5    *..
	call	Lca39		;; ca1a: cd 39 ca    .9.
	push	psw		;; ca1d: f5          .
	call	Lc403		;; ca1e: cd 03 c4    ...
	pop	psw		;; ca21: f1          .
	jz	Lc846		;; ca22: ca 46 c8    .F.
	jmp	Lcb0e		;; ca25: c3 0e cb    ...

Lca28:	mvi	b,008h		;; ca28: 06 08       ..
	call	Lc8c3		;; ca2a: cd c3 c8    ...
	push	psw		;; ca2d: f5          .
	inr	a		;; ca2e: 3c          <
	cz	Lc934		;; ca2f: cc 34 c9    .4.
	call	Ld04c		;; ca32: cd 4c d0    .L.
	pop	psw		;; ca35: f1          .
	jmp	Lc23a		;; ca36: c3 3a c2    .:.

Lca39:	mov	a,m		;; ca39: 7e          ~
	lxi	d,00010h	;; ca3a: 11 10 00    ...
	dad	d		;; ca3d: 19          .
	mov	m,a		;; ca3e: 77          w
	push	h		;; ca3f: e5          .
	xchg			;; ca40: eb          .
	mvi	c,011h		;; ca41: 0e 11       ..
	call	Ld7c9		;; ca43: cd c9 d7    ...
	pop	h		;; ca46: e1          .
	mvi	m,000h		;; ca47: 36 00       6.
	inr	a		;; ca49: 3c          <
	ret			;; ca4a: c9          .

Lca4b:	call	Lc7e6		;; ca4b: cd e6 c7    ...
	jz	Lc846		;; ca4e: ca 46 c8    .F.
	mvi	b,00ch		;; ca51: 06 0c       ..
	call	Lc8c3		;; ca53: cd c3 c8    ...
	ora	a		;; ca56: b7          .
	push	psw		;; ca57: f5          .
	jrnz	Lca6a		;; ca58: 20 10        .
	call	Lc8d3		;; ca5a: cd d3 c8    ...
Lca5d:	lxi	h,00033h	;; ca5d: 21 33 00    .3.
	dad	d		;; ca60: 19          .
	lded	Ld5b1		;; ca61: ed 5b b1 d5 .[..
	lxi	b,00080h	;; ca65: 01 80 00    ...
	ldir			;; ca68: ed b0       ..
Lca6a:	call	Ld04c		;; ca6a: cd 4c d0    .L.
	mvi	h,000h		;; ca6d: 26 00       &.
	pop	psw		;; ca6f: f1          .
	jmp	Lc23a		;; ca70: c3 3a c2    .:.

Lca73:	call	Lcad8		;; ca73: cd d8 ca    ...
	call	Lc7e6		;; ca76: cd e6 c7    ...
	jz	Lc846		;; ca79: ca 46 c8    .F.
	mvi	b,008h		;; ca7c: 06 08       ..
	call	Lc8b7		;; ca7e: cd b7 c8    ...
	mvix	0a7h,+11	;; ca81: dd 36 0b a7 .6..
	lxi	d,Ld644		;; ca85: 11 44 d6    .D.
	lhld	Ld5b1		;; ca88: 2a b1 d5    *..
	lxi	b,00080h	;; ca8b: 01 80 00    ...
	ldir			;; ca8e: ed b0       ..
Lca90:	mvi	b,008h		;; ca90: 06 08       ..
	call	Lc866		;; ca92: cd 66 c8    .f.
	jrz	Lcaab		;; ca95: 28 14       (.
	lxi	d,Lcd27		;; ca97: 11 27 cd    .'.
	call	Lc861		;; ca9a: cd 61 c8    .a.
	lxi	d,Lcd81		;; ca9d: 11 81 cd    ...
	call	Lc9b1		;; caa0: cd b1 c9    ...
	jrnz	Lca90		;; caa3: 20 eb        .
	lxi	d,Lcd4e		;; caa5: 11 4e cd    .N.
	jmp	Lc789		;; caa8: c3 89 c7    ...

Lcaab:	ora	a		;; caab: b7          .
	push	psw		;; caac: f5          .
	jrz	Lcace		;; caad: 28 1f       (.
	push	h		;; caaf: e5          .
	lxi	h,00008h	;; cab0: 21 08 00    ...
	dad	d		;; cab3: 19          .
	mov	a,m		;; cab4: 7e          ~
	cpi	001h		;; cab5: fe 01       ..
	jrnz	Lcabf		;; cab7: 20 06        .
	pop	h		;; cab9: e1          .
	call	Lc837		;; caba: cd 37 c8    .7.
	jr	Lcac8		;; cabd: 18 09       ..

Lcabf:	lxi	d,Lcd6e		;; cabf: 11 6e cd    .n.
	call	Lc9b1		;; cac2: cd b1 c9    ...
	pop	h		;; cac5: e1          .
	jrz	Lcace		;; cac6: 28 06       (.
Lcac8:	call	Ld04c		;; cac8: cd 4c d0    .L.
	pop	psw		;; cacb: f1          .
	jr	Lca90		;; cacc: 18 c2       ..

Lcace:	call	Lc8d3		;; cace: cd d3 c8    ...
	call	Ld04c		;; cad1: cd 4c d0    .L.
	pop	psw		;; cad4: f1          .
	jmp	Lc23a		;; cad5: c3 3a c2    .:.

Lcad8:	lhld	Ld5ed		;; cad8: 2a ed d5    *..
	xchg			;; cadb: eb          .
	lxi	h,00009h	;; cadc: 21 09 00    ...
	dad	d		;; cadf: 19          .
	bit	7,m		;; cae0: cb 7e       .~
	jrz	Lcaeb		;; cae2: 28 07       (.
	pop	d		;; cae4: d1          .
	lxi	d,Lcebe		;; cae5: 11 be ce    ...
	jmp	Lc789		;; cae8: c3 89 c7    ...

Lcaeb:	xchg			;; caeb: eb          .
	mov	a,m		;; caec: 7e          ~
	ora	a		;; caed: b7          .
	jrnz	Lcaf4		;; caee: 20 04        .
	lda	Ld5ef		;; caf0: 3a ef d5    :..
	inr	a		;; caf3: 3c          <
Lcaf4:	dcr	a		;; caf4: 3d          =
	call	Lc762		;; caf5: cd 62 c7    .b.
	inx	h		;; caf8: 23          #
	bit	6,m		;; caf9: cb 76       .v
	rz			;; cafb: c8          .
	pop	d		;; cafc: d1          .
	lxi	d,Lcea1		;; cafd: 11 a1 ce    ...
	jmp	Lc789		;; cb00: c3 89 c7    ...

Lcb03:	call	Lc7e6		;; cb03: cd e6 c7    ...
	jrnz	Lcb1d		;; cb06: 20 15        .
	call	Lc7ca		;; cb08: cd ca c7    ...
	jz	Lc846		;; cb0b: ca 46 c8    .F.
Lcb0e:	lxi	d,Lcddb		;; cb0e: 11 db cd    ...
	call	Lc861		;; cb11: cd 61 c8    .a.
	lded	Ld5ed		;; cb14: ed 5b ed d5 .[..
	mvi	a,0ffh		;; cb18: 3e ff       >.
	jmp	Lc853		;; cb1a: c3 53 c8    .S.

Lcb1d:	mvi	b,008h		;; cb1d: 06 08       ..
	jmp	Lc922		;; cb1f: c3 22 c9    .".

Lcb22:	mvi	b,010h		;; cb22: 06 10       ..
	call	Lc8b7		;; cb24: cd b7 c8    ...
	call	Lc7e6		;; cb27: cd e6 c7    ...
	jz	Lc846		;; cb2a: ca 46 c8    .F.
	jmp	Lca28		;; cb2d: c3 28 ca    .(.

Lcb30:	call	Lc7e6		;; cb30: cd e6 c7    ...
	jz	Lc846		;; cb33: ca 46 c8    .F.
	mvi	b,00ch		;; cb36: 06 0c       ..
	call	Lc8c3		;; cb38: cd c3 c8    ...
	push	psw		;; cb3b: f5          .
	jmp	Lcace		;; cb3c: c3 ce ca    ...

Lcb3f:	lhld	Ld5ed		;; cb3f: 2a ed d5    *..
	shld	Ld6e3		;; cb42: 22 e3 d6    "..
	lxi	d,Ld6c4		;; cb45: 11 c4 d6    ...
	lxi	b,0000dh	;; cb48: 01 0d 00    ...
	ldir			;; cb4b: ed b0       ..
	sbcd	Ld6e5		;; cb4d: ed 43 e5 d6 .C..
	ret			;; cb51: c9          .

Lcb52:	lhld	Ld6e3		;; cb52: 2a e3 d6    *..
	lxi	d,Ld6d4		;; cb55: 11 d4 d6    ...
	lxi	b,0000dh	;; cb58: 01 0d 00    ...
	ldir			;; cb5b: ed b0       ..
	ret			;; cb5d: c9          .

Lcb5e:	call	Lcb3f		;; cb5e: cd 3f cb    .?.
	lhld	Ld5ed		;; cb61: 2a ed d5    *..
	mov	a,m		;; cb64: 7e          ~
	xchg			;; cb65: eb          .
	sta	Ld5f0		;; cb66: 32 f0 d5    2..
	cpi	03fh		;; cb69: fe 3f       .?
	jrnz	Lcb84		;; cb6b: 20 17        .
	lda	Ld5ac		;; cb6d: 3a ac d5    :..
	inr	a		;; cb70: 3c          <
	jnz	Lc846		;; cb71: c2 46 c8    .F.
	call	Lc7f9		;; cb74: cd f9 c7    ...
	ldx	a,+15		;; cb77: dd 7e 0f    .~.
	dcr	a		;; cb7a: 3d          =
	stx	a,+14		;; cb7b: dd 77 0e    .w.
	mvix	03fh,+15	;; cb7e: dd 36 0f 3f .6.?
	jr	Lcb8a		;; cb82: 18 06       ..

Lcb84:	call	Lc7e6		;; cb84: cd e6 c7    ...
	jz	Lc846		;; cb87: ca 46 c8    .F.
Lcb8a:	mvi	b,00ch		;; cb8a: 06 0c       ..
	call	Lc8c3		;; cb8c: cd c3 c8    ...
	push	psw		;; cb8f: f5          .
	jmp	Lca5d		;; cb90: c3 5d ca    .].

Lcb93:	lhld	Ld6e5		;; cb93: 2a e5 d6    *..
	inx	h		;; cb96: 23          #
	shld	Ld6e5		;; cb97: 22 e5 d6    "..
	call	Lcb52		;; cb9a: cd 52 cb    .R.
	lxi	h,Ld6c4		;; cb9d: 21 c4 d6    ...
	shld	Ld5ed		;; cba0: 22 ed d5    "..
	mov	a,m		;; cba3: 7e          ~
	xchg			;; cba4: eb          .
	sta	Ld5f0		;; cba5: 32 f0 d5    2..
	cpi	03fh		;; cba8: fe 3f       .?
	jrnz	Lcbc2		;; cbaa: 20 16        .
	lda	Ld5ac		;; cbac: 3a ac d5    :..
	inr	a		;; cbaf: 3c          <
	jrnz	Lcbe2		;; cbb0: 20 30        0
	call	Lc7f9		;; cbb2: cd f9 c7    ...
	ldx	a,+15		;; cbb5: dd 7e 0f    .~.
	dcr	a		;; cbb8: 3d          =
	stx	a,+14		;; cbb9: dd 77 0e    .w.
	mvix	03fh,+15	;; cbbc: dd 36 0f 3f .6.?
	jr	Lcbce		;; cbc0: 18 0c       ..

Lcbc2:	call	Lc7e6		;; cbc2: cd e6 c7    ...
	jrz	Lcbe2		;; cbc5: 28 1b       (.
	ldx	a,+15		;; cbc7: dd 7e 0f    .~.
	dcr	a		;; cbca: 3d          =
	stx	a,+14		;; cbcb: dd 77 0e    .w.
Lcbce:	mvi	b,00ch		;; cbce: 06 0c       ..
	call	Lc8c3		;; cbd0: cd c3 c8    ...
	push	psw		;; cbd3: f5          .
	cpi	0ffh		;; cbd4: fe ff       ..
	jrz	Lcbdf		;; cbd6: 28 07       (.
	lxi	h,00034h	;; cbd8: 21 34 00    .4.
	dad	d		;; cbdb: 19          .
	call	Lcc3c		;; cbdc: cd 3c cc    .<.
Lcbdf:	jmp	Lca5d		;; cbdf: c3 5d ca    .].

Lcbe2:	lda	Ld5af		;; cbe2: 3a af d5    :..
	inr	a		;; cbe5: 3c          <
	jrz	Lcbf4		;; cbe6: 28 0c       (.
	push	d		;; cbe8: d5          .
	mvi	c,011h		;; cbe9: 0e 11       ..
	call	Ld7c9		;; cbeb: cd c9 d7    ...
	pop	d		;; cbee: d1          .
	ldax	d		;; cbef: 1a          .
	cpi	03fh		;; cbf0: fe 3f       .?
	jrz	Lcc0f		;; cbf2: 28 1b       (.
Lcbf4:	call	Lcc2f		;; cbf4: cd 2f cc    ./.
	push	d		;; cbf7: d5          .
	mvi	c,012h		;; cbf8: 0e 12       ..
	call	Ld7c9		;; cbfa: cd c9 d7    ...
	pop	d		;; cbfd: d1          .
Lcbfe:	cpi	0ffh		;; cbfe: fe ff       ..
	jz	Lc853		;; cc00: ca 53 c8    .S.
	push	psw		;; cc03: f5          .
	lhld	Ld5b1		;; cc04: 2a b1 d5    *..
	inx	h		;; cc07: 23          #
	call	Lcc3c		;; cc08: cd 3c cc    .<.
	pop	psw		;; cc0b: f1          .
	jmp	Lc853		;; cc0c: c3 53 c8    .S.

Lcc0f:	push	d		;; cc0f: d5          .
	lda	Ld6e5		;; cc10: 3a e5 d6    :..
	mov	b,a		;; cc13: 47          G
	mvi	c,012h		;; cc14: 0e 12       ..
Lcc16:	push	b		;; cc16: c5          .
	call	Ld7c9		;; cc17: cd c9 d7    ...
	pop	b		;; cc1a: c1          .
	djnz	Lcc16		;; cc1b: 10 f9       ..
	push	psw		;; cc1d: f5          .
	lda	Ld6e6		;; cc1e: 3a e6 d6    :..
	ora	a		;; cc21: b7          .
	jrz	Lcc2b		;; cc22: 28 07       (.
	dcr	a		;; cc24: 3d          =
	sta	Ld6e6		;; cc25: 32 e6 d6    2..
	pop	psw		;; cc28: f1          .
	jr	Lcc16		;; cc29: 18 eb       ..

Lcc2b:	pop	psw		;; cc2b: f1          .
	pop	d		;; cc2c: d1          .
	jr	Lcbfe		;; cc2d: 18 cf       ..

Lcc2f:	push	d		;; cc2f: d5          .
	inx	d		;; cc30: 13          .
	lxi	h,00010h	;; cc31: 21 10 00    ...
	dad	d		;; cc34: 19          .
	lxi	b,0000fh	;; cc35: 01 0f 00    ...
	ldir			;; cc38: ed b0       ..
	pop	d		;; cc3a: d1          .
	ret			;; cc3b: c9          .

Lcc3c:	push	d		;; cc3c: d5          .
	add	a		;; cc3d: 87          .
	add	a		;; cc3e: 87          .
	add	a		;; cc3f: 87          .
	add	a		;; cc40: 87          .
	add	a		;; cc41: 87          .
	mov	e,a		;; cc42: 5f          _
	mvi	d,000h		;; cc43: 16 00       ..
	dad	d		;; cc45: 19          .
	lxi	d,Ld6c5		;; cc46: 11 c5 d6    ...
	lxi	b,0000fh	;; cc49: 01 0f 00    ...
	ldir			;; cc4c: ed b0       ..
	pop	d		;; cc4e: d1          .
	ret			;; cc4f: c9          .

Lcc50:	lded	Ld5ed		;; cc50: ed 5b ed d5 .[..
Lcc54:	lda	Ld5ec		;; cc54: 3a ec d5    :..
	mov	c,a		;; cc57: 4f          O
	call	Ld7c9		;; cc58: cd c9 d7    ...
	jmp	Lc23a		;; cc5b: c3 3a c2    .:.

Lcc5e:	lxi	h,00000h	;; cc5e: 21 00 00    ...
	lxi	d,Ld610		;; cc61: 11 10 d6    ...
	mvi	b,010h		;; cc64: 06 10       ..
Lcc66:	ldax	d		;; cc66: 1a          .
	dcx	d		;; cc67: 1b          .
	dcx	d		;; cc68: 1b          .
	ral			;; cc69: 17          .
	dadc	h		;; cc6a: ed 6a       .j
	djnz	Lcc66		;; cc6c: 10 f8       ..
	jmp	Lc239		;; cc6e: c3 39 c2    .9.

Lcc71:	lda	Ld5ef		;; cc71: 3a ef d5    :..
	jmp	Lc23a		;; cc74: c3 3a c2    .:.

Lcc77:	lded	Ld5ed		;; cc77: ed 5b ed d5 .[..
	sded	Ld5b1		;; cc7b: ed 53 b1 d5 .S..
	jmp	Lcc54		;; cc7f: c3 54 cc    .T.

Lcc82:	lda	Ld5ac		;; cc82: 3a ac d5    :..
	inr	a		;; cc85: 3c          <
	jnz	Lcc54		;; cc86: c2 54 cc    .T.
	call	Lccb4		;; cc89: cd b4 cc    ...
	mvi	b,00ch		;; cc8c: 06 0c       ..
	call	Lc8b7		;; cc8e: cd b7 c8    ...
	mvi	b,002h		;; cc91: 06 02       ..
	call	Lc8c8		;; cc93: cd c8 c8    ...
	dcx	h		;; cc96: 2b          +
	lxi	d,Ld6e8		;; cc97: 11 e8 d6    ...
	lxi	b,0008eh	;; cc9a: 01 8e 00    ...
	lda	Ld5ec		;; cc9d: 3a ec d5    :..
	cpi	01bh		;; cca0: fe 1b       ..
	jrz	Lccaa		;; cca2: 28 06       (.
	lxi	d,Ld776		;; cca4: 11 76 d7    .v.
	lxi	b,0000fh	;; cca7: 01 0f 00    ...
Lccaa:	push	d		;; ccaa: d5          .
	ldir			;; ccab: ed b0       ..
	call	Ld04c		;; ccad: cd 4c d0    .L.
	pop	h		;; ccb0: e1          .
	jmp	Lc239		;; ccb1: c3 39 c2    .9.

Lccb4:	lda	Ld5ef		;; ccb4: 3a ef d5    :..
	call	Lc762		;; ccb7: cd 62 c7    .b.
	mov	a,m		;; ccba: 7e          ~
	cpi	0ffh		;; ccbb: fe ff       ..
	jz	Lc239		;; ccbd: ca 39 c2    .9.
	stx	a,+3		;; ccc0: dd 77 03    .w.
	call	Lc837		;; ccc3: cd 37 c8    .7.
	lda	Ld5b0		;; ccc6: 3a b0 d5    :..
	stx	a,+13		;; ccc9: dd 77 0d    .w.
	lda	Ld5ec		;; cccc: 3a ec d5    :..
	stx	a,+12		;; cccf: dd 77 0c    .w.
	lda	Ld5b3		;; ccd2: 3a b3 d5    :..
	stx	a,+6		;; ccd5: dd 77 06    .w.
	inx	h		;; ccd8: 23          #
	mov	a,m		;; ccd9: 7e          ~
	ani	00fh		;; ccda: e6 0f       ..
	dcr	a		;; ccdc: 3d          =
	stx	a,+14		;; ccdd: dd 77 0e    .w.
	mvix	003h,+11	;; cce0: dd 36 0b 03 .6..
	ret			;; cce4: c9          .

Lcce5:	lda	Ld5ef		;; cce5: 3a ef d5    :..
	call	Lc762		;; cce8: cd 62 c7    .b.
	inx	h		;; cceb: 23          #
	setb	6,m		;; ccec: cb f6       ..
	jmp	Lc23a		;; ccee: c3 3a c2    .:.

Lccf1:	lxi	h,00000h	;; ccf1: 21 00 00    ...
	lxi	d,Ld610		;; ccf4: 11 10 d6    ...
	mvi	b,010h		;; ccf7: 06 10       ..
Lccf9:	ldax	d		;; ccf9: 1a          .
	dcx	d		;; ccfa: 1b          .
	dcx	d		;; ccfb: 1b          .
	ral			;; ccfc: 17          .
	ral			;; ccfd: 17          .
	dadc	h		;; ccfe: ed 6a       .j
	djnz	Lccf9		;; cd00: 10 f7       ..
	jmp	Lc239		;; cd02: c3 39 c2    .9.

Lcd05:	lda	Ld5ed		;; cd05: 3a ed d5    :..
	mov	e,a		;; cd08: 5f          _
	inr	a		;; cd09: 3c          <
	lda	Ld5b0		;; cd0a: 3a b0 d5    :..
	jrnz	Lcd12		;; cd0d: 20 03        .
	jmp	Lc23a		;; cd0f: c3 3a c2    .:.

Lcd12:	cmp	e		;; cd12: bb          .
	jz	Lc23a		;; cd13: ca 3a c2    .:.
	mvi	b,002h		;; cd16: 06 02       ..
	call	Lc8b7		;; cd18: cd b7 c8    ...
Lcd1b:	lda	Ld5ed		;; cd1b: 3a ed d5    :..
	ani	00fh		;; cd1e: e6 0f       ..
	sta	Ld5b0		;; cd20: 32 b0 d5    2..
	mov	e,a		;; cd23: 5f          _
	jmp	Lcc54		;; cd24: c3 54 cc    .T.

Lcd27:	db	0dh,0ah,7,'Remote station is not available now.'
Lcd4e:	db	0dh,0ah,'$'
Lcd51:	db	0dh,0ah,7,'You are not authorized.',0dh,0ah,'$'
Lcd6e:	db	0dh,0ah,7,'WRITE Error.  - '
Lcd81:	db	'Try again? (Y or N)$'
Lcd95:	db	0dh,0ah,7,'Cannot find file on disk. Try again? (Y or N)$'
Lcdc6:	db	0dh,0ah,7,'File(s) in use.',0dh,0ah,'$'
Lcddb:	db	0dh,0ah,7,'This file name already exists.',0dh,0ah,'$'
Lcdff:	db	0dh,0ah,7,'Cannot reset drives, in use by remote station.'
	db	0dh,0ah,'$'
Lce33:	db	0dh,0ah,7,'Drive Not Mapped. Continue with Default?',0dh,0ah
	db	'$'
Lce61:	db	0dh,0ah,7,'File is Locked.',0dh,0ah,'$'
Lce76:	db	0dh,0ah,7,'File restricted to Local Access only.',0dh,0ah,'$'
Lcea1:	db	0dh,0ah,7,'Drive is set READ ONLY.',0dh,0ah,'$'
Lcebe:	db	0dh,0ah,7,'Error - File is R/O',0dh,0ah,'$'
Lced7:	db	0dh,0ah,7,'Network overload error. Check hardware.',0dh,0ah
	db	'$'
Lcf04:	db	0dh,0ah,'Logical Disk = Physical Disk: Station #',0dh,0ah
	db	0ah,'$'
Lcf31:	db	': = $'
Lcf36:	db	' Local$'
Lcf3d:	dw	Lc72e
	dw	Lc793
	dw	Lc8f4
	dw	Lc960
	dw	Lcb5e
	dw	Lcb93
	dw	Lc9be
	dw	Lca4b
	dw	Lca73
	dw	Lcb03
	dw	Lc9ef
	dw	Lcc5e
	dw	Lcc71
	dw	Lcc77
	dw	Lcc82
	dw	Lcce5
	dw	Lccf1
	dw	Lcb22
	dw	Lcc82
	dw	Lcd05
	dw	Lca4b
	dw	Lca73
	dw	Lcb30
	dw	Lcb30
	dw	Lc236
	dw	Lc236
	dw	Lc236
	dw	Lca73
	dw	Lc236
	dw	Lc236
	dw	Lc236
Lcf7b:	dw	Lc251
	dw	Lc256
	dw	Lc25b
	dw	Lc260
	dw	Lc26f
	dw	Lc277
	dw	Lc284
	dw	Lc289
	dw	Lc28e
	dw	Lc293
Lcf8f:	call	Ld7cf		;; cf8f: cd cf d7    ...
	ora	a		;; cf92: b7          .
	jrz	Lcf9b		;; cf93: 28 06       (.
	call	Ld7d2		;; cf95: cd d2 d7    ...
	call	Lcfa0		;; cf98: cd a0 cf    ...
Lcf9b:	lda	Ld7d5		;; cf9b: 3a d5 d7    :..
	ei			;; cf9e: fb          .
	ret			;; cf9f: c9          .

Lcfa0:	push	h		;; cfa0: e5          .
	push	d		;; cfa1: d5          .
	lxi	h,Ld7d6		;; cfa2: 21 d6 d7    ...
	mvi	d,000h		;; cfa5: 16 00       ..
	mov	e,m		;; cfa7: 5e          ^
	inx	h		;; cfa8: 23          #
	inx	h		;; cfa9: 23          #
	dad	d		;; cfaa: 19          .
	mov	m,a		;; cfab: 77          w
	lxi	h,Ld7d7		;; cfac: 21 d7 d7    ...
	mov	a,e		;; cfaf: 7b          {
	inr	a		;; cfb0: 3c          <
	ani	03fh		;; cfb1: e6 3f       .?
	cmp	m		;; cfb3: be          .
	dcx	h		;; cfb4: 2b          +
	jrz	Lcfb8		;; cfb5: 28 01       (.
	mov	m,a		;; cfb7: 77          w
Lcfb8:	dcx	h		;; cfb8: 2b          +
	mvi	m,0ffh		;; cfb9: 36 ff       6.
	pop	d		;; cfbb: d1          .
	pop	h		;; cfbc: e1          .
	ret			;; cfbd: c9          .

Lcfbe:	push	h		;; cfbe: e5          .
	push	d		;; cfbf: d5          .
	lxi	h,Ld7d7		;; cfc0: 21 d7 d7    ...
	mvi	d,000h		;; cfc3: 16 00       ..
	mov	e,m		;; cfc5: 5e          ^
	inx	h		;; cfc6: 23          #
	dad	d		;; cfc7: 19          .
	mov	d,m		;; cfc8: 56          V
	lxi	h,Ld7d7		;; cfc9: 21 d7 d7    ...
	mov	a,e		;; cfcc: 7b          {
	inr	a		;; cfcd: 3c          <
	ani	03fh		;; cfce: e6 3f       .?
	mov	m,a		;; cfd0: 77          w
	dcx	h		;; cfd1: 2b          +
	cmp	m		;; cfd2: be          .
	jrnz	Lcfd8		;; cfd3: 20 03        .
	dcx	h		;; cfd5: 2b          +
	mvi	m,000h		;; cfd6: 36 00       6.
Lcfd8:	mov	a,d		;; cfd8: 7a          z
	pop	d		;; cfd9: d1          .
	pop	h		;; cfda: e1          .
	ret			;; cfdb: c9          .

Lcfdc:	xra	a		;; cfdc: af          .
	lxi	h,Ld7d5		;; cfdd: 21 d5 d7    ...
	mov	m,a		;; cfe0: 77          w
	inx	h		;; cfe1: 23          #
	mov	m,a		;; cfe2: 77          w
	inx	h		;; cfe3: 23          #
	mov	m,a		;; cfe4: 77          w
	ret			;; cfe5: c9          .

Lcfe6:	call	Lcff0		;; cfe6: cd f0 cf    ...
	ora	a		;; cfe9: b7          .
	jrz	Lcfe6		;; cfea: 28 fa       (.
	call	Lcfbe		;; cfec: cd be cf    ...
	ret			;; cfef: c9          .

Lcff0:	call	Lcf8f		;; cff0: cd 8f cf    ...
	call	Ld027		;; cff3: cd 27 d0    .'.
	call	Ld06f		;; cff6: cd 6f d0    .o.
	call	Lcf8f		;; cff9: cd 8f cf    ...
	ret			;; cffc: c9          .

Lcffd:	xra	a		;; cffd: af          .
	stax	b		;; cffe: 02          .
	inx	b		;; cfff: 03          .
	stax	b		;; d000: 02          .
	dcx	b		;; d001: 0b          .
Ld002:	mov	a,m		;; d002: 7e          ~
	inx	h		;; d003: 23          #
	ora	m		;; d004: b6          .
	jrz	Ld00d		;; d005: 28 06       (.
	mov	d,m		;; d007: 56          V
	dcx	h		;; d008: 2b          +
	mov	e,m		;; d009: 5e          ^
	xchg			;; d00a: eb          .
	jr	Ld002		;; d00b: 18 f5       ..

Ld00d:	mov	m,b		;; d00d: 70          p
	dcx	h		;; d00e: 2b          +
	mov	m,c		;; d00f: 71          q
	ret			;; d010: c9          .

Ld011:	mov	a,m		;; d011: 7e          ~
	inx	h		;; d012: 23          #
	mov	h,m		;; d013: 66          f
	mov	l,a		;; d014: 6f          o
	ora	h		;; d015: b4          .
	ret			;; d016: c9          .

Ld017:	mov	c,m		;; d017: 4e          N
	inx	h		;; d018: 23          #
	mov	b,m		;; d019: 46          F
	mov	a,b		;; d01a: 78          x
	ora	c		;; d01b: b1          .
	rz			;; d01c: c8          .
	inx	b		;; d01d: 03          .
	ldax	b		;; d01e: 0a          .
	mov	m,a		;; d01f: 77          w
	dcx	b		;; d020: 0b          .
	dcx	h		;; d021: 2b          +
	ldax	b		;; d022: 0a          .
	mov	m,a		;; d023: 77          w
	mov	h,b		;; d024: 60          `
	mov	l,c		;; d025: 69          i
	ret			;; d026: c9          .

Ld027:	lxi	h,Ld81c		;; d027: 21 1c d8    ...
	call	Ld011		;; d02a: cd 11 d0    ...
	rz			;; d02d: c8          .
	inx	h		;; d02e: 23          #
	inx	h		;; d02f: 23          #
	mov	a,m		;; d030: 7e          ~
	ora	a		;; d031: b7          .
	rnz			;; d032: c0          .
	lxi	h,Ld81c		;; d033: 21 1c d8    ...
	call	Ld017		;; d036: cd 17 d0    ...
	lxi	h,Ld81e		;; d039: 21 1e d8    ...
	call	Lcffd		;; d03c: cd fd cf    ...
Ld03f:	lxi	h,Ld81c		;; d03f: 21 1c d8    ...
	call	Ld011		;; d042: cd 11 d0    ...
	rz			;; d045: c8          .
	inx	h		;; d046: 23          #
	inx	h		;; d047: 23          #
	inx	h		;; d048: 23          #
	jmp	Ld501		;; d049: c3 01 d5    ...

Ld04c:	lxi	h,Ld81e		;; d04c: 21 1e d8    ...
	call	Ld017		;; d04f: cd 17 d0    ...
	rz			;; d052: c8          .
	inx	h		;; d053: 23          #
	inx	h		;; d054: 23          #
	mvi	m,0ffh		;; d055: 36 ff       6.
	lxi	h,Ld81c		;; d057: 21 1c d8    ...
	lxi	d,00000h	;; d05a: 11 00 00    ...
	call	Lcffd		;; d05d: cd fd cf    ...
	mov	a,d		;; d060: 7a          z
	ora	e		;; d061: b3          .
	rnz			;; d062: c0          .
	lxi	h,Ld81c		;; d063: 21 1c d8    ...
	call	Ld011		;; d066: cd 11 d0    ...
	inx	h		;; d069: 23          #
	inx	h		;; d06a: 23          #
	inx	h		;; d06b: 23          #
	jmp	Ld501		;; d06c: c3 01 d5    ...

Ld06f:	lxi	h,Ld81e		;; d06f: 21 1e d8    ...
	call	Ld011		;; d072: cd 11 d0    ...
	rz			;; d075: c8          .
	inx	h		;; d076: 23          #
	inx	h		;; d077: 23          #
	mov	a,m		;; d078: 7e          ~
	ora	a		;; d079: b7          .
	mvi	m,0feh		;; d07a: 36 fe       6.
	dcx	h		;; d07c: 2b          +
	dcx	h		;; d07d: 2b          +
	rnz			;; d07e: c0          .
	push	h		;; d07f: e5          .
	lxi	b,00009h	;; d080: 01 09 00    ...
	dad	b		;; d083: 09          .
	mov	a,m		;; d084: 7e          ~
	ani	001h		;; d085: e6 01       ..
	pop	h		;; d087: e1          .
	jrz	Ld08f		;; d088: 28 05       (.
	call	Ld04c		;; d08a: cd 4c d0    .L.
	jr	Ld06f		;; d08d: 18 e0       ..

Ld08f:	sspd	Ldb74		;; d08f: ed 73 74 db .st.
	lxi	sp,Ldb74	;; d093: 31 74 db    1t.
	push	h		;; d096: e5          .
	call	Ld0af		;; d097: cd af d0    ...
	pop	h		;; d09a: e1          .
	call	Lc2f1		;; d09b: cd f1 c2    ...
	call	Ld0bf		;; d09e: cd bf d0    ...
	lspd	Ldb74		;; d0a1: ed 7b 74 db .{t.
	call	Ld04c		;; d0a5: cd 4c d0    .L.
	call	Lcf8f		;; d0a8: cd 8f cf    ...
	call	Ld027		;; d0ab: cd 27 d0    .'.
	ret			;; d0ae: c9          .

Ld0af:	lxi	d,Ldb76		;; d0af: 11 76 db    .v.
	lxi	h,Ldf0f		;; d0b2: 21 0f df    ...
	lxi	b,00038h	;; d0b5: 01 38 00    .8.
	ldir			;; d0b8: ed b0       ..
	lda	Le9de		;; d0ba: 3a de e9    :..
	stax	d		;; d0bd: 12          .
	ret			;; d0be: c9          .

Ld0bf:	lxi	h,Ldb76		;; d0bf: 21 76 db    .v.
	lxi	d,Ldf0f		;; d0c2: 11 0f df    ...
	lxi	b,00038h	;; d0c5: 01 38 00    .8.
	ldir			;; d0c8: ed b0       ..
	mov	a,m		;; d0ca: 7e          ~
	sta	Le9de		;; d0cb: 32 de e9    2..
	ret			;; d0ce: c9          .

Ld0cf:	shld	Ld81a		;; d0cf: 22 1a d8    "..
Ld0d2:	call	Ld027		;; d0d2: cd 27 d0    .'.
	lxi	h,Ld81e		;; d0d5: 21 1e d8    ...
	call	Ld011		;; d0d8: cd 11 d0    ...
	jrz	Ld0f8		;; d0db: 28 1b       (.
	inx	h		;; d0dd: 23          #
	inx	h		;; d0de: 23          #
	mvi	m,0feh		;; d0df: 36 fe       6.
	dcx	h		;; d0e1: 2b          +
	dcx	h		;; d0e2: 2b          +
	push	h		;; d0e3: e5          .
	lxi	b,00009h	;; d0e4: 01 09 00    ...
	dad	b		;; d0e7: 09          .
	mov	a,m		;; d0e8: 7e          ~
	ani	001h		;; d0e9: e6 01       ..
	pop	h		;; d0eb: e1          .
	rnz			;; d0ec: c0          .
	call	Lc2f1		;; d0ed: cd f1 c2    ...
	call	Ld04c		;; d0f0: cd 4c d0    .L.
	call	Lcf8f		;; d0f3: cd 8f cf    ...
	jr	Ld0fb		;; d0f6: 18 03       ..

Ld0f8:	call	Ld387		;; d0f8: cd 87 d3    ...
Ld0fb:	lxi	h,Ld81a		;; d0fb: 21 1a d8    ...
	dcr	m		;; d0fe: 35          5
	jrnz	Ld0d2		;; d0ff: 20 d1        .
	inx	h		;; d101: 23          #
	dcr	m		;; d102: 35          5
	rz			;; d103: c8          .
	jr	Ld0d2		;; d104: 18 cc       ..

Ld106:	jmp	Ld03f		;; d106: c3 3f d0    .?.

Ld109:	lxi	sp,00100h	;; d109: 31 00 01    1..
	call	Ld247		;; d10c: cd 47 d2    .G.
	lxi	d,Ld160		;; d10f: 11 60 d1    .`.
	mvi	c,009h		;; d112: 0e 09       ..
	call	Lc206		;; d114: cd 06 c2    ...
	lda	Ld5b3		;; d117: 3a b3 d5    :..
	call	Lc38d		;; d11a: cd 8d c3    ...
Ld11d:	call	Lc2dd		;; d11d: cd dd c2    ...
	mvi	a,005h		;; d120: 3e 05       >.
	out	007h		;; d122: d3 07       ..
	mvi	a,0eah		;; d124: 3e ea       >.
	out	007h		;; d126: d3 07       ..
	call	Lcff0		;; d128: cd f0 cf    ...
	call	Lcfdc		;; d12b: cd dc cf    ...
	lhld	Ld7c7		;; d12e: 2a c7 d7    *..
	lxi	d,00015h	;; d131: 11 15 00    ...
	dad	d		;; d134: 19          .
	call	Ld15f		;; d135: cd 5f d1    ._.
	call	Ld257		;; d138: cd 57 d2    .W.
	call	Ld03f		;; d13b: cd 3f d0    .?.
	call	Ld17f		;; d13e: cd 7f d1    ...
	lxi	sp,00100h	;; d141: 31 00 01    1..
	mvi	a,0c3h		;; d144: 3e c3       >.
	lhld	Ld7c7		;; d146: 2a c7 d7    *..
	sta	00000h		;; d149: 32 00 00    2..
	shld	00001h		;; d14c: 22 01 00    "..
	sta	00005h		;; d14f: 32 05 00    2..
	lxi	h,Lc206		;; d152: 21 06 c2    ...
	shld	00006h		;; d155: 22 06 00    "..
	lda	00004h		;; d158: 3a 04 00    :..
	mov	c,a		;; d15b: 4f          O
	jmp	0ba03h		;; d15c: c3 03 ba    ...

Ld15f:	pchl			;; d15f: e9          .

Ld160:	db	0dh,0ah,'WARM BOOT - The Web Station $'
Ld17f:	mvi	e,000h		;; d17f: 1e 00       ..
	mvi	c,0cbh		;; d181: 0e cb       ..
	call	Lc206		;; d183: cd 06 c2    ...
	lxi	d,0005ch	;; d186: 11 5c 00    .\.
	lxi	h,Ld1ec		;; d189: 21 ec d1    ...
	lxi	b,0000fh	;; d18c: 01 0f 00    ...
	ldir			;; d18f: ed b0       ..
	xra	a		;; d191: af          .
	sta	0007ch		;; d192: 32 7c 00    2|.
	call	Ld1e2		;; d195: cd e2 d1    ...
	jrnz	Ld1ba		;; d198: 20 20         
	lxi	h,001ffh	;; d19a: 21 ff 01    ...
	shld	Ld5f1		;; d19d: 22 f1 d5    "..
	mvi	c,00dh		;; d1a0: 0e 0d       ..
	call	Lc206		;; d1a2: cd 06 c2    ...
	call	Ld1e2		;; d1a5: cd e2 d1    ...
	jrnz	Ld1ba		;; d1a8: 20 10        .
	lxi	d,Ld1fb		;; d1aa: 11 fb d1    ...
Ld1ad:	mvi	c,009h		;; d1ad: 0e 09       ..
	call	Lc206		;; d1af: cd 06 c2    ...
	mvi	c,001h		;; d1b2: 0e 01       ..
	call	Lc206		;; d1b4: cd 06 c2    ...
	jmp	Ld109		;; d1b7: c3 09 d1    ...

Ld1ba:	lxi	h,0ba00h	;; d1ba: 21 00 ba    ...
	mvi	b,010h		;; d1bd: 06 10       ..
	mvi	c,014h		;; d1bf: 0e 14       ..
Ld1c1:	push	h		;; d1c1: e5          .
	push	b		;; d1c2: c5          .
	xchg			;; d1c3: eb          .
	mvi	c,01ah		;; d1c4: 0e 1a       ..
	call	Lc206		;; d1c6: cd 06 c2    ...
	pop	b		;; d1c9: c1          .
	push	b		;; d1ca: c5          .
	lxi	d,0005ch	;; d1cb: 11 5c 00    .\.
	call	Lc206		;; d1ce: cd 06 c2    ...
	pop	b		;; d1d1: c1          .
	pop	h		;; d1d2: e1          .
	ora	a		;; d1d3: b7          .
	jrnz	Ld1dd		;; d1d4: 20 07        .
	lxi	d,00080h	;; d1d6: 11 80 00    ...
	dad	d		;; d1d9: 19          .
	djnz	Ld1c1		;; d1da: 10 e5       ..
	ret			;; d1dc: c9          .

Ld1dd:	lxi	d,Ld230		;; d1dd: 11 30 d2    .0.
	jr	Ld1ad		;; d1e0: 18 cb       ..

Ld1e2:	lxi	d,0005ch	;; d1e2: 11 5c 00    .\.
	mvi	c,00fh		;; d1e5: 0e 0f       ..
	call	Lc206		;; d1e7: cd 06 c2    ...
	inr	a		;; d1ea: 3c          <
	ret			;; d1eb: c9          .

Ld1ec:	db	1,'WEBCCP10OVL',0,0,0
Ld1fb:	db	'No file WEBCCP10.OVL on A: - Hit any key when ready.$'
Ld230:	db	'Bad Load of WEBCCP.OVL$'
Ld247:	lxi	h,Ld81e		;; d247: 21 1e d8    ...
	call	Ld011		;; d24a: cd 11 d0    ...
	rz			;; d24d: c8          .
	inx	h		;; d24e: 23          #
	inx	h		;; d24f: 23          #
	mov	a,m		;; d250: 7e          ~
	ora	a		;; d251: b7          .
	rz			;; d252: c8          .
	call	Ld04c		;; d253: cd 4c d0    .L.
	ret			;; d256: c9          .

Ld257:	di			;; d257: f3          .
	lxi	h,Ld398		;; d258: 21 98 d3    ...
	lxi	d,Ldbf0		;; d25b: 11 f0 db    ...
	lxi	b,00010h	;; d25e: 01 10 00    ...
	ldir			;; d261: ed b0       ..
	mvi	a,0dbh		;; d263: 3e db       >.
	stai			;; d265: ed 47       .G
	im2			;; d267: ed 5e       .^
	mvi	a,018h		;; d269: 3e 18       >.
	out	006h		;; d26b: d3 06       ..
	out	006h		;; d26d: d3 06       ..
	mvi	a,002h		;; d26f: 3e 02       >.
	out	007h		;; d271: d3 07       ..
	mvi	a,0f0h		;; d273: 3e f0       >.
	out	007h		;; d275: d3 07       ..
	mvi	a,001h		;; d277: 3e 01       >.
	out	007h		;; d279: d3 07       ..
	mvi	a,004h		;; d27b: 3e 04       >.
	out	007h		;; d27d: d3 07       ..
	lxi	h,Ld545		;; d27f: 21 45 d5    .E.
	call	Ld53e		;; d282: cd 3e d5    .>.
	ret			;; d285: c9          .

Ld286:	shld	Ldbc0		;; d286: 22 c0 db    "..
	mvi	a,01eh		;; d289: 3e 1e       >.
	sta	Ldbc3		;; d28b: 32 c3 db    2..
	sspd	Ldbe4		;; d28e: ed 73 e4 db .s..
Ld292:	lxi	sp,Ldbe4	;; d292: 31 e4 db    1..
	push	h		;; d295: e5          .
	lxi	d,00008h	;; d296: 11 08 00    ...
	dad	d		;; d299: 19          .
	mov	a,m		;; d29a: 7e          ~
	adi	008h		;; d29b: c6 08       ..
	mov	b,a		;; d29d: 47          G
	mvi	c,004h		;; d29e: 0e 04       ..
	push	b		;; d2a0: c5          .
Ld2a1:	mvi	c,064h		;; d2a1: 0e 64       .d
Ld2a3:	mvi	a,010h		;; d2a3: 3e 10       >.
	out	006h		;; d2a5: d3 06       ..
	in	006h		;; d2a7: db 06       ..
	ani	008h		;; d2a9: e6 08       ..
	jrz	Ld2bb		;; d2ab: 28 0e       (.
	dcr	c		;; d2ad: 0d          .
	jz	Ld390		;; d2ae: ca 90 d3    ...
	lda	Ldbc2		;; d2b1: 3a c2 db    :..
	ori	007h		;; d2b4: f6 07       ..
	call	Ld371		;; d2b6: cd 71 d3    .q.
	jr	Ld2a3		;; d2b9: 18 e8       ..

Ld2bb:	mvi	a,040h		;; d2bb: 3e 40       >@
	call	Ld383		;; d2bd: cd 83 d3    ...
	mvi	a,010h		;; d2c0: 3e 10       >.
	out	006h		;; d2c2: d3 06       ..
	in	006h		;; d2c4: db 06       ..
	ani	008h		;; d2c6: e6 08       ..
	jrnz	Ld2a1		;; d2c8: 20 d7        .
	di			;; d2ca: f3          .
	mvi	a,001h		;; d2cb: 3e 01       >.
	out	007h		;; d2cd: d3 07       ..
	mvi	a,000h		;; d2cf: 3e 00       >.
	out	007h		;; d2d1: d3 07       ..
	lxi	h,Ld550		;; d2d3: 21 50 d5    .P.
	call	Ld53e		;; d2d6: cd 3e d5    .>.
	ei			;; d2d9: fb          .
	mvi	a,0aah		;; d2da: 3e aa       >.
	out	004h		;; d2dc: d3 04       ..
	mvi	a,005h		;; d2de: 3e 05       >.
	out	006h		;; d2e0: d3 06       ..
	mvi	a,06fh		;; d2e2: 3e 6f       >o
	out	006h		;; d2e4: d3 06       ..
	mvi	a,007h		;; d2e6: 3e 07       >.
Ld2e8:	dcr	a		;; d2e8: 3d          =
	jrnz	Ld2e8		;; d2e9: 20 fd        .
	mvi	a,080h		;; d2eb: 3e 80       >.
	out	006h		;; d2ed: d3 06       ..
	pop	b		;; d2ef: c1          .
	pop	h		;; d2f0: e1          .
	outi			;; d2f1: ed a3       ..
	inx	h		;; d2f3: 23          #
	dcx	h		;; d2f4: 2b          +
	inx	h		;; d2f5: 23          #
	dcx	h		;; d2f6: 2b          +
	inx	h		;; d2f7: 23          #
	dcx	h		;; d2f8: 2b          +
	inx	h		;; d2f9: 23          #
	dcx	h		;; d2fa: 2b          +
	outi			;; d2fb: ed a3       ..
	mvi	a,0d6h		;; d2fd: 3e d6       >.
	out	006h		;; d2ff: d3 06       ..
	inx	h		;; d301: 23          #
	dcx	h		;; d302: 2b          +
	inx	h		;; d303: 23          #
	dcx	h		;; d304: 2b          +
	outi			;; d305: ed a3       ..
	mvi	a,000h		;; d307: 3e 00       >.
	out	006h		;; d309: d3 06       ..
	inx	h		;; d30b: 23          #
	dcx	h		;; d30c: 2b          +
	inx	h		;; d30d: 23          #
	dcx	h		;; d30e: 2b          +
	outi			;; d30f: ed a3       ..
	inx	h		;; d311: 23          #
	dcx	h		;; d312: 2b          +
	inx	h		;; d313: 23          #
	dcx	h		;; d314: 2b          +
	inx	h		;; d315: 23          #
	dcx	h		;; d316: 2b          +
	inx	h		;; d317: 23          #
	dcx	h		;; d318: 2b          +
	outi			;; d319: ed a3       ..
	inx	h		;; d31b: 23          #
	dcx	h		;; d31c: 2b          +
	inx	h		;; d31d: 23          #
	dcx	h		;; d31e: 2b          +
	inx	h		;; d31f: 23          #
	dcx	h		;; d320: 2b          +
	inx	h		;; d321: 23          #
	dcx	h		;; d322: 2b          +
	outi			;; d323: ed a3       ..
	inx	h		;; d325: 23          #
	dcx	h		;; d326: 2b          +
	inx	h		;; d327: 23          #
	dcx	h		;; d328: 2b          +
	inx	h		;; d329: 23          #
	dcx	h		;; d32a: 2b          +
	inx	h		;; d32b: 23          #
	dcx	h		;; d32c: 2b          +
	outi			;; d32d: ed a3       ..
	inx	h		;; d32f: 23          #
	dcx	h		;; d330: 2b          +
	inx	h		;; d331: 23          #
	dcx	h		;; d332: 2b          +
	inx	h		;; d333: 23          #
	dcx	h		;; d334: 2b          +
	inx	h		;; d335: 23          #
	dcx	h		;; d336: 2b          +
	outi			;; d337: ed a3       ..
	inx	h		;; d339: 23          #
	dcx	h		;; d33a: 2b          +
	inx	h		;; d33b: 23          #
	dcx	h		;; d33c: 2b          +
	inx	h		;; d33d: 23          #
	dcx	h		;; d33e: 2b          +
	inx	h		;; d33f: 23          #
	dcx	h		;; d340: 2b          +
Ld341:	outi			;; d341: ed a3       ..
	inx	h		;; d343: 23          #
	dcx	h		;; d344: 2b          +
	inx	h		;; d345: 23          #
	dcx	h		;; d346: 2b          +
	inx	h		;; d347: 23          #
	dcx	h		;; d348: 2b          +
	jrnz	Ld341		;; d349: 20 f6        .
	di			;; d34b: f3          .
	outi			;; d34c: ed a3       ..
Ld34e:	mvi	a,010h		;; d34e: 3e 10       >.
	out	006h		;; d350: d3 06       ..
	in	006h		;; d352: db 06       ..
	cma			;; d354: 2f          /
	ani	044h		;; d355: e6 44       .D
	jrnz	Ld34e		;; d357: 20 f5        .
	lxi	h,Ld55b		;; d359: 21 5b d5    .[.
	call	Ld53e		;; d35c: cd 3e d5    .>.
	call	Ld504		;; d35f: cd 04 d5    ...
	lda	Ldbc2		;; d362: 3a c2 db    :..
	srlr	a		;; d365: cb 3f       .?
	sta	Ldbc2		;; d367: 32 c2 db    2..
	mvi	a,000h		;; d36a: 3e 00       >.
Ld36c:	lspd	Ldbe4		;; d36c: ed 7b e4 db .{..
	ret			;; d370: c9          .

Ld371:	push	b		;; d371: c5          .
	mov	b,a		;; d372: 47          G
	ldar			;; d373: ed 5f       ._
	rrc			;; d375: 0f          .
	rrc			;; d376: 0f          .
	rrc			;; d377: 0f          .
	rrc			;; d378: 0f          .
	ana	b		;; d379: a0          .
	inr	a		;; d37a: 3c          <
	mov	b,a		;; d37b: 47          G
Ld37c:	call	Ld387		;; d37c: cd 87 d3    ...
	djnz	Ld37c		;; d37f: 10 fb       ..
	pop	b		;; d381: c1          .
	ret			;; d382: c9          .

Ld383:	dcr	a		;; d383: 3d          =
	jrnz	Ld383		;; d384: 20 fd        .
	ret			;; d386: c9          .

Ld387:	mvi	a,0dbh		;; d387: 3e db       >.
	call	Ld383		;; d389: cd 83 d3    ...
	call	Lcf8f		;; d38c: cd 8f cf    ...
	ret			;; d38f: c9          .

Ld390:	call	Ld504		;; d390: cd 04 d5    ...
	mvi	a,002h		;; d393: 3e 02       >.
	jmp	Ld36c		;; d395: c3 6c d3    .l.

Ld398:	dw	Ld3a8
	dw	00000h
	dw	00000h
	dw	00000h
	dw	00000h
	dw	Ld4e5
	dw	Ld3cf
	dw	Ld4f4
Ld3a8:	pop	d		;; d3a8: d1          .
	lxi	h,Ld55b		;; d3a9: 21 5b d5    .[.
	call	Ld53e		;; d3ac: cd 3e d5    .>.
	call	Ld504		;; d3af: cd 04 d5    ...
	lda	Ldbc2		;; d3b2: 3a c2 db    :..
	stc			;; d3b5: 37          7
	ral			;; d3b6: 17          .
	sta	Ldbc2		;; d3b7: 32 c2 db    2..
	call	Ld371		;; d3ba: cd 71 d3    .q.
	lda	Ldbc3		;; d3bd: 3a c3 db    :..
	dcr	a		;; d3c0: 3d          =
	sta	Ldbc3		;; d3c1: 32 c3 db    2..
	lhld	Ldbc0		;; d3c4: 2a c0 db    *..
	jnz	Ld292		;; d3c7: c2 92 d2    ...
	mvi	a,001h		;; d3ca: 3e 01       >.
	jmp	Ld36c		;; d3cc: c3 6c d3    .l.

Ld3cf:	push	psw		;; d3cf: f5          .
	push	b		;; d3d0: c5          .
	push	h		;; d3d1: e5          .
	lhld	Ldbe6		;; d3d2: 2a e6 db    *..
	in	004h		;; d3d5: db 04       ..
	cmp	m		;; d3d7: be          .
	mov	m,a		;; d3d8: 77          w
	inx	h		;; d3d9: 23          #
	mvi	c,004h		;; d3da: 0e 04       ..
	jnz	Ld48b		;; d3dc: c2 8b d4    ...
	ini			;; d3df: ed a2       ..
	mvi	a,010h		;; d3e1: 3e 10       >.
	out	006h		;; d3e3: d3 06       ..
	inxix			;; d3e5: dd 23       .#
	dcxix			;; d3e7: dd 2b       .+
	inx	h		;; d3e9: 23          #
	dcx	h		;; d3ea: 2b          +
	ini			;; d3eb: ed a2       ..
	mvi	a,011h		;; d3ed: 3e 11       >.
	out	006h		;; d3ef: d3 06       ..
	inxix			;; d3f1: dd 23       .#
	dcxix			;; d3f3: dd 2b       .+
	inx	h		;; d3f5: 23          #
	dcx	h		;; d3f6: 2b          +
	ini			;; d3f7: ed a2       ..
	mvi	a,009h		;; d3f9: 3e 09       >.
	out	006h		;; d3fb: d3 06       ..
	inxix			;; d3fd: dd 23       .#
	dcxix			;; d3ff: dd 2b       .+
	inx	h		;; d401: 23          #
	dcx	h		;; d402: 2b          +
	ini			;; d403: ed a2       ..
	mvi	a,038h		;; d405: 3e 38       >8
	out	006h		;; d407: d3 06       ..
	ei			;; d409: fb          .
	inx	h		;; d40a: 23          #
	dcx	h		;; d40b: 2b          +
	inx	h		;; d40c: 23          #
	dcx	h		;; d40d: 2b          +
	ini			;; d40e: ed a2       ..
	inx	h		;; d410: 23          #
	dcx	h		;; d411: 2b          +
	inx	h		;; d412: 23          #
	dcx	h		;; d413: 2b          +
	inx	h		;; d414: 23          #
	dcx	h		;; d415: 2b          +
	inx	h		;; d416: 23          #
	dcx	h		;; d417: 2b          +
	ini			;; d418: ed a2       ..
	inx	h		;; d41a: 23          #
	dcx	h		;; d41b: 2b          +
	inx	h		;; d41c: 23          #
	dcx	h		;; d41d: 2b          +
	inx	h		;; d41e: 23          #
	dcx	h		;; d41f: 2b          +
	inx	h		;; d420: 23          #
	dcx	h		;; d421: 2b          +
Ld422:	ini			;; d422: ed a2       ..
	inp	b		;; d424: ed 40       .@
	mov	m,b		;; d426: 70          p
	inx	h		;; d427: 23          #
	inx	h		;; d428: 23          #
	dcx	h		;; d429: 2b          +
	inx	h		;; d42a: 23          #
	dcx	h		;; d42b: 2b          +
	inx	h		;; d42c: 23          #
	dcx	h		;; d42d: 2b          +
Ld42e:	ini			;; d42e: ed a2       ..
	inx	h		;; d430: 23          #
	dcx	h		;; d431: 2b          +
	inx	h		;; d432: 23          #
	dcx	h		;; d433: 2b          +
	inx	h		;; d434: 23          #
	dcx	h		;; d435: 2b          +
	jrnz	Ld42e		;; d436: 20 f6        .
	di			;; d438: f3          .
	in	004h		;; d439: db 04       ..
	inxix			;; d43b: dd 23       .#
	dcxix			;; d43d: dd 2b       .+
	inx	h		;; d43f: 23          #
	dcx	h		;; d440: 2b          +
	inx	h		;; d441: 23          #
	dcx	h		;; d442: 2b          +
	inx	h		;; d443: 23          #
	dcx	h		;; d444: 2b          +
	in	004h		;; d445: db 04       ..
	inxix			;; d447: dd 23       .#
	dcxix			;; d449: dd 2b       .+
	inx	h		;; d44b: 23          #
	dcx	h		;; d44c: 2b          +
	inx	h		;; d44d: 23          #
	dcx	h		;; d44e: 2b          +
	inx	h		;; d44f: 23          #
	dcx	h		;; d450: 2b          +
	in	004h		;; d451: db 04       ..
	inxix			;; d453: dd 23       .#
	dcxix			;; d455: dd 2b       .+
	inx	h		;; d457: 23          #
	dcx	h		;; d458: 2b          +
	inx	h		;; d459: 23          #
	dcx	h		;; d45a: 2b          +
	inx	h		;; d45b: 23          #
	dcx	h		;; d45c: 2b          +
	mvi	a,001h		;; d45d: 3e 01       >.
	out	006h		;; d45f: d3 06       ..
	in	006h		;; d461: db 06       ..
	ani	060h		;; d463: e6 60       .`
	lhld	Ldbe6		;; d465: 2a e6 db    *..
	dcx	h		;; d468: 2b          +
	mov	m,a		;; d469: 77          w
	lxi	h,Ld56f		;; d46a: 21 6f d5    .o.
	call	Ld53e		;; d46d: cd 3e d5    .>.
	lhld	Ldbe6		;; d470: 2a e6 db    *..
	dcx	h		;; d473: 2b          +
	mov	a,m		;; d474: 7e          ~
	ora	a		;; d475: b7          .
	jrz	Ld486		;; d476: 28 0e       (.
Ld478:	inx	h		;; d478: 23          #
	lda	Ld5b3		;; d479: 3a b3 d5    :..
	mov	m,a		;; d47c: 77          w
	call	Ld524		;; d47d: cd 24 d5    .$.
	lxi	h,Ld566		;; d480: 21 66 d5    .f.
	call	Ld53e		;; d483: cd 3e d5    .>.
Ld486:	pop	h		;; d486: e1          .
	pop	b		;; d487: c1          .
	pop	psw		;; d488: f1          .
	ei			;; d489: fb          .
	ret			;; d48a: c9          .

Ld48b:	ini			;; d48b: ed a2       ..
	cpi	0ffh		;; d48d: fe ff       ..
	jrnz	Ld4d3		;; d48f: 20 42        B
	inxix			;; d491: dd 23       .#
	dcxix			;; d493: dd 2b       .+
	inx	h		;; d495: 23          #
	dcx	h		;; d496: 2b          +
	ini			;; d497: ed a2       ..
	mvi	a,010h		;; d499: 3e 10       >.
	out	006h		;; d49b: d3 06       ..
	inxix			;; d49d: dd 23       .#
	dcxix			;; d49f: dd 2b       .+
	inx	h		;; d4a1: 23          #
	dcx	h		;; d4a2: 2b          +
	ini			;; d4a3: ed a2       ..
	mvi	a,011h		;; d4a5: 3e 11       >.
	out	006h		;; d4a7: d3 06       ..
	inxix			;; d4a9: dd 23       .#
	dcxix			;; d4ab: dd 2b       .+
	inx	h		;; d4ad: 23          #
	dcx	h		;; d4ae: 2b          +
	ini			;; d4af: ed a2       ..
	mvi	a,009h		;; d4b1: 3e 09       >.
	out	006h		;; d4b3: d3 06       ..
	inxix			;; d4b5: dd 23       .#
	dcxix			;; d4b7: dd 2b       .+
	inx	h		;; d4b9: 23          #
	dcx	h		;; d4ba: 2b          +
	ini			;; d4bb: ed a2       ..
	mvi	a,038h		;; d4bd: 3e 38       >8
	out	006h		;; d4bf: d3 06       ..
	ei			;; d4c1: fb          .
	inx	h		;; d4c2: 23          #
	dcx	h		;; d4c3: 2b          +
	inx	h		;; d4c4: 23          #
	dcx	h		;; d4c5: 2b          +
	ini			;; d4c6: ed a2       ..
	inx	h		;; d4c8: 23          #
	dcx	h		;; d4c9: 2b          +
	inx	h		;; d4ca: 23          #
	dcx	h		;; d4cb: 2b          +
	inx	h		;; d4cc: 23          #
	dcx	h		;; d4cd: 2b          +
	inx	h		;; d4ce: 23          #
	dcx	h		;; d4cf: 2b          +
	jmp	Ld422		;; d4d0: c3 22 d4    .".

Ld4d3:	mvi	a,013h		;; d4d3: 3e 13       >.
	out	006h		;; d4d5: d3 06       ..
	mvi	a,0d8h		;; d4d7: 3e d8       >.
	out	006h		;; d4d9: d3 06       ..
	mvi	a,001h		;; d4db: 3e 01       >.
Ld4dd:	lhld	Ldbe6		;; d4dd: 2a e6 db    *..
	dcx	h		;; d4e0: 2b          +
	mov	m,a		;; d4e1: 77          w
	jmp	Ld478		;; d4e2: c3 78 d4    .x.

Ld4e5:	mvi	a,003h		;; d4e5: 3e 03       >.
	out	006h		;; d4e7: d3 06       ..
	mvi	a,0d8h		;; d4e9: 3e d8       >.
	out	006h		;; d4eb: d3 06       ..
	in	006h		;; d4ed: db 06       ..
	ani	0f8h		;; d4ef: e6 f8       ..
	pop	h		;; d4f1: e1          .
	jr	Ld4dd		;; d4f2: 18 e9       ..

Ld4f4:	mvi	a,003h		;; d4f4: 3e 03       >.
	out	006h		;; d4f6: d3 06       ..
	mvi	a,0d8h		;; d4f8: 3e d8       >.
	out	006h		;; d4fa: d3 06       ..
	mvi	a,020h		;; d4fc: 3e 20       > 
	pop	h		;; d4fe: e1          .
	jr	Ld4dd		;; d4ff: 18 dc       ..

Ld501:	shld	Ldbe6		;; d501: 22 e6 db    "..
Ld504:	di			;; d504: f3          .
	mvi	a,001h		;; d505: 3e 01       >.
	out	007h		;; d507: d3 07       ..
	mvi	a,004h		;; d509: 3e 04       >.
	out	007h		;; d50b: d3 07       ..
	lhld	Ldbe6		;; d50d: 2a e6 db    *..
	dcx	h		;; d510: 2b          +
	mov	a,m		;; d511: 7e          ~
	ora	a		;; d512: b7          .
	rz			;; d513: c8          .
	inx	h		;; d514: 23          #
	lda	Ld5b3		;; d515: 3a b3 d5    :..
	mov	m,a		;; d518: 77          w
	call	Ld524		;; d519: cd 24 d5    .$.
	lxi	h,Ld566		;; d51c: 21 66 d5    .f.
	call	Ld53e		;; d51f: cd 3e d5    .>.
	ei			;; d522: fb          .
	ret			;; d523: c9          .

Ld524:	mvi	a,030h		;; d524: 3e 30       >0
	out	006h		;; d526: d3 06       ..
	in	006h		;; d528: db 06       ..
	rrc			;; d52a: 0f          .
	rnc			;; d52b: d0          .
	in	004h		;; d52c: db 04       ..
	jr	Ld524		;; d52e: 18 f4       ..

Ld530:	di			;; d530: f3          .
	lxi	h,Ld56f		;; d531: 21 6f d5    .o.
	call	Ld53e		;; d534: cd 3e d5    .>.
	lxi	h,Ld575		;; d537: 21 75 d5    .u.
	shld	Ldbe6		;; d53a: 22 e6 db    "..
	ret			;; d53d: c9          .

Ld53e:	mvi	c,006h		;; d53e: 0e 06       ..
	mov	b,m		;; d540: 46          F
	inx	h		;; d541: 23          #
	outir			;; d542: ed b3       ..
	ret			;; d544: c9          .

Ld545:	db	0ah,14h,10h,16h,0f5h,17h,0fah,13h,0d8h,15h,65h
Ld550:	db	0ah,33h,0d8h,0b1h,0,15h,67h,10h,10h,39h,1
Ld55b:	db	0ah,0,15h,67h,11h,0,15h,65h,16h,0f5h,38h
Ld566:	db	8,70h,13h,0d8h,11h,8,38h,23h,0d9h
Ld56f:	db	4,11h,0,33h,0d8h
	db	0
Ld575:	db	0,0,0,0,0,0,0,0,0,0,0
Ld580:	db	0ffh
Ld581:	db	0ffh,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0
Ld5a7:	db	0,0
Ld5a9:	db	0
Ld5aa:	db	0ffh,0ffh
Ld5ac:	db	0
Ld5ad:	db	0,0
Ld5af:	db	0
Ld5b0:	db	0
Ld5b1:	dw	80h
Ld5b3:	db	0
Ld5b4:	db	1
Ld5b5:	db	0
Ld5b6:	db	0
Ld5b7:	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0
Ld5d8:	db	0,0,0
Ld5db:	db	0
Ld5dc:	db	0
Ld5dd:	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
Ld5ec:	db	0
Ld5ed:	db	0,0
Ld5ef:	db	0
Ld5f0:	db	0
Ld5f1:	db	0ffh
Ld5f2:	db	1,0ffh,2,0ffh,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0
Ld610:	db	0
Ld611:	db	0,0,0ffh
Ld614:	db	0,0,0,0,0,0,20h,0,1,0,0,0,0
Ld621:	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0
Ld644:	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0
Ld6c4:	db	0
Ld6c5:	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
Ld6d4:	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
Ld6e3:	db	0,0
Ld6e5:	db	0
Ld6e6:	db	0,0
Ld6e8:	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
Ld776:	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
Ld785:	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0
Ld7c7:	dw	0fa03h
Ld7c9:	jmp	00000h		;; d7c9: c3 00 00    ...

Ld7ca	equ	$-2
	jmp	00000h		;; d7cc: c3 00 00    ...

Ld7cd	equ	$-2
Ld7cf:	jmp	00000h		;; d7cf: c3 00 00    ...

Ld7d0	equ	$-2
Ld7d2:	jmp	00000h		;; d7d2: c3 00 00    ...

Ld7d3	equ	$-2
Ld7d5:	db	0
Ld7d6:	db	0
Ld7d7:	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0
Ld81a:	db	0,0
Ld81c:	dw	Ld820
Ld81e:	dw	0
Ld820:	dw	Ld92c
	db	0ffh,0,0,0,0,0,0,10h,0,1,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0
Ld92c:	dw	Lda38
	db	0ffh,0,0,0,0,0,0,10h,0,1,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0
Lda38:	dw	0
	db	0ffh,0,0,0,0,0,0,10h,0,1,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
Ldb74:	dw	Ldb74
Ldb76:	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0
Ldbc0:	db	0,0
Ldbc2:	db	0
Ldbc3:	db	1eh,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0
Ldbe4:	db	0,0
Ldbe6:	dw	Ld575
	db	0,0,0,0,0,0,0,0
Ldbf0:	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
; special locations in BDOS
Ldf0f:	equ	$+783
Le9de:	equ	$+3550
	end

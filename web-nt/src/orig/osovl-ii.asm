	maclib	z80

	org	0d100h
	lhld	00001h		;; d100: 2a 01 00    *..
	shld	Le7a7		;; d103: 22 a7 e7    "..
	inx	h		;; d106: 23          #
	mov	e,m		;; d107: 5e          ^
	inx	h		;; d108: 23          #
	mov	d,m		;; d109: 56          V
	sded	Le7ad		;; d10a: ed 53 ad e7 .S..
	inx	h		;; d10e: 23          #
	inx	h		;; d10f: 23          #
	mov	e,m		;; d110: 5e          ^
	inx	h		;; d111: 23          #
	mov	d,m		;; d112: 56          V
	sded	Le7b0		;; d113: ed 53 b0 e7 .S..
	inx	h		;; d117: 23          #
	inx	h		;; d118: 23          #
	mov	e,m		;; d119: 5e          ^
	inx	h		;; d11a: 23          #
	mov	d,m		;; d11b: 56          V
	sded	Le7b3		;; d11c: ed 53 b3 e7 .S..
	lxi	d,Ldfe6		;; d120: 11 e6 df    ...
	mov	m,d		;; d123: 72          r
	dcx	h		;; d124: 2b          +
	mov	m,e		;; d125: 73          s
	dcx	h		;; d126: 2b          +
	dcx	h		;; d127: 2b          +
	lxi	d,Ldff0		;; d128: 11 f0 df    ...
	mov	m,d		;; d12b: 72          r
	dcx	h		;; d12c: 2b          +
	mov	m,e		;; d12d: 73          s
	dcx	h		;; d12e: 2b          +
	dcx	h		;; d12f: 2b          +
	lxi	d,Le109		;; d130: 11 09 e1    ...
	mov	m,d		;; d133: 72          r
	dcx	h		;; d134: 2b          +
	mov	m,e		;; d135: 73          s
	lhld	00006h		;; d136: 2a 06 00    *..
	shld	Le7aa		;; d139: 22 aa e7    "..
	jmp	Le11d		;; d13c: c3 1d e1    ...

	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
Ld206:	pushix			;; d206: dd e5       ..
	sspd	Le765		;; d208: ed 73 65 e7 .se.
	lxi	sp,Le7a7	;; d20c: 31 a7 e7    1..
	mov	a,c		;; d20f: 79          y
	sta	Le5cc		;; d210: 32 cc e5    2..
	sded	Le5cd		;; d213: ed 53 cd e5 .S..
	call	Ldff0		;; d217: cd f0 df    ...
	lda	Le5cc		;; d21a: 3a cc e5    :..
	ora	a		;; d21d: b7          .
	jz	Le109		;; d21e: ca 09 e1    ...
	cpi	00dh		;; d221: fe 0d       ..
	jc	Ldc50		;; d223: da 50 dc    .P.
	cpi	02ch		;; d226: fe 2c       .,
	jrnc	Ld243		;; d228: 30 19       0.
	sui	00dh		;; d22a: d6 0d       ..
	lxix	Le5f1		;; d22c: dd 21 f1 e5 ....
	lxi	h,Ldf3d		;; d230: 21 3d df    .=.
	jmp	Ld3d2		;; d233: c3 d2 d3    ...

Ld236:	lxi	h,00000h	;; d236: 21 00 00    ...
Ld239:	mov	a,l		;; d239: 7d          }
Ld23a:	mov	l,a		;; d23a: 6f          o
	mov	b,h		;; d23b: 44          D
	lspd	Le765		;; d23c: ed 7b 65 e7 .{e.
	popix			;; d240: dd e1       ..
	ret			;; d242: c9          .

Ld243:	sui	0c8h		;; d243: d6 c8       ..
	jrc	Ld236		;; d245: 38 ef       8.
	cpi	00ah		;; d247: fe 0a       ..
	jrnc	Ld236		;; d249: 30 eb       0.
	lxi	h,Ldf7b		;; d24b: 21 7b df    .{.
	jmp	Ld3d2		;; d24e: c3 d2 d3    ...

Ld251:	lxi	h,Le595		;; d251: 21 95 e5    ...
	jr	Ld239		;; d254: 18 e3       ..

Ld256:	lxi	h,Le5d1		;; d256: 21 d1 e5    ...
	jr	Ld239		;; d259: 18 de       ..

Ld25b:	lxi	h,Le560		;; d25b: 21 60 e5    .`.
	jr	Ld239		;; d25e: 18 d9       ..

Ld260:	lda	Le5cd		;; d260: 3a cd e5    :..
	inr	a		;; d263: 3c          <
	jz	Ldd05		;; d264: ca 05 dd    ...
	mvi	a,020h		;; d267: 3e 20       > 
	sta	Le5cc		;; d269: 32 cc e5    2..
	jmp	Ldd1b		;; d26c: c3 1b dd    ...

Ld26f:	lhld	Le5cd		;; d26f: 2a cd e5    *..
	call	Le284		;; d272: cd 84 e2    ...
	jr	Ld23a		;; d275: 18 c3       ..

Ld277:	lhld	Le5cd		;; d277: 2a cd e5    *..
	call	Le0cf		;; d27a: cd cf e0    ...
	jrz	Ld236		;; d27d: 28 b7       (.
	inx	h		;; d27f: 23          #
	inx	h		;; d280: 23          #
	inx	h		;; d281: 23          #
	jr	Ld239		;; d282: 18 b5       ..

Ld284:	call	Le04c		;; d284: cd 4c e0    .L.
	jr	Ld23a		;; d287: 18 b1       ..

Ld289:	call	Le4b4		;; d289: cd b4 e4    ...
	jr	Ld23a		;; d28c: 18 ac       ..

Ld28e:	call	Le106		;; d28e: cd 06 e1    ...
	jr	Ld23a		;; d291: 18 a7       ..

Ld293:	lxi	d,Ldf04		;; d293: 11 04 df    ...
	call	Ld861		;; d296: cd 61 d8    .a.
	lxi	h,Le5d1		;; d299: 21 d1 e5    ...
	lxi	b,01040h	;; d29c: 01 40 10    .@.
Ld29f:	inr	c		;; d29f: 0c          .
	inx	h		;; d2a0: 23          #
	mov	a,m		;; d2a1: 7e          ~
	ora	a		;; d2a2: b7          .
	jrz	Ld2cf		;; d2a3: 28 2a       (*
	mov	a,c		;; d2a5: 79          y
	call	Ld2e4		;; d2a6: cd e4 d2    ...
	lxi	d,Ldf31		;; d2a9: 11 31 df    .1.
	call	Ld2d5		;; d2ac: cd d5 d2    ...
	mov	a,m		;; d2af: 7e          ~
	adi	040h		;; d2b0: c6 40       .@
	call	Ld2e4		;; d2b2: cd e4 d2    ...
	mvi	a,03ah		;; d2b5: 3e 3a       >:
	call	Ld2e4		;; d2b7: cd e4 d2    ...
	dcx	h		;; d2ba: 2b          +
	mov	a,m		;; d2bb: 7e          ~
	cpi	0ffh		;; d2bc: fe ff       ..
	jrnz	Ld2c8		;; d2be: 20 08        .
	lxi	d,Ldf36		;; d2c0: 11 36 df    .6.
	call	Ld2d5		;; d2c3: cd d5 d2    ...
	jr	Ld2cb		;; d2c6: 18 03       ..

Ld2c8:	call	Ld38d		;; d2c8: cd 8d d3    ...
Ld2cb:	call	Ld2dd		;; d2cb: cd dd d2    ...
	inx	h		;; d2ce: 23          #
Ld2cf:	inx	h		;; d2cf: 23          #
	djnz	Ld29f		;; d2d0: 10 cd       ..
	jmp	Ld23a		;; d2d2: c3 3a d2    .:.

Ld2d5:	push	b		;; d2d5: c5          .
	push	h		;; d2d6: e5          .
	call	Ld861		;; d2d7: cd 61 d8    .a.
	pop	h		;; d2da: e1          .
	pop	b		;; d2db: c1          .
	ret			;; d2dc: c9          .

Ld2dd:	mvi	a,00dh		;; d2dd: 3e 0d       >.
	call	Ld2e4		;; d2df: cd e4 d2    ...
	mvi	a,00ah		;; d2e2: 3e 0a       >.
Ld2e4:	push	b		;; d2e4: c5          .
	mvi	c,002h		;; d2e5: 0e 02       ..
	ani	07fh		;; d2e7: e6 7f       ..
	mov	e,a		;; d2e9: 5f          _
	push	h		;; d2ea: e5          .
	call	Le7a9		;; d2eb: cd a9 e7    ...
	pop	h		;; d2ee: e1          .
	pop	b		;; d2ef: c1          .
	ret			;; d2f0: c9          .

Ld2f1:	shld	Le58d		;; d2f1: 22 8d e5    "..
	lxi	b,00009h	;; d2f4: 01 09 00    ...
	dad	b		;; d2f7: 09          .
	mov	a,m		;; d2f8: 7e          ~
	cpi	010h		;; d2f9: fe 10       ..
	jz	Ld304		;; d2fb: ca 04 d3    ...
	cpi	020h		;; d2fe: fe 20       . 
	jz	Ld3bc		;; d300: ca bc d3    ...
	ret			;; d303: c9          .

Ld304:	lda	Le594		;; d304: 3a 94 e5    :..
	ora	a		;; d307: b7          .
	rz			;; d308: c8          .
	pushix			;; d309: dd e5       ..
	lixd	Le58d		;; d30b: dd 2a 8d e5 .*..
	inx	h		;; d30f: 23          #
	inx	h		;; d310: 23          #
	push	h		;; d311: e5          .
	mvi	c,009h		;; d312: 0e 09       ..
	lxi	d,Ld367		;; d314: 11 67 d3    .g.
	call	Le7a9		;; d317: cd a9 e7    ...
	ldx	a,+3		;; d31a: dd 7e 03    .~.
	cpi	0ffh		;; d31d: fe ff       ..
	jrz	Ld326		;; d31f: 28 05       (.
	call	Ld38d		;; d321: cd 8d d3    ...
	jr	Ld32e		;; d324: 18 08       ..

Ld326:	mvi	c,009h		;; d326: 0e 09       ..
	lxi	d,Ld376		;; d328: 11 76 d3    .v.
	call	Le7a9		;; d32b: cd a9 e7    ...
Ld32e:	mvi	c,009h		;; d32e: 0e 09       ..
	lxi	d,Ld37a		;; d330: 11 7a d3    .z.
	call	Le7a9		;; d333: cd a9 e7    ...
	ldx	a,+6		;; d336: dd 7e 06    .~.
	call	Ld38d		;; d339: cd 8d d3    ...
	mvi	c,009h		;; d33c: 0e 09       ..
	lxi	d,Ld381		;; d33e: 11 81 d3    ...
	call	Le7a9		;; d341: cd a9 e7    ...
	pop	h		;; d344: e1          .
	mov	b,m		;; d345: 46          F
	mvi	m,001h		;; d346: 36 01       6.
	mvi	c,002h		;; d348: 0e 02       ..
Ld34a:	inx	h		;; d34a: 23          #
	mov	e,m		;; d34b: 5e          ^
	push	h		;; d34c: e5          .
	push	b		;; d34d: c5          .
	call	Le7a9		;; d34e: cd a9 e7    ...
	pop	b		;; d351: c1          .
	pop	h		;; d352: e1          .
	djnz	Ld34a		;; d353: 10 f5       ..
	mvi	c,009h		;; d355: 0e 09       ..
	lxi	d,Ld386		;; d357: 11 86 d3    ...
	call	Le7a9		;; d35a: cd a9 e7    ...
	ldx	a,+3		;; d35d: dd 7e 03    .~.
	inr	a		;; d360: 3c          <
	cnz	Ld3a3		;; d361: c4 a3 d3    ...
	popix			;; d364: dd e1       ..
	ret			;; d366: c9          .

Ld367:	db	7,0dh,0ah,'Message to $'
Ld376:	db	'all$'
Ld37a:	db	' from $'
Ld381:	db	':',0dh,0ah,9,'$'
Ld386:	db	0dh,0ah,'... $'
Ld38d:	push	psw		;; d38d: f5          .
	rrc			;; d38e: 0f          .
	rrc			;; d38f: 0f          .
	rrc			;; d390: 0f          .
	rrc			;; d391: 0f          .
	call	Ld396		;; d392: cd 96 d3    ...
	pop	psw		;; d395: f1          .
Ld396:	ani	00fh		;; d396: e6 0f       ..
	cpi	00ah		;; d398: fe 0a       ..
	jrc	Ld39e		;; d39a: 38 02       8.
	adi	007h		;; d39c: c6 07       ..
Ld39e:	adi	030h		;; d39e: c6 30       .0
	jmp	Ld2e4		;; d3a0: c3 e4 d2    ...

Ld3a3:	ldx	a,+6		;; d3a3: dd 7e 06    .~.
	stx	a,+3		;; d3a6: dd 77 03    .w.
	lda	Le593		;; d3a9: 3a 93 e5    :..
	stx	a,+6		;; d3ac: dd 77 06    .w.
	setx	0,+9		;; d3af: dd cb 09 c6 ....
	lhld	Le58d		;; d3b3: 2a 8d e5    *..
	inx	h		;; d3b6: 23          #
	inx	h		;; d3b7: 23          #
	inx	h		;; d3b8: 23          #
	jmp	Le284		;; d3b9: c3 84 e2    ...

Ld3bc:	pushix			;; d3bc: dd e5       ..
	lixd	Le58d		;; d3be: dd 2a 8d e5 .*..
	ldx	a,+12		;; d3c2: dd 7e 0c    .~.
	sui	00fh		;; d3c5: d6 0f       ..
	jc	Ld48c		;; d3c7: da 8c d4    ...
	cpi	01dh		;; d3ca: fe 1d       ..
	jnc	Ld48c		;; d3cc: d2 8c d4    ...
	lxi	h,Ld65a		;; d3cf: 21 5a d6    .Z.
Ld3d2:	add	a		;; d3d2: 87          .
	mov	e,a		;; d3d3: 5f          _
	mvi	d,000h		;; d3d4: 16 00       ..
	dad	d		;; d3d6: 19          .
	mov	e,m		;; d3d7: 5e          ^
	inx	h		;; d3d8: 23          #
	mov	d,m		;; d3d9: 56          V
	xchg			;; d3da: eb          .
	pchl			;; d3db: e9          .

Ld3dc:	mvi	c,020h		;; d3dc: 0e 20       . 
	ldx	e,+13		;; d3de: dd 5e 0d    .^.
	jmp	Le7a9		;; d3e1: c3 a9 e7    ...

Ld3e4:	lhld	Le58d		;; d3e4: 2a 8d e5    *..
	lxi	d,0000fh	;; d3e7: 11 0f 00    ...
	dad	d		;; d3ea: 19          .
	xchg			;; d3eb: eb          .
	ret			;; d3ec: c9          .

Ld3ed:	mvi	c,020h		;; d3ed: 0e 20       . 
	lda	Le590		;; d3ef: 3a 90 e5    :..
	mov	e,a		;; d3f2: 5f          _
	jmp	Le7a9		;; d3f3: c3 a9 e7    ...

Ld3f6:	mvi	c,01ah		;; d3f6: 0e 1a       ..
	lhld	Le58d		;; d3f8: 2a 8d e5    *..
	lxi	d,00033h	;; d3fb: 11 33 00    .3.
	dad	d		;; d3fe: 19          .
	xchg			;; d3ff: eb          .
	jmp	Le7a9		;; d400: c3 a9 e7    ...

Ld403:	mvi	c,01ah		;; d403: 0e 1a       ..
	lded	Le591		;; d405: ed 5b 91 e5 .[..
	jmp	Le7a9		;; d409: c3 a9 e7    ...

Ld40c:	call	Ld3e4		;; d40c: cd e4 d3    ...
Ld40f:	ldx	c,+12		;; d40f: dd 4e 0c    .N.
	call	Le7a9		;; d412: cd a9 e7    ...
	stx	a,+14		;; d415: dd 77 0e    .w.
	ret			;; d418: c9          .

Ld419:	mvi	c,019h		;; d419: 0e 19       ..
	call	Le7a9		;; d41b: cd a9 e7    ...
	sta	Le596		;; d41e: 32 96 e5    2..
	ldx	e,+14		;; d421: dd 5e 0e    .^.
	mvi	c,00eh		;; d424: 0e 0e       ..
	jmp	Le7a9		;; d426: c3 a9 e7    ...

Ld429:	lda	Le596		;; d429: 3a 96 e5    :..
	mov	e,a		;; d42c: 5f          _
	mvi	c,00eh		;; d42d: 0e 0e       ..
	jmp	Le7a9		;; d42f: c3 a9 e7    ...

Ld432:	call	Ld3dc		;; d432: cd dc d3    ...
	call	Ld3f6		;; d435: cd f6 d3    ...
Ld438:	call	Ld3e4		;; d438: cd e4 d3    ...
	mvi	c,011h		;; d43b: 0e 11       ..
	call	Le7a9		;; d43d: cd a9 e7    ...
Ld440:	cpi	0ffh		;; d440: fe ff       ..
	rz			;; d442: c8          .
	add	a		;; d443: 87          .
	add	a		;; d444: 87          .
	add	a		;; d445: 87          .
	add	a		;; d446: 87          .
	add	a		;; d447: 87          .
	lhld	Le58d		;; d448: 2a 8d e5    *..
	lxi	d,00033h	;; d44b: 11 33 00    .3.
	dad	d		;; d44e: 19          .
	mov	e,a		;; d44f: 5f          _
	mvi	d,000h		;; d450: 16 00       ..
	dad	d		;; d452: 19          .
	inr	a		;; d453: 3c          <
	ret			;; d454: c9          .

Ld455:	call	Ld432		;; d455: cd 32 d4    .2.
	jrz	Ld49f		;; d458: 28 45       (E
	mov	d,h		;; d45a: 54          T
	mov	e,l		;; d45b: 5d          ]
	inx	h		;; d45c: 23          #
	bit	7,m		;; d45d: cb 7e       .~
	jrnz	Ld495		;; d45f: 20 34        4
	inx	h		;; d461: 23          #
	bit	7,m		;; d462: cb 7e       .~
	jrz	Ld473		;; d464: 28 0d       (.
	inx	h		;; d466: 23          #
	bit	7,m		;; d467: cb 7e       .~
	jrnz	Ld49b		;; d469: 20 30        0
	setb	7,m		;; d46b: cb fe       ..
	call	Ld4a9		;; d46d: cd a9 d4    ...
	call	Ld6e6		;; d470: cd e6 d6    ...
Ld473:	call	Ld40c		;; d473: cd 0c d4    ...
Ld476:	mvix	027h,+11	;; d476: dd 36 0b 27 .6.'
Ld47a:	call	Ld403		;; d47a: cd 03 d4    ...
Ld47d:	call	Ld3ed		;; d47d: cd ed d3    ...
Ld480:	call	Ld3a3		;; d480: cd a3 d3    ...
	ldx	a,+3		;; d483: dd 7e 03    .~.
	sta	Le58f		;; d486: 32 8f e5    2..
	call	Ld516		;; d489: cd 16 d5    ...
Ld48c:	popix			;; d48c: dd e1       ..
	ret			;; d48e: c9          .

Ld48f:	mvix	012h,+8		;; d48f: dd 36 08 12 .6..
	jr	Ld49f		;; d493: 18 0a       ..

Ld495:	mvix	011h,+8		;; d495: dd 36 08 11 .6..
	jr	Ld49f		;; d499: 18 04       ..

Ld49b:	mvix	010h,+8		;; d49b: dd 36 08 10 .6..
Ld49f:	mvix	0ffh,+14	;; d49f: dd 36 0e ff .6..
Ld4a3:	mvix	003h,+11	;; d4a3: dd 36 0b 03 .6..
	jr	Ld47a		;; d4a7: 18 d1       ..

Ld4a9:	ldx	a,+15		;; d4a9: dd 7e 0f    .~.
	stax	d		;; d4ac: 12          .
	mvi	c,01eh		;; d4ad: 0e 1e       ..
	jmp	Le7a9		;; d4af: c3 a9 e7    ...

Ld4b2:	pop	b		;; d4b2: c1          .
	inx	h		;; d4b3: 23          #
	bit	7,m		;; d4b4: cb 7e       .~
	jrnz	Ld495		;; d4b6: 20 dd        .
	inx	h		;; d4b8: 23          #
	inx	h		;; d4b9: 23          #
	bit	7,m		;; d4ba: cb 7e       .~
	jrnz	Ld49b		;; d4bc: 20 dd        .
	lxi	d,00006h	;; d4be: 11 06 00    ...
	dad	d		;; d4c1: 19          .
	bit	7,m		;; d4c2: cb 7e       .~
	jrnz	Ld48f		;; d4c4: 20 c9        .
	push	b		;; d4c6: c5          .
	ret			;; d4c7: c9          .

Ld4c8:	call	Ld432		;; d4c8: cd 32 d4    .2.
	jrz	Ld49f		;; d4cb: 28 d2       (.
	call	Ld4b2		;; d4cd: cd b2 d4    ...
	call	Ld3e4		;; d4d0: cd e4 d3    ...
	xchg			;; d4d3: eb          .
	call	Lda39		;; d4d4: cd 39 da    .9.
	jrnz	Ld49f		;; d4d7: 20 c6        .
	call	Ld40c		;; d4d9: cd 0c d4    ...
	jr	Ld4a3		;; d4dc: 18 c5       ..

Ld4de:	call	Ld432		;; d4de: cd 32 d4    .2.
	jrz	Ld49f		;; d4e1: 28 bc       (.
Ld4e3:	call	Ld4b2		;; d4e3: cd b2 d4    ...
	mvi	c,012h		;; d4e6: 0e 12       ..
	call	Le7a9		;; d4e8: cd a9 e7    ...
	call	Ld440		;; d4eb: cd 40 d4    .@.
	jrnz	Ld4e3		;; d4ee: 20 f3        .
	call	Ld40c		;; d4f0: cd 0c d4    ...
	jmp	Ld4a3		;; d4f3: c3 a3 d4    ...

Ld4f6:	mvi	b,008h		;; d4f6: 06 08       ..
	lxi	h,Le5bc		;; d4f8: 21 bc e5    ...
Ld4fb:	mov	a,m		;; d4fb: 7e          ~
	cmp	c		;; d4fc: b9          .
	inx	h		;; d4fd: 23          #
	rz			;; d4fe: c8          .
	inx	h		;; d4ff: 23          #
	djnz	Ld4fb		;; d500: 10 f9       ..
	dcx	h		;; d502: 2b          +
	ret			;; d503: c9          .

Ld504:	push	h		;; d504: e5          .
	lxi	d,Le5bd		;; d505: 11 bd e5    ...
	ora	a		;; d508: b7          .
	dsbc	d		;; d509: ed 52       .R
	pop	d		;; d50b: d1          .
	rz			;; d50c: c8          .
	mov	b,h		;; d50d: 44          D
	mov	c,l		;; d50e: 4d          M
	mov	h,d		;; d50f: 62          b
	mov	l,e		;; d510: 6b          k
	dcx	h		;; d511: 2b          +
	dcx	h		;; d512: 2b          +
	lddr			;; d513: ed b8       ..
	ret			;; d515: c9          .

Ld516:	mov	c,a		;; d516: 4f          O
	push	psw		;; d517: f5          .
	call	Ld4f6		;; d518: cd f6 d4    ...
	call	Ld504		;; d51b: cd 04 d5    ...
	pop	psw		;; d51e: f1          .
	lxi	h,Le5bc		;; d51f: 21 bc e5    ...
	mov	m,a		;; d522: 77          w
	inx	h		;; d523: 23          #
	ldx	a,+10		;; d524: dd 7e 0a    .~.
	mov	m,a		;; d527: 77          w
	ret			;; d528: c9          .

Ld529:	ldx	c,+6		;; d529: dd 4e 06    .N.
	call	Ld4f6		;; d52c: cd f6 d4    ...
	jrnz	Ld53e		;; d52f: 20 0d        .
	mov	a,m		;; d531: 7e          ~
	cmpx	+10		;; d532: dd be 0a    ...
	jrnz	Ld53e		;; d535: 20 07        .
	mvix	001h,+8		;; d537: dd 36 08 01 .6..
	jmp	Ld49f		;; d53b: c3 9f d4    ...

Ld53e:	call	Ld3dc		;; d53e: cd dc d3    ...
	call	Ld3f6		;; d541: cd f6 d3    ...
	call	Ld40c		;; d544: cd 0c d4    ...
	bitx	7,+18		;; d547: dd cb 12 7e ...~
	jnz	Ld476		;; d54b: c2 76 d4    .v.
	setx	7,+18		;; d54e: dd cb 12 fe ....
	call	Ld438		;; d552: cd 38 d4    .8.
	jz	Ld476		;; d555: ca 76 d4    .v.
	mov	d,h		;; d558: 54          T
	mov	e,l		;; d559: 5d          ]
	inx	h		;; d55a: 23          #
	inx	h		;; d55b: 23          #
	inx	h		;; d55c: 23          #
	setb	7,m		;; d55d: cb fe       ..
	call	Ld4a9		;; d55f: cd a9 d4    ...
	call	Ld6e6		;; d562: cd e6 d6    ...
	jmp	Ld476		;; d565: c3 76 d4    .v.

Ld568:	call	Ld3dc		;; d568: cd dc d3    ...
	call	Ld40c		;; d56b: cd 0c d4    ...
	call	Ld432		;; d56e: cd 32 d4    .2.
	mov	d,h		;; d571: 54          T
	mov	e,l		;; d572: 5d          ]
	inx	h		;; d573: 23          #
	inx	h		;; d574: 23          #
	inx	h		;; d575: 23          #
	res	7,m		;; d576: cb be       ..
	call	Ld4a9		;; d578: cd a9 d4    ...
	call	Ld70b		;; d57b: cd 0b d7    ...
	jmp	Ld4a3		;; d57e: c3 a3 d4    ...

Ld581:	call	Ld3dc		;; d581: cd dc d3    ...
	call	Ld3f6		;; d584: cd f6 d3    ...
	call	Ld40c		;; d587: cd 0c d4    ...
	mvix	0a7h,+11	;; d58a: dd 36 0b a7 .6..
	jmp	Ld47a		;; d58e: c3 7a d4    .z.

Ld591:	call	Ld432		;; d591: cd 32 d4    .2.
	jnz	Ld49f		;; d594: c2 9f d4    ...
Ld597:	call	Ld3dc		;; d597: cd dc d3    ...
	call	Ld40c		;; d59a: cd 0c d4    ...
	mvix	027h,+11	;; d59d: dd 36 0b 27 .6.'
	jmp	Ld47d		;; d5a1: c3 7d d4    .}.

Ld5a4:	call	Ld419		;; d5a4: cd 19 d4    ...
	ldx	c,+12		;; d5a7: dd 4e 0c    .N.
	call	Le7a9		;; d5aa: cd a9 e7    ...
	xchg			;; d5ad: eb          .
	lhld	Le58d		;; d5ae: 2a 8d e5    *..
	lxi	b,0000fh	;; d5b1: 01 0f 00    ...
	dad	b		;; d5b4: 09          .
	mvix	012h,+11	;; d5b5: dd 36 0b 12 .6..
	xchg			;; d5b9: eb          .
	ldx	a,+12		;; d5ba: dd 7e 0c    .~.
	cpi	01fh		;; d5bd: fe 1f       ..
	jrz	Ld5c8		;; d5bf: 28 07       (.
	lxi	b,0008eh	;; d5c1: 01 8e 00    ...
	mvix	091h,+11	;; d5c4: dd 36 0b 91 .6..
Ld5c8:	ldir			;; d5c8: ed b0       ..
	call	Ld429		;; d5ca: cd 29 d4    .).
	jmp	Ld480		;; d5cd: c3 80 d4    ...

Ld5d0:	call	Ld64d		;; d5d0: cd 4d d6    .M.
	ldx	a,+15		;; d5d3: dd 7e 0f    .~.
	cpi	03fh		;; d5d6: fe 3f       .?
	push	psw		;; d5d8: f5          .
	cz	Ld419		;; d5d9: cc 19 d4    ...
	call	Ld3f6		;; d5dc: cd f6 d3    ...
	call	Ld3dc		;; d5df: cd dc d3    ...
Ld5e2:	lxi	d,Le597		;; d5e2: 11 97 e5    ...
	call	Ld40f		;; d5e5: cd 0f d4    ...
	pop	psw		;; d5e8: f1          .
	cz	Ld429		;; d5e9: cc 29 d4    .).
Ld5ec:	mvix	0a7h,+11	;; d5ec: dd 36 0b a7 .6..
	jmp	Ld47a		;; d5f0: c3 7a d4    .z.

Ld5f3:	lda	Le5b8		;; d5f3: 3a b8 e5    :..
	inr	a		;; d5f6: 3c          <
	cmpx	+48		;; d5f7: dd be 30    ..0
	jrz	Ld601		;; d5fa: 28 05       (.
	mvi	a,0ffh		;; d5fc: 3e ff       >.
	sta	Le58f		;; d5fe: 32 8f e5    2..
Ld601:	call	Ld64d		;; d601: cd 4d d6    .M.
	call	Ld419		;; d604: cd 19 d4    ...
	call	Ld3f6		;; d607: cd f6 d3    ...
	call	Ld3dc		;; d60a: cd dc d3    ...
	lxi	d,Le597		;; d60d: 11 97 e5    ...
	lda	Le58f		;; d610: 3a 8f e5    :..
	cmpx	+6		;; d613: dd be 06    ...
	jrz	Ld627		;; d616: 28 0f       (.
	ldax	d		;; d618: 1a          .
	push	psw		;; d619: f5          .
	mvi	c,011h		;; d61a: 0e 11       ..
	call	Le7a9		;; d61c: cd a9 e7    ...
	pop	psw		;; d61f: f1          .
	cpi	03fh		;; d620: fe 3f       .?
	jrz	Ld62e		;; d622: 28 0a       (.
	lxi	d,Le597		;; d624: 11 97 e5    ...
Ld627:	call	Ldc2f		;; d627: cd 2f dc    ./.
	xra	a		;; d62a: af          .
	push	psw		;; d62b: f5          .
	jr	Ld5e2		;; d62c: 18 b4       ..

Ld62e:	ldx	b,+48		;; d62e: dd 46 30    .F0
	mvi	c,012h		;; d631: 0e 12       ..
Ld633:	push	b		;; d633: c5          .
	call	Le7a9		;; d634: cd a9 e7    ...
	pop	b		;; d637: c1          .
	djnz	Ld633		;; d638: 10 f9       ..
	stx	a,+14		;; d63a: dd 77 0e    .w.
	ldx	a,+49		;; d63d: dd 7e 31    .~1
	ora	a		;; d640: b7          .
	jrz	Ld648		;; d641: 28 05       (.
	dcrx	+49		;; d643: dd 35 31    .51
	jr	Ld633		;; d646: 18 eb       ..

Ld648:	call	Ld429		;; d648: cd 29 d4    .).
	jr	Ld5ec		;; d64b: 18 9f       ..

Ld64d:	call	Ld3e4		;; d64d: cd e4 d3    ...
	lxi	h,Le597		;; d650: 21 97 e5    ...
	xchg			;; d653: eb          .
	lxi	b,00024h	;; d654: 01 24 00    .$.
	ldir			;; d657: ed b0       ..
	ret			;; d659: c9          .

Ld65a:	dw	Ld455
	dw	Ld568
	dw	Ld5d0
	dw	Ld5f3
	dw	Ld4de
	dw	Ld581
	dw	Ld529
	dw	Ld591
	dw	Ld4c8
	dw	Ld48c
	dw	Ld48c
	dw	Ld48c
	dw	Ld5a4
	dw	Ld48c
	dw	Ld48c
	dw	Ld597
	dw	Ld5a4
	dw	Ld48c
	dw	Ld581
	dw	Ld529
	dw	Ld597
	dw	Ld597
	dw	Ld48c
	dw	Ld48c
	dw	Ld48c
	dw	Ld529
	dw	Ld48c
	dw	Ld48c
	dw	Ld48c
Ld694:	mov	a,m		;; d694: 7e          ~
	cpi	0ffh		;; d695: fe ff       ..
	inx	h		;; d697: 23          #
	jrz	Ld69d		;; d698: 28 03       (.
	inx	h		;; d69a: 23          #
	jr	Ld694		;; d69b: 18 f7       ..

Ld69d:	mov	a,m		;; d69d: 7e          ~
	cmp	b		;; d69e: b8          .
	inx	h		;; d69f: 23          #
	jrc	Ld694		;; d6a0: 38 f2       8.
	ret			;; d6a2: c9          .

Ld6a3:	mov	a,m		;; d6a3: 7e          ~
	cmp	c		;; d6a4: b9          .
	rnc			;; d6a5: d0          .
	inx	h		;; d6a6: 23          #
	inx	h		;; d6a7: 23          #
	jr	Ld6a3		;; d6a8: 18 f9       ..

Ld6aa:	push	b		;; d6aa: c5          .
	push	h		;; d6ab: e5          .
	ora	a		;; d6ac: b7          .
	xchg			;; d6ad: eb          .
	lxi	h,Le587		;; d6ae: 21 87 e5    ...
	dsbc	d		;; d6b1: ed 52       .R
	jrc	Ld6c7		;; d6b3: 38 12       8.
	inx	h		;; d6b5: 23          #
	mov	b,h		;; d6b6: 44          D
	mov	c,l		;; d6b7: 4d          M
	lxi	d,Le589		;; d6b8: 11 89 e5    ...
	lxi	h,Le587		;; d6bb: 21 87 e5    ...
	lddr			;; d6be: ed b8       ..
	pop	h		;; d6c0: e1          .
	pop	b		;; d6c1: c1          .
	mov	m,c		;; d6c2: 71          q
	inx	h		;; d6c3: 23          #
	mov	m,b		;; d6c4: 70          p
	inx	h		;; d6c5: 23          #
	ret			;; d6c6: c9          .

Ld6c7:	pop	h		;; d6c7: e1          .
	pop	b		;; d6c8: c1          .
	ret			;; d6c9: c9          .

Ld6ca:	push	h		;; d6ca: e5          .
	xchg			;; d6cb: eb          .
	lxi	h,Le58a		;; d6cc: 21 8a e5    ...
	ora	a		;; d6cf: b7          .
	dsbc	d		;; d6d0: ed 52       .R
	mov	b,h		;; d6d2: 44          D
	mov	c,l		;; d6d3: 4d          M
	mov	h,d		;; d6d4: 62          b
	mov	l,e		;; d6d5: 6b          k
	inx	h		;; d6d6: 23          #
	inx	h		;; d6d7: 23          #
	ldir			;; d6d8: ed b0       ..
	pop	h		;; d6da: e1          .
	ret			;; d6db: c9          .

	lxi	h,0ffffh	;; d6dc: 21 ff ff    ...
	shld	Le560		;; d6df: 22 60 e5    "`.
	shld	Le58a		;; d6e2: 22 8a e5    "..
	ret			;; d6e5: c9          .

Ld6e6:	ldx	b,+15		;; d6e6: dd 46 0f    .F.
	lxi	h,Le560		;; d6e9: 21 60 e5    .`.
	call	Ld694		;; d6ec: cd 94 d6    ...
	jrz	Ld700		;; d6ef: 28 0f       (.
	dcx	h		;; d6f1: 2b          +
	dcx	h		;; d6f2: 2b          +
	mvi	c,0ffh		;; d6f3: 0e ff       ..
	call	Ld6aa		;; d6f5: cd aa d6    ...
	ldx	c,+6		;; d6f8: dd 4e 06    .N.
Ld6fb:	mvi	b,001h		;; d6fb: 06 01       ..
	jmp	Ld6aa		;; d6fd: c3 aa d6    ...

Ld700:	ldx	c,+6		;; d700: dd 4e 06    .N.
	call	Ld6a3		;; d703: cd a3 d6    ...
	jrnz	Ld6fb		;; d706: 20 f3        .
	inx	h		;; d708: 23          #
	inr	m		;; d709: 34          4
	ret			;; d70a: c9          .

Ld70b:	ldx	b,+15		;; d70b: dd 46 0f    .F.
	lxi	h,Le560		;; d70e: 21 60 e5    .`.
	call	Ld694		;; d711: cd 94 d6    ...
	rnz			;; d714: c0          .
	ldx	c,+6		;; d715: dd 4e 06    .N.
	call	Ld6a3		;; d718: cd a3 d6    ...
	rnz			;; d71b: c0          .
	inx	h		;; d71c: 23          #
	dcr	m		;; d71d: 35          5
	rnz			;; d71e: c0          .
	dcx	h		;; d71f: 2b          +
	call	Ld6ca		;; d720: cd ca d6    ...
	mvi	a,0ffh		;; d723: 3e ff       >.
	cmp	m		;; d725: be          .
	rnz			;; d726: c0          .
	dcx	h		;; d727: 2b          +
	dcx	h		;; d728: 2b          +
	cmp	m		;; d729: be          .
	rnz			;; d72a: c0          .
	jmp	Ld6ca		;; d72b: c3 ca d6    ...

Ld72e:	lda	Le561		;; d72e: 3a 61 e5    :a.
	cpi	0ffh		;; d731: fe ff       ..
	jrz	Ld74e		;; d733: 28 19       (.
	lxi	d,Lddff		;; d735: 11 ff dd    ...
	call	Ld861		;; d738: cd 61 d8    .a.
Ld73b:	lxi	d,00080h	;; d73b: 11 80 00    ...
	sded	Le591		;; d73e: ed 53 91 e5 .S..
	mvi	c,01ah		;; d742: 0e 1a       ..
	call	Le7a9		;; d744: cd a9 e7    ...
	xra	a		;; d747: af          .
	sta	Le5cd		;; d748: 32 cd e5    2..
	jmp	Ld793		;; d74b: c3 93 d7    ...

Ld74e:	lxi	h,Le5d2		;; d74e: 21 d2 e5    ...
	mvi	b,010h		;; d751: 06 10       ..
Ld753:	res	7,m		;; d753: cb be       ..
	res	6,m		;; d755: cb b6       ..
	inx	h		;; d757: 23          #
	inx	h		;; d758: 23          #
	djnz	Ld753		;; d759: 10 f8       ..
	mvi	c,00dh		;; d75b: 0e 0d       ..
	call	Le7a9		;; d75d: cd a9 e7    ...
	jr	Ld73b		;; d760: 18 d9       ..

Ld762:	lxi	h,Le5d1		;; d762: 21 d1 e5    ...
	add	a		;; d765: 87          .
Ld766:	add	l		;; d766: 85          .
	mov	l,a		;; d767: 6f          o
	rnc			;; d768: d0          .
	inr	h		;; d769: 24          $
	ret			;; d76a: c9          .

Ld76b:	cpi	010h		;; d76b: fe 10       ..
	jrnc	Ld778		;; d76d: 30 09       0.
	call	Ld762		;; d76f: cd 62 d7    .b.
	inx	h		;; d772: 23          #
	mov	a,m		;; d773: 7e          ~
	ora	a		;; d774: b7          .
	jnz	Ld783		;; d775: c2 83 d7    ...
Ld778:	lxi	d,Lde33		;; d778: 11 33 de    .3.
	call	Ld9b1		;; d77b: cd b1 d9    ...
	jz	Le109		;; d77e: ca 09 e1    ...
	jr	Ld78e		;; d781: 18 0b       ..

Ld783:	setb	7,m		;; d783: cb fe       ..
	ani	00fh		;; d785: e6 0f       ..
	dcx	h		;; d787: 2b          +
	ret			;; d788: c9          .

Ld789:	mvi	c,009h		;; d789: 0e 09       ..
	call	Le7a9		;; d78b: cd a9 e7    ...
Ld78e:	mvi	a,0ffh		;; d78e: 3e ff       >.
	jmp	Ld23a		;; d790: c3 3a d2    .:.

Ld793:	lda	Le5cd		;; d793: 3a cd e5    :..
	call	Ld76b		;; d796: cd 6b d7    .k.
	dcr	a		;; d799: 3d          =
	mov	e,a		;; d79a: 5f          _
	lda	Le5cd		;; d79b: 3a cd e5    :..
	sta	Le5cf		;; d79e: 32 cf e5    2..
	mvi	a,0ffh		;; d7a1: 3e ff       >.
	sta	Le58f		;; d7a3: 32 8f e5    2..
	sta	Le58c		;; d7a6: 32 8c e5    2..
	mov	a,m		;; d7a9: 7e          ~
	inr	a		;; d7aa: 3c          <
	jrnz	Ld7b6		;; d7ab: 20 09        .
	mov	a,e		;; d7ad: 7b          {
	sta	Le58c		;; d7ae: 32 8c e5    2..
	mvi	c,00eh		;; d7b1: 0e 0e       ..
	call	Le7a9		;; d7b3: cd a9 e7    ...
Ld7b6:	jmp	Ld23a		;; d7b6: c3 3a d2    .:.

Ld7b9:	lxi	d,Le624		;; d7b9: 11 24 e6    .$.
	mvi	c,01ah		;; d7bc: 0e 1a       ..
	jmp	Le7a9		;; d7be: c3 a9 e7    ...

Ld7c1:	rrc			;; d7c1: 0f          .
	rrc			;; d7c2: 0f          .
	rrc			;; d7c3: 0f          .
	lxi	h,Le624		;; d7c4: 21 24 e6    .$.
	jmp	Ld766		;; d7c7: c3 66 d7    .f.

Ld7ca:	call	Ld7b9		;; d7ca: cd b9 d7    ...
	lded	Le5cd		;; d7cd: ed 5b cd e5 .[..
	mvi	c,011h		;; d7d1: 0e 11       ..
	call	Le7a9		;; d7d3: cd a9 e7    ...
	cpi	0ffh		;; d7d6: fe ff       ..
	jrz	Ld7de		;; d7d8: 28 04       (.
	call	Ld7c1		;; d7da: cd c1 d7    ...
	inr	a		;; d7dd: 3c          <
Ld7de:	push	psw		;; d7de: f5          .
	push	h		;; d7df: e5          .
	call	Ld403		;; d7e0: cd 03 d4    ...
	pop	h		;; d7e3: e1          .
	pop	psw		;; d7e4: f1          .
	ret			;; d7e5: c9          .

Ld7e6:	lhld	Le5cd		;; d7e6: 2a cd e5    *..
	mov	a,m		;; d7e9: 7e          ~
	xchg			;; d7ea: eb          .
	sta	Le5d0		;; d7eb: 32 d0 e5    2..
	ora	a		;; d7ee: b7          .
	jrnz	Ld7fd		;; d7ef: 20 0c        .
	lda	Le58c		;; d7f1: 3a 8c e5    :..
	inr	a		;; d7f4: 3c          <
	jrz	Ld7f9		;; d7f5: 28 02       (.
	xra	a		;; d7f7: af          .
	ret			;; d7f8: c9          .

Ld7f9:	lda	Le5cf		;; d7f9: 3a cf e5    :..
	inr	a		;; d7fc: 3c          <
Ld7fd:	dcr	a		;; d7fd: 3d          =
	call	Ld76b		;; d7fe: cd 6b d7    .k.
	mov	b,m		;; d801: 46          F
	inr	b		;; d802: 04          .
	jrnz	Ld807		;; d803: 20 02        .
	stax	d		;; d805: 12          .
	ret			;; d806: c9          .

Ld807:	dcr	b		;; d807: 05          .
	stx	b,+3		;; d808: dd 70 03    .p.
	stx	a,+15		;; d80b: dd 77 0f    .w.
	xchg			;; d80e: eb          .
	inx	h		;; d80f: 23          #
	lxi	d,Le601		;; d810: 11 01 e6    ...
	lxi	b,00023h	;; d813: 01 23 00    .#.
	ldir			;; d816: ed b0       ..
	lda	Le5cc		;; d818: 3a cc e5    :..
	stx	a,+12		;; d81b: dd 77 0c    .w.
	lda	Le593		;; d81e: 3a 93 e5    :..
	stx	a,+6		;; d821: dd 77 06    .w.
	call	Ld837		;; d824: cd 37 d8    .7.
	lda	Le590		;; d827: 3a 90 e5    :..
	stx	a,+13		;; d82a: dd 77 0d    .w.
	mvix	027h,+11	;; d82d: dd 36 0b 27 .6.'
	mvix	020h,+9		;; d831: dd 36 09 20 .6. 
	inr	a		;; d835: 3c          <
	ret			;; d836: c9          .

Ld837:	mvix	000h,+8		;; d837: dd 36 08 00 .6..
	lda	Le5bb		;; d83b: 3a bb e5    :..
	inr	a		;; d83e: 3c          <
	sta	Le5bb		;; d83f: 32 bb e5    2..
	stx	a,+10		;; d842: dd 77 0a    .w.
	ret			;; d845: c9          .

Ld846:	lded	Le5cd		;; d846: ed 5b cd e5 .[..
	push	d		;; d84a: d5          .
	lda	Le5cc		;; d84b: 3a cc e5    :..
	mov	c,a		;; d84e: 4f          O
	call	Le7a9		;; d84f: cd a9 e7    ...
	pop	d		;; d852: d1          .
Ld853:	mov	b,a		;; d853: 47          G
	mvi	a,0ffh		;; d854: 3e ff       >.
	sta	Le58f		;; d856: 32 8f e5    2..
	lda	Le5d0		;; d859: 3a d0 e5    :..
	stax	d		;; d85c: 12          .
	mov	a,b		;; d85d: 78          x
	jmp	Ld23a		;; d85e: c3 3a d2    .:.

Ld861:	mvi	c,009h		;; d861: 0e 09       ..
	jmp	Le7a9		;; d863: c3 a9 e7    ...

Ld866:	push	b		;; d866: c5          .
	lxi	h,Le5f4		;; d867: 21 f4 e5    ...
	call	Le284		;; d86a: cd 84 e2    ...
	ora	a		;; d86d: b7          .
	jrz	Ld877		;; d86e: 28 07       (.
	pop	b		;; d870: c1          .
	lxi	d,Lded7		;; d871: 11 d7 de    ...
	jmp	Ld789		;; d874: c3 89 d7    ...

Ld877:	lxi	h,007d0h	;; d877: 21 d0 07    ...
	call	Le0cf		;; d87a: cd cf e0    ...
	pop	b		;; d87d: c1          .
	jrnz	Ld88a		;; d87e: 20 0a        .
Ld880:	djnz	Ld866		;; d880: 10 e4       ..
	xra	a		;; d882: af          .
	inr	a		;; d883: 3c          <
	ret			;; d884: c9          .

Ld885:	call	Le04c		;; d885: cd 4c e0    .L.
	jr	Ld880		;; d888: 18 f6       ..

Ld88a:	xchg			;; d88a: eb          .
	lxi	h,00006h	;; d88b: 21 06 00    ...
	dad	d		;; d88e: 19          .
	mov	a,m		;; d88f: 7e          ~
	cmpx	+3		;; d890: dd be 03    ...
	jrnz	Ld885		;; d893: 20 f0        .
	inx	h		;; d895: 23          #
	inx	h		;; d896: 23          #
	inx	h		;; d897: 23          #
	mov	a,m		;; d898: 7e          ~
	cpi	021h		;; d899: fe 21       ..
	jrnz	Ld885		;; d89b: 20 e8        .
	inx	h		;; d89d: 23          #
	lda	Le5bb		;; d89e: 3a bb e5    :..
	cmp	m		;; d8a1: be          .
	jrnz	Ld885		;; d8a2: 20 e1        .
	lxi	h,0000eh	;; d8a4: 21 0e 00    ...
	dad	d		;; d8a7: 19          .
	mov	a,m		;; d8a8: 7e          ~
	inx	h		;; d8a9: 23          #
	inx	h		;; d8aa: 23          #
	ret			;; d8ab: c9          .

Ld8ac:	call	Ld7ca		;; d8ac: cd ca d7    ...
	rnz			;; d8af: c0          .
	lded	Le5cd		;; d8b0: ed 5b cd e5 .[..
	jmp	Ld853		;; d8b4: c3 53 d8    .S.

Ld8b7:	lda	Le595		;; d8b7: 3a 95 e5    :..
	ana	b		;; d8ba: a0          .
	rnz			;; d8bb: c0          .
	pop	d		;; d8bc: d1          .
	lxi	d,Ldd51		;; d8bd: 11 51 dd    .Q.
	jmp	Ld789		;; d8c0: c3 89 d7    ...

Ld8c3:	call	Ld8b7		;; d8c3: cd b7 d8    ...
	mvi	b,008h		;; d8c6: 06 08       ..
Ld8c8:	call	Ld866		;; d8c8: cd 66 d8    .f.
	rz			;; d8cb: c8          .
	pop	d		;; d8cc: d1          .
	lxi	d,Ldd27		;; d8cd: 11 27 dd    .'.
	jmp	Ld789		;; d8d0: c3 89 d7    ...

Ld8d3:	push	d		;; d8d3: d5          .
	lded	Le5cd		;; d8d4: ed 5b cd e5 .[..
	inx	d		;; d8d8: 13          .
	lxi	b,00020h	;; d8d9: 01 20 00    . .
	lda	Le5cc		;; d8dc: 3a cc e5    :..
	cpi	021h		;; d8df: fe 21       ..
	jrc	Ld8e6		;; d8e1: 38 03       8.
	inr	c		;; d8e3: 0c          .
	inr	c		;; d8e4: 0c          .
	inr	c		;; d8e5: 0c          .
Ld8e6:	ldir			;; d8e6: ed b0       ..
	pop	d		;; d8e8: d1          .
	ret			;; d8e9: c9          .

Ld8ea:	lhld	Le5cd		;; d8ea: 2a cd e5    *..
	mov	a,m		;; d8ed: 7e          ~
	stax	d		;; d8ee: 12          .
	mvi	c,01eh		;; d8ef: 0e 1e       ..
	jmp	Le7a9		;; d8f1: c3 a9 e7    ...

Ld8f4:	call	Ld7e6		;; d8f4: cd e6 d7    ...
	jrnz	Ld920		;; d8f7: 20 27        '
	call	Ld8ac		;; d8f9: cd ac d8    ...
	mov	d,h		;; d8fc: 54          T
	mov	e,l		;; d8fd: 5d          ]
	inx	h		;; d8fe: 23          #
	inx	h		;; d8ff: 23          #
	bit	7,m		;; d900: cb 7e       .~
	jrz	Ld91d		;; d902: 28 19       (.
	inx	h		;; d904: 23          #
	bit	7,m		;; d905: cb 7e       .~
	jrz	Ld918		;; d907: 28 0f       (.
	lxi	d,Lde61		;; d909: 11 61 de    .a.
	call	Ld861		;; d90c: cd 61 d8    .a.
	mvi	a,0ffh		;; d90f: 3e ff       >.
	lded	Le5cd		;; d911: ed 5b cd e5 .[..
	jmp	Ld853		;; d915: c3 53 d8    .S.

Ld918:	setb	7,m		;; d918: cb fe       ..
	call	Ld8ea		;; d91a: cd ea d8    ...
Ld91d:	jmp	Ld846		;; d91d: c3 46 d8    .F.

Ld920:	mvi	b,00ch		;; d920: 06 0c       ..
Ld922:	call	Ld8c3		;; d922: cd c3 d8    ...
	push	psw		;; d925: f5          .
	inr	a		;; d926: 3c          <
	cz	Ld934		;; d927: cc 34 d9    .4.
	cnz	Ld8d3		;; d92a: c4 d3 d8    ...
	call	Le04c		;; d92d: cd 4c e0    .L.
	pop	psw		;; d930: f1          .
	jmp	Ld23a		;; d931: c3 3a d2    .:.

Ld934:	push	psw		;; d934: f5          .
	push	d		;; d935: d5          .
	lxi	h,00008h	;; d936: 21 08 00    ...
	dad	d		;; d939: 19          .
	mov	a,m		;; d93a: 7e          ~
	cpi	010h		;; d93b: fe 10       ..
	jrnz	Ld947		;; d93d: 20 08        .
	lxi	d,Lde61		;; d93f: 11 61 de    .a.
	call	Ld861		;; d942: cd 61 d8    .a.
	jr	Ld95d		;; d945: 18 16       ..

Ld947:	cpi	011h		;; d947: fe 11       ..
	jrnz	Ld953		;; d949: 20 08        .
	lxi	d,Lde76		;; d94b: 11 76 de    .v.
	call	Ld861		;; d94e: cd 61 d8    .a.
	jr	Ld95d		;; d951: 18 0a       ..

Ld953:	cpi	012h		;; d953: fe 12       ..
	jrnz	Ld95d		;; d955: 20 06        .
	lxi	d,Ldebe		;; d957: 11 be de    ...
	call	Ld861		;; d95a: cd 61 d8    .a.
Ld95d:	pop	d		;; d95d: d1          .
	pop	psw		;; d95e: f1          .
	ret			;; d95f: c9          .

Ld960:	lhld	Le5cd		;; d960: 2a cd e5    *..
	inx	h		;; d963: 23          #
	inx	h		;; d964: 23          #
	inx	h		;; d965: 23          #
	res	7,m		;; d966: cb be       ..
	call	Ld7e6		;; d968: cd e6 d7    ...
	jrnz	Ld97d		;; d96b: 20 10        .
	call	Ld8ac		;; d96d: cd ac d8    ...
	mov	d,h		;; d970: 54          T
	mov	e,l		;; d971: 5d          ]
	inx	h		;; d972: 23          #
	inx	h		;; d973: 23          #
	inx	h		;; d974: 23          #
	res	7,m		;; d975: cb be       ..
	call	Ld8ea		;; d977: cd ea d8    ...
	jmp	Ld846		;; d97a: c3 46 d8    .F.

Ld97d:	mvi	b,008h		;; d97d: 06 08       ..
	call	Ld8b7		;; d97f: cd b7 d8    ...
Ld982:	mvi	b,008h		;; d982: 06 08       ..
	call	Ld866		;; d984: cd 66 d8    .f.
	jrz	Ld99d		;; d987: 28 14       (.
	lxi	d,Ldd27		;; d989: 11 27 dd    .'.
	call	Ld861		;; d98c: cd 61 d8    .a.
	lxi	d,Ldd81		;; d98f: 11 81 dd    ...
Ld992:	call	Ld9b1		;; d992: cd b1 d9    ...
	jrnz	Ld982		;; d995: 20 eb        .
	lxi	d,Ldd4e		;; d997: 11 4e dd    .N.
	jmp	Ld789		;; d99a: c3 89 d7    ...

Ld99d:	push	psw		;; d99d: f5          .
	inr	a		;; d99e: 3c          <
	jrnz	Ld9aa		;; d99f: 20 09        .
	call	Le04c		;; d9a1: cd 4c e0    .L.
	lxi	d,Ldd95		;; d9a4: 11 95 dd    ...
	pop	psw		;; d9a7: f1          .
	jr	Ld992		;; d9a8: 18 e8       ..

Ld9aa:	call	Le04c		;; d9aa: cd 4c e0    .L.
	pop	psw		;; d9ad: f1          .
	jmp	Ld23a		;; d9ae: c3 3a d2    .:.

Ld9b1:	call	Ld861		;; d9b1: cd 61 d8    .a.
	mvi	c,001h		;; d9b4: 0e 01       ..
	call	Le7a9		;; d9b6: cd a9 e7    ...
	ani	05fh		;; d9b9: e6 5f       ._
	cpi	04eh		;; d9bb: fe 4e       .N
	ret			;; d9bd: c9          .

Ld9be:	call	Ldad8		;; d9be: cd d8 da    ...
	call	Ld7e6		;; d9c1: cd e6 d7    ...
	jrnz	Lda28		;; d9c4: 20 62        b
	call	Ld7b9		;; d9c6: cd b9 d7    ...
	lded	Le5cd		;; d9c9: ed 5b cd e5 .[..
	mvi	c,011h		;; d9cd: 0e 11       ..
	call	Le7a9		;; d9cf: cd a9 e7    ...
	cpi	0ffh		;; d9d2: fe ff       ..
	jrz	Lda08		;; d9d4: 28 32       (2
Ld9d6:	call	Ld7c1		;; d9d6: cd c1 d7    ...
	inx	h		;; d9d9: 23          #
	inx	h		;; d9da: 23          #
	inx	h		;; d9db: 23          #
	bit	7,m		;; d9dc: cb 7e       .~
	jrnz	Lda02		;; d9de: 20 22        "
	mvi	c,012h		;; d9e0: 0e 12       ..
	call	Le7a9		;; d9e2: cd a9 e7    ...
	cpi	0ffh		;; d9e5: fe ff       ..
	jrnz	Ld9d6		;; d9e7: 20 ed        .
	call	Ld403		;; d9e9: cd 03 d4    ...
	jmp	Ld846		;; d9ec: c3 46 d8    .F.

Ld9ef:	call	Ldad8		;; d9ef: cd d8 da    ...
	call	Ld7e6		;; d9f2: cd e6 d7    ...
	jrnz	Lda28		;; d9f5: 20 31        1
	call	Ld8ac		;; d9f7: cd ac d8    ...
	inx	h		;; d9fa: 23          #
	inx	h		;; d9fb: 23          #
	inx	h		;; d9fc: 23          #
	bit	7,m		;; d9fd: cb 7e       .~
	jz	Lda14		;; d9ff: ca 14 da    ...
Lda02:	lxi	d,Lddc6		;; da02: 11 c6 dd    ...
	call	Ld861		;; da05: cd 61 d8    .a.
Lda08:	call	Ld403		;; da08: cd 03 d4    ...
	lded	Le5cd		;; da0b: ed 5b cd e5 .[..
	mvi	a,0ffh		;; da0f: 3e ff       >.
	jmp	Ld853		;; da11: c3 53 d8    .S.

Lda14:	call	Ld7b9		;; da14: cd b9 d7    ...
	lhld	Le5cd		;; da17: 2a cd e5    *..
	call	Lda39		;; da1a: cd 39 da    .9.
	push	psw		;; da1d: f5          .
	call	Ld403		;; da1e: cd 03 d4    ...
	pop	psw		;; da21: f1          .
	jz	Ld846		;; da22: ca 46 d8    .F.
	jmp	Ldb0e		;; da25: c3 0e db    ...

Lda28:	mvi	b,008h		;; da28: 06 08       ..
	call	Ld8c3		;; da2a: cd c3 d8    ...
	push	psw		;; da2d: f5          .
	inr	a		;; da2e: 3c          <
	cz	Ld934		;; da2f: cc 34 d9    .4.
	call	Le04c		;; da32: cd 4c e0    .L.
	pop	psw		;; da35: f1          .
	jmp	Ld23a		;; da36: c3 3a d2    .:.

Lda39:	mov	a,m		;; da39: 7e          ~
	lxi	d,00010h	;; da3a: 11 10 00    ...
	dad	d		;; da3d: 19          .
	mov	m,a		;; da3e: 77          w
	push	h		;; da3f: e5          .
	xchg			;; da40: eb          .
	mvi	c,011h		;; da41: 0e 11       ..
	call	Le7a9		;; da43: cd a9 e7    ...
	pop	h		;; da46: e1          .
	mvi	m,000h		;; da47: 36 00       6.
	inr	a		;; da49: 3c          <
	ret			;; da4a: c9          .

Lda4b:	call	Ld7e6		;; da4b: cd e6 d7    ...
	jz	Ld846		;; da4e: ca 46 d8    .F.
	mvi	b,00ch		;; da51: 06 0c       ..
	call	Ld8c3		;; da53: cd c3 d8    ...
	ora	a		;; da56: b7          .
	push	psw		;; da57: f5          .
	jrnz	Lda6a		;; da58: 20 10        .
	call	Ld8d3		;; da5a: cd d3 d8    ...
Lda5d:	lxi	h,00033h	;; da5d: 21 33 00    .3.
	dad	d		;; da60: 19          .
	lded	Le591		;; da61: ed 5b 91 e5 .[..
	lxi	b,00080h	;; da65: 01 80 00    ...
	ldir			;; da68: ed b0       ..
Lda6a:	call	Le04c		;; da6a: cd 4c e0    .L.
	mvi	h,000h		;; da6d: 26 00       &.
	pop	psw		;; da6f: f1          .
	jmp	Ld23a		;; da70: c3 3a d2    .:.

Lda73:	call	Ldad8		;; da73: cd d8 da    ...
	call	Ld7e6		;; da76: cd e6 d7    ...
	jz	Ld846		;; da79: ca 46 d8    .F.
	mvi	b,008h		;; da7c: 06 08       ..
	call	Ld8b7		;; da7e: cd b7 d8    ...
	mvix	0a7h,+11	;; da81: dd 36 0b a7 .6..
	lxi	d,Le624		;; da85: 11 24 e6    .$.
	lhld	Le591		;; da88: 2a 91 e5    *..
	lxi	b,00080h	;; da8b: 01 80 00    ...
	ldir			;; da8e: ed b0       ..
Lda90:	mvi	b,008h		;; da90: 06 08       ..
	call	Ld866		;; da92: cd 66 d8    .f.
	jrz	Ldaab		;; da95: 28 14       (.
	lxi	d,Ldd27		;; da97: 11 27 dd    .'.
	call	Ld861		;; da9a: cd 61 d8    .a.
	lxi	d,Ldd81		;; da9d: 11 81 dd    ...
	call	Ld9b1		;; daa0: cd b1 d9    ...
	jrnz	Lda90		;; daa3: 20 eb        .
	lxi	d,Ldd4e		;; daa5: 11 4e dd    .N.
	jmp	Ld789		;; daa8: c3 89 d7    ...

Ldaab:	ora	a		;; daab: b7          .
	push	psw		;; daac: f5          .
	jrz	Ldace		;; daad: 28 1f       (.
	push	h		;; daaf: e5          .
	lxi	h,00008h	;; dab0: 21 08 00    ...
	dad	d		;; dab3: 19          .
	mov	a,m		;; dab4: 7e          ~
	cpi	001h		;; dab5: fe 01       ..
	jrnz	Ldabf		;; dab7: 20 06        .
	pop	h		;; dab9: e1          .
	call	Ld837		;; daba: cd 37 d8    .7.
	jr	Ldac8		;; dabd: 18 09       ..

Ldabf:	lxi	d,Ldd6e		;; dabf: 11 6e dd    .n.
	call	Ld9b1		;; dac2: cd b1 d9    ...
	pop	h		;; dac5: e1          .
	jrz	Ldace		;; dac6: 28 06       (.
Ldac8:	call	Le04c		;; dac8: cd 4c e0    .L.
	pop	psw		;; dacb: f1          .
	jr	Lda90		;; dacc: 18 c2       ..

Ldace:	call	Ld8d3		;; dace: cd d3 d8    ...
	call	Le04c		;; dad1: cd 4c e0    .L.
	pop	psw		;; dad4: f1          .
	jmp	Ld23a		;; dad5: c3 3a d2    .:.

Ldad8:	lhld	Le5cd		;; dad8: 2a cd e5    *..
	xchg			;; dadb: eb          .
	lxi	h,00009h	;; dadc: 21 09 00    ...
	dad	d		;; dadf: 19          .
	bit	7,m		;; dae0: cb 7e       .~
	jrz	Ldaeb		;; dae2: 28 07       (.
	pop	d		;; dae4: d1          .
	lxi	d,Ldebe		;; dae5: 11 be de    ...
	jmp	Ld789		;; dae8: c3 89 d7    ...

Ldaeb:	xchg			;; daeb: eb          .
	mov	a,m		;; daec: 7e          ~
	ora	a		;; daed: b7          .
	jrnz	Ldaf4		;; daee: 20 04        .
	lda	Le5cf		;; daf0: 3a cf e5    :..
	inr	a		;; daf3: 3c          <
Ldaf4:	dcr	a		;; daf4: 3d          =
	call	Ld762		;; daf5: cd 62 d7    .b.
	inx	h		;; daf8: 23          #
	bit	6,m		;; daf9: cb 76       .v
	rz			;; dafb: c8          .
	pop	d		;; dafc: d1          .
	lxi	d,Ldea1		;; dafd: 11 a1 de    ...
	jmp	Ld789		;; db00: c3 89 d7    ...

Ldb03:	call	Ld7e6		;; db03: cd e6 d7    ...
	jrnz	Ldb1d		;; db06: 20 15        .
	call	Ld7ca		;; db08: cd ca d7    ...
	jz	Ld846		;; db0b: ca 46 d8    .F.
Ldb0e:	lxi	d,Ldddb		;; db0e: 11 db dd    ...
	call	Ld861		;; db11: cd 61 d8    .a.
	lded	Le5cd		;; db14: ed 5b cd e5 .[..
	mvi	a,0ffh		;; db18: 3e ff       >.
	jmp	Ld853		;; db1a: c3 53 d8    .S.

Ldb1d:	mvi	b,008h		;; db1d: 06 08       ..
	jmp	Ld922		;; db1f: c3 22 d9    .".

Ldb22:	mvi	b,010h		;; db22: 06 10       ..
	call	Ld8b7		;; db24: cd b7 d8    ...
	call	Ld7e6		;; db27: cd e6 d7    ...
	jz	Ld846		;; db2a: ca 46 d8    .F.
	jmp	Lda28		;; db2d: c3 28 da    .(.

Ldb30:	call	Ld7e6		;; db30: cd e6 d7    ...
	jz	Ld846		;; db33: ca 46 d8    .F.
	mvi	b,00ch		;; db36: 06 0c       ..
	call	Ld8c3		;; db38: cd c3 d8    ...
	push	psw		;; db3b: f5          .
	jmp	Ldace		;; db3c: c3 ce da    ...

Ldb3f:	lhld	Le5cd		;; db3f: 2a cd e5    *..
	shld	Le6c3		;; db42: 22 c3 e6    "..
	lxi	d,Le6a4		;; db45: 11 a4 e6    ...
	lxi	b,0000dh	;; db48: 01 0d 00    ...
	ldir			;; db4b: ed b0       ..
	sbcd	Le6c5		;; db4d: ed 43 c5 e6 .C..
	ret			;; db51: c9          .

Ldb52:	lhld	Le6c3		;; db52: 2a c3 e6    *..
	lxi	d,Le6b4		;; db55: 11 b4 e6    ...
	lxi	b,0000dh	;; db58: 01 0d 00    ...
	ldir			;; db5b: ed b0       ..
	ret			;; db5d: c9          .

Ldb5e:	call	Ldb3f		;; db5e: cd 3f db    .?.
	lhld	Le5cd		;; db61: 2a cd e5    *..
	mov	a,m		;; db64: 7e          ~
	xchg			;; db65: eb          .
	sta	Le5d0		;; db66: 32 d0 e5    2..
	cpi	03fh		;; db69: fe 3f       .?
	jrnz	Ldb84		;; db6b: 20 17        .
	lda	Le58c		;; db6d: 3a 8c e5    :..
	inr	a		;; db70: 3c          <
	jnz	Ld846		;; db71: c2 46 d8    .F.
	call	Ld7f9		;; db74: cd f9 d7    ...
	ldx	a,+15		;; db77: dd 7e 0f    .~.
	dcr	a		;; db7a: 3d          =
	stx	a,+14		;; db7b: dd 77 0e    .w.
	mvix	03fh,+15	;; db7e: dd 36 0f 3f .6.?
	jr	Ldb8a		;; db82: 18 06       ..

Ldb84:	call	Ld7e6		;; db84: cd e6 d7    ...
	jz	Ld846		;; db87: ca 46 d8    .F.
Ldb8a:	mvi	b,00ch		;; db8a: 06 0c       ..
	call	Ld8c3		;; db8c: cd c3 d8    ...
	push	psw		;; db8f: f5          .
	jmp	Lda5d		;; db90: c3 5d da    .].

Ldb93:	lhld	Le6c5		;; db93: 2a c5 e6    *..
	inx	h		;; db96: 23          #
	shld	Le6c5		;; db97: 22 c5 e6    "..
	call	Ldb52		;; db9a: cd 52 db    .R.
	lxi	h,Le6a4		;; db9d: 21 a4 e6    ...
	shld	Le5cd		;; dba0: 22 cd e5    "..
	mov	a,m		;; dba3: 7e          ~
	xchg			;; dba4: eb          .
	sta	Le5d0		;; dba5: 32 d0 e5    2..
	cpi	03fh		;; dba8: fe 3f       .?
	jrnz	Ldbc2		;; dbaa: 20 16        .
	lda	Le58c		;; dbac: 3a 8c e5    :..
	inr	a		;; dbaf: 3c          <
	jrnz	Ldbe2		;; dbb0: 20 30        0
	call	Ld7f9		;; dbb2: cd f9 d7    ...
	ldx	a,+15		;; dbb5: dd 7e 0f    .~.
	dcr	a		;; dbb8: 3d          =
	stx	a,+14		;; dbb9: dd 77 0e    .w.
	mvix	03fh,+15	;; dbbc: dd 36 0f 3f .6.?
	jr	Ldbce		;; dbc0: 18 0c       ..

Ldbc2:	call	Ld7e6		;; dbc2: cd e6 d7    ...
	jrz	Ldbe2		;; dbc5: 28 1b       (.
	ldx	a,+15		;; dbc7: dd 7e 0f    .~.
	dcr	a		;; dbca: 3d          =
	stx	a,+14		;; dbcb: dd 77 0e    .w.
Ldbce:	mvi	b,00ch		;; dbce: 06 0c       ..
	call	Ld8c3		;; dbd0: cd c3 d8    ...
	push	psw		;; dbd3: f5          .
	cpi	0ffh		;; dbd4: fe ff       ..
	jrz	Ldbdf		;; dbd6: 28 07       (.
	lxi	h,00034h	;; dbd8: 21 34 00    .4.
	dad	d		;; dbdb: 19          .
	call	Ldc3c		;; dbdc: cd 3c dc    .<.
Ldbdf:	jmp	Lda5d		;; dbdf: c3 5d da    .].

Ldbe2:	lda	Le58f		;; dbe2: 3a 8f e5    :..
	inr	a		;; dbe5: 3c          <
	jrz	Ldbf4		;; dbe6: 28 0c       (.
	push	d		;; dbe8: d5          .
	mvi	c,011h		;; dbe9: 0e 11       ..
	call	Le7a9		;; dbeb: cd a9 e7    ...
	pop	d		;; dbee: d1          .
	ldax	d		;; dbef: 1a          .
	cpi	03fh		;; dbf0: fe 3f       .?
	jrz	Ldc0f		;; dbf2: 28 1b       (.
Ldbf4:	call	Ldc2f		;; dbf4: cd 2f dc    ./.
	push	d		;; dbf7: d5          .
	mvi	c,012h		;; dbf8: 0e 12       ..
	call	Le7a9		;; dbfa: cd a9 e7    ...
	pop	d		;; dbfd: d1          .
Ldbfe:	cpi	0ffh		;; dbfe: fe ff       ..
	jz	Ld853		;; dc00: ca 53 d8    .S.
	push	psw		;; dc03: f5          .
	lhld	Le591		;; dc04: 2a 91 e5    *..
	inx	h		;; dc07: 23          #
	call	Ldc3c		;; dc08: cd 3c dc    .<.
	pop	psw		;; dc0b: f1          .
	jmp	Ld853		;; dc0c: c3 53 d8    .S.

Ldc0f:	push	d		;; dc0f: d5          .
	lda	Le6c5		;; dc10: 3a c5 e6    :..
	mov	b,a		;; dc13: 47          G
	mvi	c,012h		;; dc14: 0e 12       ..
Ldc16:	push	b		;; dc16: c5          .
	call	Le7a9		;; dc17: cd a9 e7    ...
	pop	b		;; dc1a: c1          .
	djnz	Ldc16		;; dc1b: 10 f9       ..
	push	psw		;; dc1d: f5          .
	lda	Le6c6		;; dc1e: 3a c6 e6    :..
	ora	a		;; dc21: b7          .
	jrz	Ldc2b		;; dc22: 28 07       (.
	dcr	a		;; dc24: 3d          =
	sta	Le6c6		;; dc25: 32 c6 e6    2..
	pop	psw		;; dc28: f1          .
	jr	Ldc16		;; dc29: 18 eb       ..

Ldc2b:	pop	psw		;; dc2b: f1          .
	pop	d		;; dc2c: d1          .
	jr	Ldbfe		;; dc2d: 18 cf       ..

Ldc2f:	push	d		;; dc2f: d5          .
	inx	d		;; dc30: 13          .
	lxi	h,00010h	;; dc31: 21 10 00    ...
	dad	d		;; dc34: 19          .
	lxi	b,0000fh	;; dc35: 01 0f 00    ...
	ldir			;; dc38: ed b0       ..
	pop	d		;; dc3a: d1          .
	ret			;; dc3b: c9          .

Ldc3c:	push	d		;; dc3c: d5          .
	add	a		;; dc3d: 87          .
	add	a		;; dc3e: 87          .
	add	a		;; dc3f: 87          .
	add	a		;; dc40: 87          .
	add	a		;; dc41: 87          .
	mov	e,a		;; dc42: 5f          _
	mvi	d,000h		;; dc43: 16 00       ..
	dad	d		;; dc45: 19          .
	lxi	d,Le6a5		;; dc46: 11 a5 e6    ...
	lxi	b,0000fh	;; dc49: 01 0f 00    ...
	ldir			;; dc4c: ed b0       ..
	pop	d		;; dc4e: d1          .
	ret			;; dc4f: c9          .

Ldc50:	lded	Le5cd		;; dc50: ed 5b cd e5 .[..
Ldc54:	lda	Le5cc		;; dc54: 3a cc e5    :..
	mov	c,a		;; dc57: 4f          O
	call	Le7a9		;; dc58: cd a9 e7    ...
	jmp	Ld23a		;; dc5b: c3 3a d2    .:.

Ldc5e:	lxi	h,00000h	;; dc5e: 21 00 00    ...
	lxi	d,Le5f0		;; dc61: 11 f0 e5    ...
	mvi	b,010h		;; dc64: 06 10       ..
Ldc66:	ldax	d		;; dc66: 1a          .
	dcx	d		;; dc67: 1b          .
	dcx	d		;; dc68: 1b          .
	ral			;; dc69: 17          .
	dadc	h		;; dc6a: ed 6a       .j
	djnz	Ldc66		;; dc6c: 10 f8       ..
	jmp	Ld239		;; dc6e: c3 39 d2    .9.

Ldc71:	lda	Le5cf		;; dc71: 3a cf e5    :..
	jmp	Ld23a		;; dc74: c3 3a d2    .:.

Ldc77:	lded	Le5cd		;; dc77: ed 5b cd e5 .[..
	sded	Le591		;; dc7b: ed 53 91 e5 .S..
	jmp	Ldc54		;; dc7f: c3 54 dc    .T.

Ldc82:	lda	Le58c		;; dc82: 3a 8c e5    :..
	inr	a		;; dc85: 3c          <
	jnz	Ldc54		;; dc86: c2 54 dc    .T.
	call	Ldcb4		;; dc89: cd b4 dc    ...
	mvi	b,00ch		;; dc8c: 06 0c       ..
	call	Ld8b7		;; dc8e: cd b7 d8    ...
	mvi	b,002h		;; dc91: 06 02       ..
	call	Ld8c8		;; dc93: cd c8 d8    ...
	dcx	h		;; dc96: 2b          +
	lxi	d,Le6c8		;; dc97: 11 c8 e6    ...
	lxi	b,0008eh	;; dc9a: 01 8e 00    ...
	lda	Le5cc		;; dc9d: 3a cc e5    :..
	cpi	01bh		;; dca0: fe 1b       ..
	jrz	Ldcaa		;; dca2: 28 06       (.
	lxi	d,Le756		;; dca4: 11 56 e7    .V.
	lxi	b,0000fh	;; dca7: 01 0f 00    ...
Ldcaa:	push	d		;; dcaa: d5          .
	ldir			;; dcab: ed b0       ..
	call	Le04c		;; dcad: cd 4c e0    .L.
	pop	h		;; dcb0: e1          .
	jmp	Ld239		;; dcb1: c3 39 d2    .9.

Ldcb4:	lda	Le5cf		;; dcb4: 3a cf e5    :..
	call	Ld762		;; dcb7: cd 62 d7    .b.
	mov	a,m		;; dcba: 7e          ~
	cpi	0ffh		;; dcbb: fe ff       ..
	jz	Ld239		;; dcbd: ca 39 d2    .9.
	stx	a,+3		;; dcc0: dd 77 03    .w.
	call	Ld837		;; dcc3: cd 37 d8    .7.
	lda	Le590		;; dcc6: 3a 90 e5    :..
	stx	a,+13		;; dcc9: dd 77 0d    .w.
	lda	Le5cc		;; dccc: 3a cc e5    :..
	stx	a,+12		;; dccf: dd 77 0c    .w.
	lda	Le593		;; dcd2: 3a 93 e5    :..
	stx	a,+6		;; dcd5: dd 77 06    .w.
	inx	h		;; dcd8: 23          #
	mov	a,m		;; dcd9: 7e          ~
	ani	00fh		;; dcda: e6 0f       ..
	dcr	a		;; dcdc: 3d          =
	stx	a,+14		;; dcdd: dd 77 0e    .w.
	mvix	003h,+11	;; dce0: dd 36 0b 03 .6..
	ret			;; dce4: c9          .

Ldce5:	lda	Le5cf		;; dce5: 3a cf e5    :..
	call	Ld762		;; dce8: cd 62 d7    .b.
	inx	h		;; dceb: 23          #
	setb	6,m		;; dcec: cb f6       ..
	jmp	Ld23a		;; dcee: c3 3a d2    .:.

Ldcf1:	lxi	h,00000h	;; dcf1: 21 00 00    ...
	lxi	d,Le5f0		;; dcf4: 11 f0 e5    ...
	mvi	b,010h		;; dcf7: 06 10       ..
Ldcf9:	ldax	d		;; dcf9: 1a          .
	dcx	d		;; dcfa: 1b          .
	dcx	d		;; dcfb: 1b          .
	ral			;; dcfc: 17          .
	ral			;; dcfd: 17          .
	dadc	h		;; dcfe: ed 6a       .j
	djnz	Ldcf9		;; dd00: 10 f7       ..
	jmp	Ld239		;; dd02: c3 39 d2    .9.

Ldd05:	lda	Le5cd		;; dd05: 3a cd e5    :..
	mov	e,a		;; dd08: 5f          _
	inr	a		;; dd09: 3c          <
	lda	Le590		;; dd0a: 3a 90 e5    :..
	jrnz	Ldd12		;; dd0d: 20 03        .
	jmp	Ld23a		;; dd0f: c3 3a d2    .:.

Ldd12:	cmp	e		;; dd12: bb          .
	jz	Ld23a		;; dd13: ca 3a d2    .:.
	mvi	b,002h		;; dd16: 06 02       ..
	call	Ld8b7		;; dd18: cd b7 d8    ...
Ldd1b:	lda	Le5cd		;; dd1b: 3a cd e5    :..
	ani	00fh		;; dd1e: e6 0f       ..
	sta	Le590		;; dd20: 32 90 e5    2..
	mov	e,a		;; dd23: 5f          _
	jmp	Ldc54		;; dd24: c3 54 dc    .T.

Ldd27:	db	0dh,0ah,7,'Remote station is not available now.'
Ldd4e:	db	0dh,0ah,'$'
Ldd51:	db	0dh,0ah,7,'You are not authorized.',0dh,0ah,'$'
Ldd6e:	db	0dh,0ah,7,'WRITE Error.  - '
Ldd81:	db	'Try again? (Y or N)$'
Ldd95:	db	0dh,0ah,7,'Cannot find file on disk. Try again? (Y or N)$'
Lddc6:	db	0dh,0ah,7,'File(s) in use.',0dh,0ah,'$'
Ldddb:	db	0dh,0ah,7,'This file name already exists.',0dh,0ah,'$'
Lddff:	db	0dh,0ah,7,'Cannot reset drives, in use by remote station.'
	db	0dh,0ah,'$'
Lde33:	db	0dh,0ah,7,'Drive Not Mapped. Continue with Default?',0dh,0ah
	db	'$'
Lde61:	db	0dh,0ah,7,'File is Locked.',0dh,0ah,'$'
Lde76:	db	0dh,0ah,7,'File restricted to Local Access only.',0dh,0ah,'$'
Ldea1:	db	0dh,0ah,7,'Drive is set READ ONLY.',0dh,0ah,'$'
Ldebe:	db	0dh,0ah,7,'Error - File is R/O',0dh,0ah,'$'
Lded7:	db	0dh,0ah,7,'Network overload error. Check hardware.',0dh,0ah
	db	'$'
Ldf04:	db	0dh,0ah,'Logical Disk = Physical Disk: Station #',0dh,0ah
	db	0ah,'$'
Ldf31:	db	': = $'
Ldf36:	db	' Local$'
Ldf3d:	dw	Ld72e
	dw	Ld793
	dw	Ld8f4
	dw	Ld960
	dw	Ldb5e
	dw	Ldb93
	dw	Ld9be
	dw	Lda4b
	dw	Lda73
	dw	Ldb03
	dw	Ld9ef
	dw	Ldc5e
	dw	Ldc71
	dw	Ldc77
	dw	Ldc82
	dw	Ldce5
	dw	Ldcf1
	dw	Ldb22
	dw	Ldc82
	dw	Ldd05
	dw	Lda4b
	dw	Lda73
	dw	Ldb30
	dw	Ldb30
	dw	Ld236
	dw	Ld236
	dw	Ld236
	dw	Lda73
	dw	Ld236
	dw	Ld236
	dw	Ld236
Ldf7b:	dw	Ld251
	dw	Ld256
	dw	Ld25b
	dw	Ld260
	dw	Ld26f
	dw	Ld277
	dw	Ld284
	dw	Ld289
	dw	Ld28e
	dw	Ld293
Ldf8f:	call	Le7af		;; df8f: cd af e7    ...
	ora	a		;; df92: b7          .
	jrz	Ldf9b		;; df93: 28 06       (.
	call	Le7b2		;; df95: cd b2 e7    ...
	call	Ldfa0		;; df98: cd a0 df    ...
Ldf9b:	lda	Le7b5		;; df9b: 3a b5 e7    :..
	ei			;; df9e: fb          .
	ret			;; df9f: c9          .

Ldfa0:	push	h		;; dfa0: e5          .
	push	d		;; dfa1: d5          .
	lxi	h,Le7b6		;; dfa2: 21 b6 e7    ...
	mvi	d,000h		;; dfa5: 16 00       ..
	mov	e,m		;; dfa7: 5e          ^
	inx	h		;; dfa8: 23          #
	inx	h		;; dfa9: 23          #
	dad	d		;; dfaa: 19          .
	mov	m,a		;; dfab: 77          w
	lxi	h,Le7b7		;; dfac: 21 b7 e7    ...
	mov	a,e		;; dfaf: 7b          {
	inr	a		;; dfb0: 3c          <
	ani	03fh		;; dfb1: e6 3f       .?
	cmp	m		;; dfb3: be          .
	dcx	h		;; dfb4: 2b          +
	jrz	Ldfb8		;; dfb5: 28 01       (.
	mov	m,a		;; dfb7: 77          w
Ldfb8:	dcx	h		;; dfb8: 2b          +
	mvi	m,0ffh		;; dfb9: 36 ff       6.
	pop	d		;; dfbb: d1          .
	pop	h		;; dfbc: e1          .
	ret			;; dfbd: c9          .

Ldfbe:	push	h		;; dfbe: e5          .
	push	d		;; dfbf: d5          .
	lxi	h,Le7b7		;; dfc0: 21 b7 e7    ...
	mvi	d,000h		;; dfc3: 16 00       ..
	mov	e,m		;; dfc5: 5e          ^
	inx	h		;; dfc6: 23          #
	dad	d		;; dfc7: 19          .
	mov	d,m		;; dfc8: 56          V
	lxi	h,Le7b7		;; dfc9: 21 b7 e7    ...
	mov	a,e		;; dfcc: 7b          {
	inr	a		;; dfcd: 3c          <
	ani	03fh		;; dfce: e6 3f       .?
	mov	m,a		;; dfd0: 77          w
	dcx	h		;; dfd1: 2b          +
	cmp	m		;; dfd2: be          .
	jrnz	Ldfd8		;; dfd3: 20 03        .
	dcx	h		;; dfd5: 2b          +
	mvi	m,000h		;; dfd6: 36 00       6.
Ldfd8:	mov	a,d		;; dfd8: 7a          z
	pop	d		;; dfd9: d1          .
	pop	h		;; dfda: e1          .
	ret			;; dfdb: c9          .

Ldfdc:	xra	a		;; dfdc: af          .
	lxi	h,Le7b5		;; dfdd: 21 b5 e7    ...
	mov	m,a		;; dfe0: 77          w
	inx	h		;; dfe1: 23          #
	mov	m,a		;; dfe2: 77          w
	inx	h		;; dfe3: 23          #
	mov	m,a		;; dfe4: 77          w
	ret			;; dfe5: c9          .

Ldfe6:	call	Ldff0		;; dfe6: cd f0 df    ...
	ora	a		;; dfe9: b7          .
	jrz	Ldfe6		;; dfea: 28 fa       (.
	call	Ldfbe		;; dfec: cd be df    ...
	ret			;; dfef: c9          .

Ldff0:	call	Ldf8f		;; dff0: cd 8f df    ...
	call	Le027		;; dff3: cd 27 e0    .'.
	call	Le06f		;; dff6: cd 6f e0    .o.
	call	Ldf8f		;; dff9: cd 8f df    ...
	ret			;; dffc: c9          .

Ldffd:	xra	a		;; dffd: af          .
	stax	b		;; dffe: 02          .
	inx	b		;; dfff: 03          .
	stax	b		;; e000: 02          .
	dcx	b		;; e001: 0b          .
Le002:	mov	a,m		;; e002: 7e          ~
	inx	h		;; e003: 23          #
	ora	m		;; e004: b6          .
	jrz	Le00d		;; e005: 28 06       (.
	mov	d,m		;; e007: 56          V
	dcx	h		;; e008: 2b          +
	mov	e,m		;; e009: 5e          ^
	xchg			;; e00a: eb          .
	jr	Le002		;; e00b: 18 f5       ..

Le00d:	mov	m,b		;; e00d: 70          p
	dcx	h		;; e00e: 2b          +
	mov	m,c		;; e00f: 71          q
	ret			;; e010: c9          .

Le011:	mov	a,m		;; e011: 7e          ~
	inx	h		;; e012: 23          #
	mov	h,m		;; e013: 66          f
	mov	l,a		;; e014: 6f          o
	ora	h		;; e015: b4          .
	ret			;; e016: c9          .

Le017:	mov	c,m		;; e017: 4e          N
	inx	h		;; e018: 23          #
	mov	b,m		;; e019: 46          F
	mov	a,b		;; e01a: 78          x
	ora	c		;; e01b: b1          .
	rz			;; e01c: c8          .
	inx	b		;; e01d: 03          .
	ldax	b		;; e01e: 0a          .
	mov	m,a		;; e01f: 77          w
	dcx	b		;; e020: 0b          .
	dcx	h		;; e021: 2b          +
	ldax	b		;; e022: 0a          .
	mov	m,a		;; e023: 77          w
	mov	h,b		;; e024: 60          `
	mov	l,c		;; e025: 69          i
	ret			;; e026: c9          .

Le027:	lxi	h,Le7fc		;; e027: 21 fc e7    ...
	call	Le011		;; e02a: cd 11 e0    ...
	rz			;; e02d: c8          .
	inx	h		;; e02e: 23          #
	inx	h		;; e02f: 23          #
	mov	a,m		;; e030: 7e          ~
	ora	a		;; e031: b7          .
	rnz			;; e032: c0          .
	lxi	h,Le7fc		;; e033: 21 fc e7    ...
	call	Le017		;; e036: cd 17 e0    ...
	lxi	h,Le7fe		;; e039: 21 fe e7    ...
	call	Ldffd		;; e03c: cd fd df    ...
Le03f:	lxi	h,Le7fc		;; e03f: 21 fc e7    ...
	call	Le011		;; e042: cd 11 e0    ...
	rz			;; e045: c8          .
	inx	h		;; e046: 23          #
	inx	h		;; e047: 23          #
	inx	h		;; e048: 23          #
	jmp	Le485		;; e049: c3 85 e4    ...

Le04c:	lxi	h,Le7fe		;; e04c: 21 fe e7    ...
	call	Le017		;; e04f: cd 17 e0    ...
	rz			;; e052: c8          .
	inx	h		;; e053: 23          #
	inx	h		;; e054: 23          #
	mvi	m,0ffh		;; e055: 36 ff       6.
	lxi	h,Le7fc		;; e057: 21 fc e7    ...
	lxi	d,00000h	;; e05a: 11 00 00    ...
	call	Ldffd		;; e05d: cd fd df    ...
	mov	a,d		;; e060: 7a          z
	ora	e		;; e061: b3          .
	rnz			;; e062: c0          .
	lxi	h,Le7fc		;; e063: 21 fc e7    ...
	call	Le011		;; e066: cd 11 e0    ...
	inx	h		;; e069: 23          #
	inx	h		;; e06a: 23          #
	inx	h		;; e06b: 23          #
	jmp	Le485		;; e06c: c3 85 e4    ...

Le06f:	lxi	h,Le7fe		;; e06f: 21 fe e7    ...
	call	Le011		;; e072: cd 11 e0    ...
	rz			;; e075: c8          .
	inx	h		;; e076: 23          #
	inx	h		;; e077: 23          #
	mov	a,m		;; e078: 7e          ~
	ora	a		;; e079: b7          .
	mvi	m,0feh		;; e07a: 36 fe       6.
	dcx	h		;; e07c: 2b          +
	dcx	h		;; e07d: 2b          +
	rnz			;; e07e: c0          .
	push	h		;; e07f: e5          .
	lxi	b,00009h	;; e080: 01 09 00    ...
	dad	b		;; e083: 09          .
	mov	a,m		;; e084: 7e          ~
	ani	001h		;; e085: e6 01       ..
	pop	h		;; e087: e1          .
	jrz	Le08f		;; e088: 28 05       (.
	call	Le04c		;; e08a: cd 4c e0    .L.
	jr	Le06f		;; e08d: 18 e0       ..

Le08f:	sspd	Leb54		;; e08f: ed 73 54 eb .sT.
	lxi	sp,Leb54	;; e093: 31 54 eb    1T.
	push	h		;; e096: e5          .
	call	Le0af		;; e097: cd af e0    ...
	pop	h		;; e09a: e1          .
	call	Ld2f1		;; e09b: cd f1 d2    ...
	call	Le0bf		;; e09e: cd bf e0    ...
	lspd	Leb54		;; e0a1: ed 7b 54 eb .{T.
	call	Le04c		;; e0a5: cd 4c e0    .L.
	call	Ldf8f		;; e0a8: cd 8f df    ...
	call	Le027		;; e0ab: cd 27 e0    .'.
	ret			;; e0ae: c9          .

Le0af:	lxi	d,Leb56		;; e0af: 11 56 eb    .V.
	lxi	h,Lef0f		;; e0b2: 21 0f ef    ...
	lxi	b,00038h	;; e0b5: 01 38 00    .8.
	ldir			;; e0b8: ed b0       ..
	lda	Lf9de		;; e0ba: 3a de f9    :..
	stax	d		;; e0bd: 12          .
	ret			;; e0be: c9          .

Le0bf:	lxi	h,Leb56		;; e0bf: 21 56 eb    .V.
	lxi	d,Lef0f		;; e0c2: 11 0f ef    ...
	lxi	b,00038h	;; e0c5: 01 38 00    .8.
	ldir			;; e0c8: ed b0       ..
	mov	a,m		;; e0ca: 7e          ~
	sta	Lf9de		;; e0cb: 32 de f9    2..
	ret			;; e0ce: c9          .

Le0cf:	shld	Le7fa		;; e0cf: 22 fa e7    "..
Le0d2:	call	Le027		;; e0d2: cd 27 e0    .'.
	lxi	h,Le7fe		;; e0d5: 21 fe e7    ...
	call	Le011		;; e0d8: cd 11 e0    ...
	jrz	Le0f8		;; e0db: 28 1b       (.
	inx	h		;; e0dd: 23          #
	inx	h		;; e0de: 23          #
	mvi	m,0feh		;; e0df: 36 fe       6.
	dcx	h		;; e0e1: 2b          +
	dcx	h		;; e0e2: 2b          +
	push	h		;; e0e3: e5          .
	lxi	b,00009h	;; e0e4: 01 09 00    ...
	dad	b		;; e0e7: 09          .
	mov	a,m		;; e0e8: 7e          ~
	ani	001h		;; e0e9: e6 01       ..
	pop	h		;; e0eb: e1          .
	rnz			;; e0ec: c0          .
	call	Ld2f1		;; e0ed: cd f1 d2    ...
	call	Le04c		;; e0f0: cd 4c e0    .L.
	call	Ldf8f		;; e0f3: cd 8f df    ...
	jr	Le0fb		;; e0f6: 18 03       ..

Le0f8:	call	Le365		;; e0f8: cd 65 e3    .e.
Le0fb:	lxi	h,Le7fa		;; e0fb: 21 fa e7    ...
	dcr	m		;; e0fe: 35          5
	jrnz	Le0d2		;; e0ff: 20 d1        .
	inx	h		;; e101: 23          #
	dcr	m		;; e102: 35          5
	rz			;; e103: c8          .
	jr	Le0d2		;; e104: 18 cc       ..

Le106:	jmp	Le03f		;; e106: c3 3f e0    .?.

Le109:	lxi	sp,00100h	;; e109: 31 00 01    1..
	call	Le245		;; e10c: cd 45 e2    .E.
	lxi	d,Le160		;; e10f: 11 60 e1    .`.
	mvi	c,009h		;; e112: 0e 09       ..
	call	Ld206		;; e114: cd 06 d2    ...
	lda	Le593		;; e117: 3a 93 e5    :..
	call	Ld38d		;; e11a: cd 8d d3    ...
Le11d:	call	Ld2dd		;; e11d: cd dd d2    ...
	mvi	a,005h		;; e120: 3e 05       >.
	out	007h		;; e122: d3 07       ..
	mvi	a,0eah		;; e124: 3e ea       >.
	out	007h		;; e126: d3 07       ..
	call	Ldff0		;; e128: cd f0 df    ...
	call	Ldfdc		;; e12b: cd dc df    ...
	lhld	Le7a7		;; e12e: 2a a7 e7    *..
	lxi	d,00015h	;; e131: 11 15 00    ...
	dad	d		;; e134: 19          .
	call	Le15f		;; e135: cd 5f e1    ._.
	call	Le255		;; e138: cd 55 e2    .U.
	call	Le03f		;; e13b: cd 3f e0    .?.
	call	Le17f		;; e13e: cd 7f e1    ...
	lxi	sp,00100h	;; e141: 31 00 01    1..
	mvi	a,0c3h		;; e144: 3e c3       >.
	lhld	Le7a7		;; e146: 2a a7 e7    *..
	sta	00000h		;; e149: 32 00 00    2..
	shld	00001h		;; e14c: 22 01 00    "..
	sta	00005h		;; e14f: 32 05 00    2..
	lxi	h,Ld206		;; e152: 21 06 d2    ...
	shld	00006h		;; e155: 22 06 00    "..
	lda	00004h		;; e158: 3a 04 00    :..
	mov	c,a		;; e15b: 4f          O
	jmp	0ca03h		;; e15c: c3 03 ca    ...

Le15f:	pchl			;; e15f: e9          .

Le160:	db	0dh,0ah,'WARM BOOT - The Web Station $'
Le17f:	mvi	e,000h		;; e17f: 1e 00       ..
	mvi	c,0cbh		;; e181: 0e cb       ..
	call	Ld206		;; e183: cd 06 d2    ...
	lxi	d,0005ch	;; e186: 11 5c 00    .\.
	lxi	h,Le1ec		;; e189: 21 ec e1    ...
	lxi	b,0000fh	;; e18c: 01 0f 00    ...
	ldir			;; e18f: ed b0       ..
	xra	a		;; e191: af          .
	sta	0007ch		;; e192: 32 7c 00    2|.
	call	Le1e2		;; e195: cd e2 e1    ...
	jrnz	Le1ba		;; e198: 20 20         
	lxi	h,001ffh	;; e19a: 21 ff 01    ...
	shld	Le5d1		;; e19d: 22 d1 e5    "..
	mvi	c,00dh		;; e1a0: 0e 0d       ..
	call	Ld206		;; e1a2: cd 06 d2    ...
	call	Le1e2		;; e1a5: cd e2 e1    ...
	jrnz	Le1ba		;; e1a8: 20 10        .
	lxi	d,Le1fb		;; e1aa: 11 fb e1    ...
Le1ad:	mvi	c,009h		;; e1ad: 0e 09       ..
	call	Ld206		;; e1af: cd 06 d2    ...
	mvi	c,001h		;; e1b2: 0e 01       ..
	call	Ld206		;; e1b4: cd 06 d2    ...
	jmp	Le109		;; e1b7: c3 09 e1    ...

Le1ba:	lxi	h,0ca00h	;; e1ba: 21 00 ca    ...
	mvi	b,010h		;; e1bd: 06 10       ..
	mvi	c,014h		;; e1bf: 0e 14       ..
Le1c1:	push	h		;; e1c1: e5          .
	push	b		;; e1c2: c5          .
	xchg			;; e1c3: eb          .
	mvi	c,01ah		;; e1c4: 0e 1a       ..
	call	Ld206		;; e1c6: cd 06 d2    ...
	pop	b		;; e1c9: c1          .
	push	b		;; e1ca: c5          .
	lxi	d,0005ch	;; e1cb: 11 5c 00    .\.
	call	Ld206		;; e1ce: cd 06 d2    ...
	pop	b		;; e1d1: c1          .
	pop	h		;; e1d2: e1          .
	ora	a		;; e1d3: b7          .
	jrnz	Le1dd		;; e1d4: 20 07        .
	lxi	d,00080h	;; e1d6: 11 80 00    ...
	dad	d		;; e1d9: 19          .
	djnz	Le1c1		;; e1da: 10 e5       ..
	ret			;; e1dc: c9          .

Le1dd:	lxi	d,Le22e		;; e1dd: 11 2e e2    ...
	jr	Le1ad		;; e1e0: 18 cb       ..

Le1e2:	lxi	d,0005ch	;; e1e2: 11 5c 00    .\.
	mvi	c,00fh		;; e1e5: 0e 0f       ..
	call	Ld206		;; e1e7: cd 06 d2    ...
	inr	a		;; e1ea: 3c          <
	ret			;; e1eb: c9          .

Le1ec:	db	1,'WEBCCP  OVL',0,0,0
Le1fb:	db	'No file WEBCCP.OVL on A: - Hit any key when ready.$'
Le22e:	db	'Bad Load of WEBCCP.OVL$'
Le245:	lxi	h,Le7fe		;; e245: 21 fe e7    ...
	call	Le011		;; e248: cd 11 e0    ...
	rz			;; e24b: c8          .
	inx	h		;; e24c: 23          #
	inx	h		;; e24d: 23          #
	mov	a,m		;; e24e: 7e          ~
	ora	a		;; e24f: b7          .
	rz			;; e250: c8          .
	call	Le04c		;; e251: cd 4c e0    .L.
	ret			;; e254: c9          .

Le255:	di			;; e255: f3          .
	lxi	h,Le376		;; e256: 21 76 e3    .v.
	lxi	d,Lebf0		;; e259: 11 f0 eb    ...
	lxi	b,00010h	;; e25c: 01 10 00    ...
	ldir			;; e25f: ed b0       ..
	mvi	a,0ebh		;; e261: 3e eb       >.
	stai			;; e263: ed 47       .G
	im2			;; e265: ed 5e       .^
	mvi	a,018h		;; e267: 3e 18       >.
	out	006h		;; e269: d3 06       ..
	out	006h		;; e26b: d3 06       ..
	mvi	a,002h		;; e26d: 3e 02       >.
	out	007h		;; e26f: d3 07       ..
	mvi	a,0f0h		;; e271: 3e f0       >.
	out	007h		;; e273: d3 07       ..
	mvi	a,001h		;; e275: 3e 01       >.
	out	007h		;; e277: d3 07       ..
	mvi	a,004h		;; e279: 3e 04       >.
	out	007h		;; e27b: d3 07       ..
	lxi	h,Le4c9		;; e27d: 21 c9 e4    ...
	call	Le4c2		;; e280: cd c2 e4    ...
	ret			;; e283: c9          .

Le284:	shld	Leba0		;; e284: 22 a0 eb    "..
	mvi	a,01eh		;; e287: 3e 1e       >.
	sta	Leba3		;; e289: 32 a3 eb    2..
	sspd	Lebc4		;; e28c: ed 73 c4 eb .s..
Le290:	lxi	sp,Lebc4	;; e290: 31 c4 eb    1..
	push	h		;; e293: e5          .
	lxi	d,00008h	;; e294: 11 08 00    ...
	dad	d		;; e297: 19          .
	mov	a,m		;; e298: 7e          ~
	adi	008h		;; e299: c6 08       ..
	mov	b,a		;; e29b: 47          G
	mvi	c,004h		;; e29c: 0e 04       ..
	push	b		;; e29e: c5          .
Le29f:	mvi	c,064h		;; e29f: 0e 64       .d
Le2a1:	mvi	a,010h		;; e2a1: 3e 10       >.
	out	006h		;; e2a3: d3 06       ..
	in	006h		;; e2a5: db 06       ..
	ani	008h		;; e2a7: e6 08       ..
	jrz	Le2b9		;; e2a9: 28 0e       (.
	dcr	c		;; e2ab: 0d          .
	jz	Le36e		;; e2ac: ca 6e e3    .n.
	lda	Leba2		;; e2af: 3a a2 eb    :..
	ori	007h		;; e2b2: f6 07       ..
	call	Le34f		;; e2b4: cd 4f e3    .O.
	jr	Le2a1		;; e2b7: 18 e8       ..

Le2b9:	mvi	a,028h		;; e2b9: 3e 28       >(
	call	Le361		;; e2bb: cd 61 e3    .a.
	mvi	a,010h		;; e2be: 3e 10       >.
	out	006h		;; e2c0: d3 06       ..
	in	006h		;; e2c2: db 06       ..
	ani	008h		;; e2c4: e6 08       ..
	jrnz	Le29f		;; e2c6: 20 d7        .
	di			;; e2c8: f3          .
	mvi	a,001h		;; e2c9: 3e 01       >.
	out	007h		;; e2cb: d3 07       ..
	mvi	a,000h		;; e2cd: 3e 00       >.
	out	007h		;; e2cf: d3 07       ..
	lxi	h,Le4d4		;; e2d1: 21 d4 e4    ...
	call	Le4c2		;; e2d4: cd c2 e4    ...
	ei			;; e2d7: fb          .
	mvi	a,0aah		;; e2d8: 3e aa       >.
	out	004h		;; e2da: d3 04       ..
	mvi	a,005h		;; e2dc: 3e 05       >.
	out	006h		;; e2de: d3 06       ..
	mvi	a,06fh		;; e2e0: 3e 6f       >o
	out	006h		;; e2e2: d3 06       ..
	mvi	a,003h		;; e2e4: 3e 03       >.
Le2e6:	dcr	a		;; e2e6: 3d          =
	jrnz	Le2e6		;; e2e7: 20 fd        .
	mvi	a,080h		;; e2e9: 3e 80       >.
	out	006h		;; e2eb: d3 06       ..
	pop	b		;; e2ed: c1          .
	pop	h		;; e2ee: e1          .
	outi			;; e2ef: ed a3       ..
	inx	h		;; e2f1: 23          #
	dcx	h		;; e2f2: 2b          +
	inx	h		;; e2f3: 23          #
	dcx	h		;; e2f4: 2b          +
	outi			;; e2f5: ed a3       ..
	mvi	a,0d6h		;; e2f7: 3e d6       >.
	out	006h		;; e2f9: d3 06       ..
	mvi	a,000h		;; e2fb: 3e 00       >.
	outi			;; e2fd: ed a3       ..
	mvi	a,000h		;; e2ff: 3e 00       >.
	out	006h		;; e301: d3 06       ..
	mvi	a,000h		;; e303: 3e 00       >.
	outi			;; e305: ed a3       ..
	inx	h		;; e307: 23          #
	dcx	h		;; e308: 2b          +
	inx	h		;; e309: 23          #
	dcx	h		;; e30a: 2b          +
	outi			;; e30b: ed a3       ..
	inx	h		;; e30d: 23          #
	dcx	h		;; e30e: 2b          +
	inx	h		;; e30f: 23          #
	dcx	h		;; e310: 2b          +
	outi			;; e311: ed a3       ..
	inx	h		;; e313: 23          #
	dcx	h		;; e314: 2b          +
	inx	h		;; e315: 23          #
	dcx	h		;; e316: 2b          +
	outi			;; e317: ed a3       ..
	inx	h		;; e319: 23          #
	dcx	h		;; e31a: 2b          +
	inx	h		;; e31b: 23          #
	dcx	h		;; e31c: 2b          +
	outi			;; e31d: ed a3       ..
	inx	h		;; e31f: 23          #
	dcx	h		;; e320: 2b          +
	inx	h		;; e321: 23          #
	dcx	h		;; e322: 2b          +
Le323:	outi			;; e323: ed a3       ..
	inx	h		;; e325: 23          #
	dcx	h		;; e326: 2b          +
	jrnz	Le323		;; e327: 20 fa        .
	di			;; e329: f3          .
	outi			;; e32a: ed a3       ..
Le32c:	mvi	a,010h		;; e32c: 3e 10       >.
	out	006h		;; e32e: d3 06       ..
	in	006h		;; e330: db 06       ..
	cma			;; e332: 2f          /
	ani	044h		;; e333: e6 44       .D
	jrnz	Le32c		;; e335: 20 f5        .
	lxi	h,Le4df		;; e337: 21 df e4    ...
	call	Le4c2		;; e33a: cd c2 e4    ...
	call	Le488		;; e33d: cd 88 e4    ...
	lda	Leba2		;; e340: 3a a2 eb    :..
	srlr	a		;; e343: cb 3f       .?
	sta	Leba2		;; e345: 32 a2 eb    2..
	mvi	a,000h		;; e348: 3e 00       >.
Le34a:	lspd	Lebc4		;; e34a: ed 7b c4 eb .{..
	ret			;; e34e: c9          .

Le34f:	push	b		;; e34f: c5          .
	mov	b,a		;; e350: 47          G
	ldar			;; e351: ed 5f       ._
	rrc			;; e353: 0f          .
	rrc			;; e354: 0f          .
	rrc			;; e355: 0f          .
	rrc			;; e356: 0f          .
	ana	b		;; e357: a0          .
	inr	a		;; e358: 3c          <
	mov	b,a		;; e359: 47          G
Le35a:	call	Le365		;; e35a: cd 65 e3    .e.
	djnz	Le35a		;; e35d: 10 fb       ..
	pop	b		;; e35f: c1          .
	ret			;; e360: c9          .

Le361:	dcr	a		;; e361: 3d          =
	jrnz	Le361		;; e362: 20 fd        .
	ret			;; e364: c9          .

Le365:	mvi	a,07fh		;; e365: 3e 7f       >.
	call	Le361		;; e367: cd 61 e3    .a.
	call	Ldf8f		;; e36a: cd 8f df    ...
	ret			;; e36d: c9          .

Le36e:	call	Le488		;; e36e: cd 88 e4    ...
	mvi	a,002h		;; e371: 3e 02       >.
	jmp	Le34a		;; e373: c3 4a e3    .J.

Le376:	dw	Le386
	dw	00000h
	dw	00000h
	dw	00000h
	dw	00000h
	dw	Le469
	dw	Le3ad
	dw	Le478
Le386:	pop	d		;; e386: d1          .
	lxi	h,Le4df		;; e387: 21 df e4    ...
	call	Le4c2		;; e38a: cd c2 e4    ...
	call	Le488		;; e38d: cd 88 e4    ...
	lda	Leba2		;; e390: 3a a2 eb    :..
	stc			;; e393: 37          7
	ral			;; e394: 17          .
	sta	Leba2		;; e395: 32 a2 eb    2..
	call	Le34f		;; e398: cd 4f e3    .O.
	lda	Leba3		;; e39b: 3a a3 eb    :..
	dcr	a		;; e39e: 3d          =
	sta	Leba3		;; e39f: 32 a3 eb    2..
	lhld	Leba0		;; e3a2: 2a a0 eb    *..
	jnz	Le290		;; e3a5: c2 90 e2    ...
	mvi	a,001h		;; e3a8: 3e 01       >.
	jmp	Le34a		;; e3aa: c3 4a e3    .J.

Le3ad:	push	psw		;; e3ad: f5          .
	push	b		;; e3ae: c5          .
	push	h		;; e3af: e5          .
	lhld	Lebc6		;; e3b0: 2a c6 eb    *..
	in	004h		;; e3b3: db 04       ..
	cmp	m		;; e3b5: be          .
	mov	m,a		;; e3b6: 77          w
	inx	h		;; e3b7: 23          #
	mvi	c,004h		;; e3b8: 0e 04       ..
	jnz	Le433		;; e3ba: c2 33 e4    .3.
	ini			;; e3bd: ed a2       ..
	mvi	a,010h		;; e3bf: 3e 10       >.
	out	006h		;; e3c1: d3 06       ..
	ini			;; e3c3: ed a2       ..
	mvi	a,011h		;; e3c5: 3e 11       >.
	out	006h		;; e3c7: d3 06       ..
	ini			;; e3c9: ed a2       ..
	mvi	a,009h		;; e3cb: 3e 09       >.
	out	006h		;; e3cd: d3 06       ..
	ini			;; e3cf: ed a2       ..
	mvi	a,038h		;; e3d1: 3e 38       >8
	out	006h		;; e3d3: d3 06       ..
	ei			;; e3d5: fb          .
	ini			;; e3d6: ed a2       ..
	inx	h		;; e3d8: 23          #
	dcx	h		;; e3d9: 2b          +
	inx	h		;; e3da: 23          #
	dcx	h		;; e3db: 2b          +
	ini			;; e3dc: ed a2       ..
Le3de:	ini			;; e3de: ed a2       ..
	inp	b		;; e3e0: ed 40       .@
	mov	m,b		;; e3e2: 70          p
	inx	h		;; e3e3: 23          #
	inx	h		;; e3e4: 23          #
	dcx	h		;; e3e5: 2b          +
Le3e6:	ini			;; e3e6: ed a2       ..
	inx	h		;; e3e8: 23          #
	dcx	h		;; e3e9: 2b          +
	jrnz	Le3e6		;; e3ea: 20 fa        .
	di			;; e3ec: f3          .
	in	004h		;; e3ed: db 04       ..
	inxix			;; e3ef: dd 23       .#
	dcxix			;; e3f1: dd 2b       .+
	inx	h		;; e3f3: 23          #
	dcx	h		;; e3f4: 2b          +
	in	004h		;; e3f5: db 04       ..
	inxix			;; e3f7: dd 23       .#
	dcxix			;; e3f9: dd 2b       .+
	inx	h		;; e3fb: 23          #
	dcx	h		;; e3fc: 2b          +
	in	004h		;; e3fd: db 04       ..
	inxix			;; e3ff: dd 23       .#
	dcxix			;; e401: dd 2b       .+
	inx	h		;; e403: 23          #
	dcx	h		;; e404: 2b          +
	mvi	a,001h		;; e405: 3e 01       >.
	out	006h		;; e407: d3 06       ..
	in	006h		;; e409: db 06       ..
	ani	060h		;; e40b: e6 60       .`
	lhld	Lebc6		;; e40d: 2a c6 eb    *..
	dcx	h		;; e410: 2b          +
	mov	m,a		;; e411: 77          w
	lxi	h,Le4f3		;; e412: 21 f3 e4    ...
	call	Le4c2		;; e415: cd c2 e4    ...
	lhld	Lebc6		;; e418: 2a c6 eb    *..
	dcx	h		;; e41b: 2b          +
	mov	a,m		;; e41c: 7e          ~
	ora	a		;; e41d: b7          .
	jrz	Le42e		;; e41e: 28 0e       (.
Le420:	inx	h		;; e420: 23          #
	lda	Le593		;; e421: 3a 93 e5    :..
	mov	m,a		;; e424: 77          w
	call	Le4a8		;; e425: cd a8 e4    ...
	lxi	h,Le4ea		;; e428: 21 ea e4    ...
	call	Le4c2		;; e42b: cd c2 e4    ...
Le42e:	pop	h		;; e42e: e1          .
	pop	b		;; e42f: c1          .
	pop	psw		;; e430: f1          .
	ei			;; e431: fb          .
	ret			;; e432: c9          .

Le433:	ini			;; e433: ed a2       ..
	cpi	0ffh		;; e435: fe ff       ..
	jrnz	Le457		;; e437: 20 1e        .
	ini			;; e439: ed a2       ..
	mvi	a,010h		;; e43b: 3e 10       >.
	out	006h		;; e43d: d3 06       ..
	ini			;; e43f: ed a2       ..
	mvi	a,011h		;; e441: 3e 11       >.
	out	006h		;; e443: d3 06       ..
	ini			;; e445: ed a2       ..
	mvi	a,009h		;; e447: 3e 09       >.
	out	006h		;; e449: d3 06       ..
	ini			;; e44b: ed a2       ..
	mvi	a,038h		;; e44d: 3e 38       >8
	out	006h		;; e44f: d3 06       ..
	ei			;; e451: fb          .
	ini			;; e452: ed a2       ..
	jmp	Le3de		;; e454: c3 de e3    ...

Le457:	mvi	a,013h		;; e457: 3e 13       >.
	out	006h		;; e459: d3 06       ..
	mvi	a,0d8h		;; e45b: 3e d8       >.
	out	006h		;; e45d: d3 06       ..
	mvi	a,001h		;; e45f: 3e 01       >.
Le461:	lhld	Lebc6		;; e461: 2a c6 eb    *..
	dcx	h		;; e464: 2b          +
	mov	m,a		;; e465: 77          w
	jmp	Le420		;; e466: c3 20 e4    . .

Le469:	mvi	a,003h		;; e469: 3e 03       >.
	out	006h		;; e46b: d3 06       ..
	mvi	a,0d8h		;; e46d: 3e d8       >.
	out	006h		;; e46f: d3 06       ..
	in	006h		;; e471: db 06       ..
	ani	0f8h		;; e473: e6 f8       ..
	pop	h		;; e475: e1          .
	jr	Le461		;; e476: 18 e9       ..

Le478:	mvi	a,003h		;; e478: 3e 03       >.
	out	006h		;; e47a: d3 06       ..
	mvi	a,0d8h		;; e47c: 3e d8       >.
	out	006h		;; e47e: d3 06       ..
	mvi	a,020h		;; e480: 3e 20       > 
	pop	h		;; e482: e1          .
	jr	Le461		;; e483: 18 dc       ..

Le485:	shld	Lebc6		;; e485: 22 c6 eb    "..
Le488:	di			;; e488: f3          .
	mvi	a,001h		;; e489: 3e 01       >.
	out	007h		;; e48b: d3 07       ..
	mvi	a,004h		;; e48d: 3e 04       >.
	out	007h		;; e48f: d3 07       ..
	lhld	Lebc6		;; e491: 2a c6 eb    *..
	dcx	h		;; e494: 2b          +
	mov	a,m		;; e495: 7e          ~
	ora	a		;; e496: b7          .
	rz			;; e497: c8          .
	inx	h		;; e498: 23          #
	lda	Le593		;; e499: 3a 93 e5    :..
	mov	m,a		;; e49c: 77          w
	call	Le4a8		;; e49d: cd a8 e4    ...
	lxi	h,Le4ea		;; e4a0: 21 ea e4    ...
	call	Le4c2		;; e4a3: cd c2 e4    ...
	ei			;; e4a6: fb          .
	ret			;; e4a7: c9          .

Le4a8:	mvi	a,030h		;; e4a8: 3e 30       >0
	out	006h		;; e4aa: d3 06       ..
	in	006h		;; e4ac: db 06       ..
	rrc			;; e4ae: 0f          .
	rnc			;; e4af: d0          .
	in	004h		;; e4b0: db 04       ..
	jr	Le4a8		;; e4b2: 18 f4       ..

Le4b4:	di			;; e4b4: f3          .
	lxi	h,Le4f3		;; e4b5: 21 f3 e4    ...
	call	Le4c2		;; e4b8: cd c2 e4    ...
	lxi	h,Le4f9		;; e4bb: 21 f9 e4    ...
	shld	Lebc6		;; e4be: 22 c6 eb    "..
	ret			;; e4c1: c9          .

Le4c2:	mvi	c,006h		;; e4c2: 0e 06       ..
	mov	b,m		;; e4c4: 46          F
	inx	h		;; e4c5: 23          #
	outir			;; e4c6: ed b3       ..
	ret			;; e4c8: c9          .

Le4c9:	db	0ah,14h,10h,16h,0f5h,17h,0fah,13h,0d8h,15h,65h
Le4d4:	db	0ah,33h,0d8h,0b1h,0,15h,67h,10h,10h,39h,1
Le4df:	db	0ah,0,15h,67h,11h,0,15h,65h,16h,0f5h,38h
Le4ea:	db	8,70h,13h,0d8h,11h,8,38h,23h,0d9h
Le4f3:	db	4,11h,0,33h,0d8h
	db	0
Le4f9:	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0
Le560:	db	0ffh
Le561:	db	0ffh,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0
Le587:	db	0,0
Le589:	db	0
Le58a:	db	0ffh,0ffh
Le58c:	db	0
Le58d:	db	0,0
Le58f:	db	0
Le590:	db	0
Le591:	dw	80h
Le593:	db	0
Le594:	db	1
Le595:	db	0
Le596:	db	0
Le597:	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0
Le5b8:	db	0,0,0
Le5bb:	db	0
Le5bc:	db	0
Le5bd:	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
Le5cc:	db	0
Le5cd:	db	0,0
Le5cf:	db	0
Le5d0:	db	0
Le5d1:	db	0ffh
Le5d2:	db	1,0ffh,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0
Le5f0:	db	0
Le5f1:	db	0,0,0ffh
Le5f4:	db	0,0,0,0,0,0,20h,0,1,0,0,0,0
Le601:	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0
Le624:	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0
Le6a4:	db	0
Le6a5:	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
Le6b4:	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
Le6c3:	db	0,0
Le6c5:	db	0
Le6c6:	db	0,0
Le6c8:	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
Le756:	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
Le765:	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0
Le7a7:	dw	0fa03h
Le7a9:	jmp	00000h		;; e7a9: c3 00 00    ...

Le7aa	equ	$-2
	jmp	00000h		;; e7ac: c3 00 00    ...

Le7ad	equ	$-2
Le7af:	jmp	00000h		;; e7af: c3 00 00    ...

Le7b0	equ	$-2
Le7b2:	jmp	00000h		;; e7b2: c3 00 00    ...

Le7b3	equ	$-2
Le7b5:	db	0
Le7b6:	db	0
Le7b7:	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0
Le7fa:	db	0,0
Le7fc:	dw	Le800
Le7fe:	dw	0
Le800:	dw	Le90c
	db	0ffh,0,0,0,0,0,0,10h,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
Le90c:	dw	Lea18
	db	0ffh,0,0,0,0,0,0,10h,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
Lea18:	dw	0
	db	0ffh,0,0,0,0,0,0,10h,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
Leb54:	dw	Leb54
Leb56:	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0
Leba0:	db	0,0
Leba2:	db	0
Leba3:	db	1eh,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0
Lebc4:	db	0,0
Lebc6:	dw	Le4f9
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0
Lebf0:	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
; special locations in BDOS
Lef0f	equ	$+783
Lf9de	equ	$+3550
	end

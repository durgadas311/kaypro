	org	00100h

	mvi	c,07fh	; get (spool?) buffer (L1f71)
	call	00005h		;; 0102: cd 05 00    ...
	mov	a,m		;; 0105: 7e          ~
	cpi	04ch		;; 0106: fe 4c       .L
	jz	L0113		;; 0108: ca 13 01    ...
	cpi	057h		;; 010b: fe 57       .W
	jz	L0176		;; 010d: ca 76 01    .v.
	jmp	00000h		;; 0110: c3 00 00    ...

; 04ch... 'L' - Locate?
L0113:	lda	0005dh		;; 0113: 3a 5d 00    :].
	cpi	' '		;; 0116: fe 20       . 
	jnz	L0120		;; 0118: c2 20 01    . .
	mvi	a,'0'		;; 011b: 3e 30       >0
	sta	0005dh		;; 011d: 32 5d 00    2].
L0120:	mvi	a,001h		;; 0120: 3e 01       >.
L0122:	push	psw		;; 0122: f5          .
	mvi	c,07eh	; 126 -  get &L1e9c[A] - drive map?
	call	00005h		;; 0125: cd 05 00    ...
	lda	0005dh		;; 0128: 3a 5d 00    :].
	sui	'0'		;; 012b: d6 30       .0
	inx	h		;; 012d: 23          #
	mov	m,a		;; 012e: 77          w
	pop	psw		;; 012f: f1          .
	inr	a		;; 0130: 3c          <
	cpi	17		;; 0131: fe 11       ..
	jnz	L0122		;; 0133: c2 22 01    .".
	lda	0005dh		;; 0136: 3a 5d 00    :].
	cpi	'0'		;; 0139: fe 30       .0
	jz	L014a	; local...
	sta	L0169		;; 013e: 32 69 01    2i.
	lxi	d,L0164	; "Node X located"
	call	L019d		;; 0144: cd 9d 01    ...
	jmp	00000h		;; 0147: c3 00 00    ...

L014a:	lxi	d,L0153	; "Located local"
	call	L019d		;; 014d: cd 9d 01    ...
	jmp	00000h		;; 0150: c3 00 00    ...

L0153:	db	'Located local.',0dh,0ah,'$'
L0164:	db	'Node '
L0169:	db	'0 located.',0dh,0ah,'$'

; 057h... 'W' - ???
L0176:	mvi	a,'$'		;; 0176: 3e 24       >$
	sta	L01d0	; null spooler msg
	lda	0005ch		;; 017b: 3a 5c 00    :\.
	cpi	0	; no drive specified
	jz	L01d9		;; 0180: ca d9 01    ...
	mvi	c,07eh	; 126 - drive map?
	call	00005h		;; 0185: cd 05 00    ...
	mov	a,m		;; 0188: 7e          ~
	cpi	0		;; 0189: fe 00       ..
	jz	L032b		;; 018b: ca 2b 03    .+.
	call	L019a	; print header
	lda	0005ch		;; 0191: 3a 5c 00    :\.
	call	L01a5	; set drive shared?
	jmp	00000h		;; 0197: c3 00 00    ...

L019a:	lxi	d,L035d	; header: "Log:   Phy:   Location"
L019d:	mvi	c,009h		;; 019d: 0e 09       ..
	push	h		;; 019f: e5          .
	call	00005h		;; 01a0: cd 05 00    ...
	pop	h		;; 01a3: e1          .
	ret			;; 01a4: c9          .

L01a5:	adi	'@'		;; 01a5: c6 40       .@
	call	L030f	; print "A:\t"
	mov	a,m		;; 01aa: 7e          ~
	adi	'@'		;; 01ab: c6 40       .@
	call	L030f	; print "A:\t"
	inx	h		;; 01b0: 23          #
	mov	a,m		;; 01b1: 7e          ~
L01b2:	cpi	0		;; 01b2: fe 00       ..
	jz	L0325	; "Local"
	push	psw		;; 01b7: f5          .
	lxi	d,L033e	; "Node "
	call	L019d		;; 01bb: cd 9d 01    ...
	pop	psw		;; 01be: f1          .
	adi	'0'		;; 01bf: c6 30       .0
	call	L0317	; node-id
	lxi	d,L01d0	; " spooler"
	call	L019d		;; 01c7: cd 9d 01    ...
	lxi	d,L033b	; CR/LF
	jmp	L019d		;; 01cd: c3 9d 01    ...

L01d0:	db	' spooler$'

; 'W' but no drive
L01d9:	call	L019a		;; 01d9: cd 9a 01    ...
	mvi	a,001h		;; 01dc: 3e 01       >.
L01de:	push	psw		;; 01de: f5          .
	mvi	c,07eh	; get map table
	call	00005h		;; 01e1: cd 05 00    ...
	mov	a,m		;; 01e4: 7e          ~
	cpi	0		;; 01e5: fe 00       ..
	jz	L01ef		;; 01e7: ca ef 01    ...
	pop	psw		;; 01ea: f1          .
	push	psw		;; 01eb: f5          .
	call	L01a5	; print drive (local/remote) and node id "spooler"
L01ef:	pop	psw		;; 01ef: f1          .
	inr	a		;; 01f0: 3c          <
	cpi	17		;; 01f1: fe 11       ..
	jnz	L01de		;; 01f3: c2 de 01    ...
	; done with drives, print devices...
	lxi	d,L02dd	; LST: values
	call	L019d		;; 01f9: cd 9d 01    ...
	call	L0315		;; 01fc: cd 15 03    ...
	lda	00003h	; iobyte
	lxi	h,L02dd		;; 0202: 21 dd 02    ...
	call	L020b		;; 0205: cd 0b 02    ...
	jmp	L0234		;; 0208: c3 34 02    .4.

L020b:	lxi	d,L02f6		;; 020b: 11 f6 02    ...
	lxi	b,25		;; 020e: 01 19 00    ...
	ldir			;; 0211: ed b0       ..
	ani	0c0h		;; 0213: e6 c0       ..
	lxi	d,L02fb		;; 0215: 11 fb 02    ...
	jz	L022e		;; 0218: ca 2e 02    ...
	lxi	d,L0300		;; 021b: 11 00 03    ...
	cpi	040h		;; 021e: fe 40       .@
	jz	L022e		;; 0220: ca 2e 02    ...
	lxi	d,L0305		;; 0223: 11 05 03    ...
	cpi	080h		;; 0226: fe 80       ..
	jz	L022e		;; 0228: ca 2e 02    ...
	lxi	d,L030a		;; 022b: 11 0a 03    ...
L022e:	call	L019d		;; 022e: cd 9d 01    ...
	jmp	L0315		;; 0231: c3 15 03    ...

; print rest of devices by iobyte
L0234:	mvi	a,020h		;; 0234: 3e 20       > 
	sta	L01d0		;; 0236: 32 d0 01    2..
	mvi	c,081h		;; 0239: 0e 81       ..
	call	00005h		;; 023b: cd 05 00    ...
	call	L01b2		;; 023e: cd b2 01    ...
	lxi	d,L0292		;; 0241: 11 92 02    ...
	call	L019d		;; 0244: cd 9d 01    ...
	call	L0315		;; 0247: cd 15 03    ...
	lda	00003h		;; 024a: 3a 03 00    :..
	add	a		;; 024d: 87          .
	add	a		;; 024e: 87          .
	lxi	h,L0292		;; 024f: 21 92 02    ...
	call	L020b		;; 0252: cd 0b 02    ...
	xra	a		;; 0255: af          .
	call	L01b2		;; 0256: cd b2 01    ...
	lxi	d,L02ab		;; 0259: 11 ab 02    ...
	call	L019d		;; 025c: cd 9d 01    ...
	call	L0315		;; 025f: cd 15 03    ...
	lda	00003h		;; 0262: 3a 03 00    :..
	add	a		;; 0265: 87          .
	add	a		;; 0266: 87          .
	add	a		;; 0267: 87          .
	add	a		;; 0268: 87          .
	lxi	h,L02ab		;; 0269: 21 ab 02    ...
	call	L020b		;; 026c: cd 0b 02    ...
	xra	a		;; 026f: af          .
	call	L01b2		;; 0270: cd b2 01    ...
	lxi	d,L02c4		;; 0273: 11 c4 02    ...
	call	L019d		;; 0276: cd 9d 01    ...
	call	L0315		;; 0279: cd 15 03    ...
	lda	00003h		;; 027c: 3a 03 00    :..
	add	a		;; 027f: 87          .
	add	a		;; 0280: 87          .
	add	a		;; 0281: 87          .
	add	a		;; 0282: 87          .
	add	a		;; 0283: 87          .
	add	a		;; 0284: 87          .
	lxi	h,L02c4		;; 0285: 21 c4 02    ...
	call	L020b		;; 0288: cd 0b 02    ...
	xra	a		;; 028b: af          .
	call	L01b2		;; 028c: cd b2 01    ...
	jmp	00000h		;; 028f: c3 00 00    ...

L0292:	db	'PUN:$'
	db	'TTY:$'
	db	'PUN:$'
	db	'UP1:$'
	db	'UP2:$'
L02ab:	db	'RDR:$'
	db	'TTY:$'
	db	'RDR:$'
	db	'UR1:$'
	db	'UR2:$'
L02c4:	db	'CON:$'
	db	'TTY:$'
	db	'CRT:$'
	db	'BAT:$'
	db	'UC1:$'
L02dd:	db	'LST:$'
	db	'TTY:$'
	db	'CRT:$'
	db	'LPT:$'
	db	'UL1:$'
L02f6:	db	'LST:$'
L02fb:	db	'TTY:$'
L0300:	db	'CRT:$'
L0305:	db	'LPT:$'
L030a:	db	'UL1:$'

; print "A:\t"
L030f:	call	L0317		;; 030f: cd 17 03    ...
	call	L0320		;; 0312: cd 20 03    . .
L0315:	mvi	a,009h	; TAB
L0317:	mvi	c,002h	; conout
	mov	e,a		;; 0319: 5f          _
	push	h		;; 031a: e5          .
	call	00005h		;; 031b: cd 05 00    ...
	pop	h		;; 031e: e1          .
	ret			;; 031f: c9          .

L0320:	mvi	a,':'		;; 0320: 3e 3a       >:
	jmp	L0317		;; 0322: c3 17 03    ...

L0325:	lxi	d,L0336	; "Local"
	jmp	L019d		;; 0328: c3 9d 01    ...

L032b:	lxi	d,L0344		;; 032b: 11 44 03    .D.
	mvi	c,009h		;; 032e: 0e 09       ..
	call	L019d		;; 0330: cd 9d 01    ...
	jmp	00000h		;; 0333: c3 00 00    ...

L0336:	db	'Local'
L033b:	db	0dh,0ah,'$'
L033e:	db	'Node $'
L0344:	db	'? Device not assigned.',0dh,0ah,'$'
L035d:	db	'Log:',9,'Phy:',9,'Location',0dh,0ah,'$'
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0
	end

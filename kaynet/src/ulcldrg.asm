; loader part of ULCOPSG.COM

ulcf67	equ	103
ulcf65	equ	101

	org	00100h
	lxi	h,00000h	;; 0100: 21 00 00    ...
	mvi	c,ulcf67	;; 0103: 0e 67       .g
	call	00005h		;; 0105: cd 05 00    ...
	mov	a,h		;; 0108: 7c          |
	ana	a		;; 0109: a7          .
	jrz	L0111	; ULCOPS not loaded...
	mvi	c,ulcf65	;; 010c: 0e 65       .e
	call	00005h		;; 010e: cd 05 00    ...
	; reached?

L0111:	lda	00007h	; hi addr of bdos
	sui	021h		;; 0114: d6 21       ..
	mov	d,a		;; 0116: 57          W
	mvi	e,0
	sded	L0206	; start of ULCOPS
	dcr	a		;; 011d: 3d          =
	sta	L0200	; stack area? end of TPA?
	lxi	h,L0680	; ULCOPS code start
	; DE = destination (high mem)
	; HL = code source
L0124:	mov	a,m		;; 0124: 7e          ~
	push	psw		;; 0125: f5          .
	lda	L0201		;; 0126: 3a 01 02    :..
	ana	a		;; 0129: a7          .
	jrnz	L0147		;; 012a: 20 1b        .
	; need new reloc bitmap byte
	push	h		;; 012c: e5          .
	; get next byte from reloc bitmap
	lhld	L0208		;; 012d: 2a 08 02    *..
	dcx	h		;; 0130: 2b          +
	shld	L0208		;; 0131: 22 08 02    "..
	mov	a,h		;; 0134: 7c          |
	cpi	0ffh	; HL < 0
	jrz	L0163		;; 0137: 28 2a       (*
	lhld	L0202		;; 0139: 2a 02 02    *..
	mov	a,m		;; 013c: 7e          ~
	sta	L0204		;; 013d: 32 04 02    2..
	inx	h		;; 0140: 23          #
	shld	L0202		;; 0141: 22 02 02    "..
	pop	h		;; 0144: e1          .
	mvi	a,008h		;; 0145: 3e 08       >.
L0147:	dcr	a		;; 0147: 3d          =
	sta	L0201		;; 0148: 32 01 02    2..
	lda	L0204		;; 014b: 3a 04 02    :..
	ral			;; 014e: 17          .
	sta	L0204		;; 014f: 32 04 02    2..
	jrnc	L015d		;; 0152: 30 09       0.
	pop	psw		;; 0154: f1          .
	push	h		;; 0155: e5          .
	lxi	h,L0200		;; 0156: 21 00 02    ...
	add	m		;; 0159: 86          .
	pop	h		;; 015a: e1          .
	jr	L015e		;; 015b: 18 01       ..

L015d:	pop	psw		;; 015d: f1          .
L015e:	stax	d		;; 015e: 12          .
	inx	h		;; 015f: 23          #
	inx	d		;; 0160: 13          .
	jr	L0124		;; 0161: 18 c1       ..

; done with relocation (and move)
L0163:	lhld	L0206		;; 0163: 2a 06 02    *..
	pchl			;; 0166: e9          .

	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh,7fh
	db	7fh,7fh,7fh
L0200:	db	0	; reloc offset
L0201:	db	0	; bit counter
L0202:	dw	L0280	; current bitmap pointer
L0204:	dw	0	; current bitmap byte
L0206:	dw	0
L0208:	dw	03d4h	; length of valid bitmap ((code_len + 7) / 8)

	db	0,0,0,0,0,0,0,'x',19h,0edh,'[x',19h,0cdh,0e7h,1ch,':'
	db	7,0,'=',0bch,0cah,8eh,0ah,'*x',19h,11h,80h,0,19h,'"x',19h
	db	11h,0e3h,1eh,0cdh,0efh,1ch,0b7h,'(',0dbh,11h,80h,0,0cdh,0e7h
	db	1ch,':',13h,1bh,'2g',1eh,0cdh,0cch,1ch,0cdh,0e9h,5,':[',1eh
	db	0a7h,0c2h,9dh,4,':V',1eh,0feh,'1',0cah,'M',19h,':',0efh,' 2'
	db	21h,21h,0cdh,0,1,0c3h,'>',4,':m',19h,0a7h,0c2h,'{',19h,'<2m'
	db	19h,'>',1,'2',0efh,' ',0cdh,'n',19h,0afh,'2 ',21h,0c3h,0dbh
	db	18h,0,0afh,'2g'

L0280:	ds	1024	; reloc bitmap area [ds (03d4h + 0ffh) & 0xff00]
L0680:	ds	0	; code to relocate
	end

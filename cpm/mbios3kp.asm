vers equ '1c' ; July 18, 2020  07:43  drm "MBIOS3KP.ASM"
;****************************************************************
; Main BIOS module for CP/M 3 (CP/M plus) on the KAYPRO computer*
; Copyright (c) 1985 Douglas Miller				*
;****************************************************************
	maclib Z80

true	equ -1
false	equ not true

bnksiz	equ	56	;size of banks, in "K". Either 48 or 56.
compag	equ	bnksiz*4    ; C0 or E0, for MMU common page select
bnktop	equ	compag shl 8	;C000 or E000

cr	equ 13
lf	equ 10
bell	equ 7

cpm	equ	0
bdos	equ	5
ccp	equ 0100h	; Console Command Processor gets loaded into the TPA

;  SCB registers
	extrn @covec,@civec,@aovec,@aivec,@lovec,@ermde
	extrn @mxtpa,@sec,@min,@hour,@date
	extrn @lptbl

;  External routines
	extrn ?getdp,?serdp

;  Variables for use by other modules
	public @adrv,@pdrv,@rdrv,@side,@trk,@sect,@login
	public @dma,@dbnk,@cnt,@scrbf,@dtacb,@dircb
	public @dstat,@cmode,@dph,@rcnfg
	public @ctbl,@cbnk,bnkdos,resdos,wbtrap
	public @vect,sio1vec,sio2vec,piovec

;  Routines for use by other modules
	public ?timot
	public ?dvtbl,?drtbl
	public ?bnksl,?stbnk
	public ?halloc

*********************************************************
**  I/O port base addresses
*********************************************************
sio1	equ	004h	;z80-sio/0
sio2	equ	00ch	; "
pio	equ	020h	;modem and rtc functions
rtc	equ	024h	;real-time clock
fdc	equ	010h	;floppy disk controller
mmu	equ	03fh	;memory management
sysctl	equ	014h	;system control (and floppy disk control bits)

*********************************************************
**  SIO's
*********************************************************
sio1datA equ	sio1+0
sio1ctlA equ	sio1datA+2
sio1datB equ	sio1+1
sio1ctlB equ	sio1datB+2

sio2datA equ	sio2+0
sio2ctlA equ	sio2datA+2
sio2datB equ	sio2+1
sio2ctlB equ	sio2datB+2

*********************************************************
**  PIO
*********************************************************
pioAdat equ	pio+0
pioActl equ	pioAdat+2
pioBdat equ	pio+1
pioBctl equ	pioBdat+2

*********************************************************
**  RTC (MM58167 Real-Time Clock)
*********************************************************
RTCDTA	equ	RTC
RTCADR	equ	pioAdat

RTCSEC	equ	2
RTCMIN	equ	3
RTCHRS	equ	4
RTCDAY	equ	5
RTCDAT	equ	6
RTCMON	equ	7
lastmon equ	10	;month last accessed (used to detect year change)
rtcyrs	equ	8	;years (decade)
rtcent	equ	9	;century

clrcnt	equ	18
rtcsts	equ	20
rtcis	equ	16	;interupt status
rtcic	equ	17	;interupt control

hbnk	equ	2	;bank to use for Hash tables.
hstart	equ	100h	;reserve page 0 for interupt vectors, etc.
hsize	equ	(bnktop-hstart)/16   ;allocate space equally to each drive.


;-------- Start of Code-producing source -----------

	cseg		; GENCPM puts CSEG stuff in common memory
BIOS$0	equ	$
bnkdos	equ	bios$0+0fc00h	;dummy values, reloc "Fxxx", GENCPM will
resdos	equ	bios$0+0fd00h	; substitiute real values.
	jmp boot	; initial entry on cold start
	jmp wboot	; reentry on program exit, warm start
 
	jmp const	; return console input status
	jmp conin	; return console input character
	jmp conout	; send console output character
	jmp list	; send list output character
	jmp auxout	; send auxilliary output character
	jmp auxin	; return auxilliary input character

	jmp home	; set disks to logical home
	jmp seldsk	; select disk drive, return disk parameter info
	jmp settrk	; set disk track
	jmp setsec	; set disk sector
	jmp setdma	; set disk I/O memory address
	jmp read	; read physical block(s)
	jmp write	; write physical block(s)

	jmp listst	; return list device status
	jmp sectrn	; translate logical to physical sector

	jmp conost	; return console output status
	jmp auxist	; return aux input status
	jmp auxost	; return aux output status
?dvtbl: jmp devtbl	; return address of device def table
	jmp cinit	; change baud rate of device

?drtbl: jmp getdrv	; return address of disk drive table
	jmp multio	; set multiple record count for disk I/O
	jmp flush	; flush BIOS maintained disk caching

movev:	jmp move	; block move memory to memory
	jmp timex	; Signal Time and Date operation
?bnksl: jmp bnksel	; select bank for code execution and default DMA
?stbnk: jmp setbnk	; select different bank for disk I/O DMA operations.
	jmp xmove	; set source and destination banks for one operation

	jmp search	; reserved for OEM: search for module.
	jmp 0		; reserved for future expansion
	jmp 0		; reserved for future expansion

; The following are accessed externally, relative to wboot entry.
; (for both utilities as well as SETUP.COM)
@dstat: ds	1
	ds	1	; unused by Kaypro

	dw	@lptbl	;logical/physical drive table
	dw	thread	;module thread
	dw	?serdp	;test mode validity, HL=memory address of ?serdp

@adrv:	ds	1		; currently selected disk drive
@pdrv:	ds	1		; physical drive number
@rdrv:	ds	1		; module relative disk drive number
curmdl: ds	2		; currently selected Disk I/O module address
@cmode: ds	2
@dph:	ds	2

icovec: dw	1000000000000000b
icivec: dw	0100000000000000b
iaovec: dw	0000000000000000b
iaivec: dw	0000000000000000b
ilovec: dw	0000001000000000b

defsrc: db	0,0ffh,0ffh,0ffh
tmpdrv: db	0
srctyp: db	000$00$000b	;only bits 3,4 are used (others ignored)

	dw	@memstr ; Memory driver module string
	dw	@rtcstr ; RTC driver module string
; End of externally dependent locations.

@dma:	dw	0
wbtrap: dw	0

goccp:	mvi	a,1	;select bank 1 (where CCP is)
	call	bnksel
	jmp	ccp	; then exit to ccp

bdose:	lhld	@mxtpa
	call	icall
	xra	a
	call	bnksel
	mov	a,l
	mov	b,h
	ret

@@ set ($-BIOS$0)
 if (@@ and 0fh) ne 0
 ds 16-(@@ and 0fh)
 endif	;put vectors on req. boundary, xxxxx000x for SIOs
;	 and xxxxxxx0 for PIO.
@vect:	
sio1vec:
	dw	nullsio ; chB TxE
	dw	nullsio ;     Ext/Sts
	dw	nullsio ;     RxA
	dw	nullsio ;     Spcl
	dw	nullsio ; chA TxE
	dw	nullsio ;     Ext/Sts
	dw	nullsio ;     RxA
	dw	nullsio ;     Spcl
sio2vec:
	dw	nullsio ; chB TxE
	dw	nullsio ;     Ext/Sts
	dw	nullsio ;     RxA
	dw	nullsio ;     Spcl
	dw	nullsio ; chA TxE
	dw	nullsio ;     Ext/Sts
	dw	nullsio ;     RxA
	dw	nullsio ;     Spcl
piovec:
	dw	nullpio ;ch A
	dw	nullpio ;ch B

@v set @vect-BIOS$0
@@ set $-BIOS$0
 if (@v shr 8) ne (@@ shr 8)
ds 'Vect X page bound'
 endif

wboot:	lxi	sp,stack
	xra	a
	call	bnksel
	jmp	wboot1

	ds 64
stack	equ $

	ds 32
iostk	equ $
iostkp: dw	$-$

nullsio:
nullpio:
	ei
	reti

	ds	16	;8 levels of stack
intstk: ds	0
istk:	dw	0

tick:	sspd	istk
	lxi	sp,intstk
	push	psw
	push	h
	push	b
	lxi	h,@sec
	inr	m
	lxi	h,tictbl
	mvi	b,numtic
to4:	mov	a,m
	inx	h
	cpi	true
	jz	to3
	mov	a,m
	ora	a
	jrz	to5
	dcr	m
	jrnz	to3
	push	b
	push	d
	push	h
	inx	h
	mov	a,m
	inx	h
	mov	h,m
	mov	l,a
	call	icall
	pop	h
	pop	d
	pop	b
	mov	a,m
	ora	a
	jrnz	to3
to5:	dcx	h
	mvi	m,true
	inx	h
to3:	inx	h
	inx	h
	inx	h
	djnz	to4
too3:
	mvi	c,rtcadr
	inp	b	;save existing rtcadr
	mvi	a,rtcis     ;clear rtc INT flag
	outp	a	    ;
	in	rtcdta	    ;
	outp	b	;restore rtcadr
	pop	b
	pop	h
	pop	psw
	lspd	istk
	ei
	reti	;resets PIO interupt

; Belongs with RTC code, but must be in cseg.
@rtcstr: db	'MM58167 ',0,'RTC Driver ',0,'v3.10'
	dw	vers
	db	'$'

; SEARCH for a module by device #.
;   entry:	C = device # (0-249)
;   exit:	[CY] = not found
;	   else HL=module address ("init" entry)
;		A=device number (relative to module's #0)
;

search: lxi	d,thread	;C=device number
snext:	xchg
	mov	e,m
	inx	h
	mov	d,m
	inx	h
	mov	a,d
	ora	e
	sui	1	;produce [CY] if DE=0000
	rc		;return if device not found, DE=0000
	mov	a,c
	sub	m
	jrc	snext
	inx	h
	cmp	m
	jrnc	snext
	inx	h	;point to "init" vector
	ora	a	;set [NC] condition
	ret

devtbl: lxi	h,@ctbl
	ret

@ctbl:	db	'nodev ',0,0	;character table, filled at cold-start.
	db	'nodev ',0,0
	db	'nodev ',0,0
	db	'nodev ',0,0
	db	'nodev ',0,0
	db	'nodev ',0,0
	db	'nodev ',0,0
	db	'nodev ',0,0
	db	0	;table terminator

cdtbl:	rept 8		;character device table, filled at cold-start.
	dw cnull
	endm

cnull:	jmp	null	;init
	jmp	nulli	;input status
	jmp	nulli	;input
	jmp	nulli	;output status
	jmp	null	;output

nulli:	mvi	a,1ah	;E.O.F. character, also [NZ] to be always ready.
	ora	a	;sets [NZ] condition.
null:	ret

; Calls char module INIT with B=dev num (0-11)
cinit:	mov	e,c	;C=device number (0-11)
	bit	3,c	;devices 8-11?
	rnz		;cannot init those
	mvi	d,0	;C=device number (0-7)
	slar	e	;*2 for table index
	lxi	h,cdtbl
	dad	d  
	mov	e,m
	inx	h
	mov	d,m
	mov	b,c
	xchg
	pchl		;jump to modules "init" with B=device #

const:
	lhld	@civec	; get console input bit vector
	jr	ist$scan0

auxist:
	lhld @aivec	; get aux input bit vector
ist$scan0:
	call	swtosys
	lxi	d,xitusr
	push	d
ist$scan:
	lxi	d,cdtbl
	mvi	b,0
cis$next:
	slar	h	; check next bit
	jnc is0
	mvi a,3 	; assume device not ready
	call indjmp1	; check status for this device
	ora a ! rnz	; if any ready, return true
is0:	inx	d
	inx	d
	inr	b
	mov a,h ! ora a ; see if any more selected devices
	jrnz cis$next
	xra a		; all selected were not ready, return false
	ret

conin:
	lhld	@civec
	jr	in$scan0

auxin:
	lhld	@aivec
in$scan0:
	call	swtosys
in$scan:
	push	h
	call	ist$scan	;see if there is a character ready
	pop	h
	ora	a
	jrz	in$scan ;wait untill one is ready.
	mvi	a,6
	call	indjmp	;get character
	jr	xitusr

conout: 
	lhld	@covec	; fetch console output bit vector
	jr	out$scan0

auxout:
	lhld	@aovec	; fetch aux output bit vector
	jr	out$scan0

list:
	lhld	@lovec	; fetch list output bit vector
out$scan0:
	call	swtosys
out$scan:
	lxi	d,cdtbl
	mvi	b,0
co$next:
	slar	h	; shift out next bit
	mvi	a,12
	cc	indjmp1
	inx	d
	inx	d
	inr	b
	mov a,h ! ora a ; see if any devices left
	jrnz	co$next ; and go find them...
	jr	xitusr
  
conost:
	lhld	@covec	; get console output bit vector
	jr	ost$scan0

auxost:
	lhld	@aovec	; get aux output bit vector
	jr	ost$scan0

listst:
	lhld	@lovec	; get list output bit vector
ost$scan0:
	call	swtosys
ost$scan:
	lxi	d,cdtbl
	mvi	b,0	;B = device number
cos$next:
	slar	h	; check next bit
	mvi a,9 	; [NZ] will assume device ready (in case no call made)
	cc	indjmp1 ; check status for this device
	ora a		; see if device ready
	jrz	xitusr	; if any not ready, return false
	inx	d
	inx	d
	inr	b
	mov a,h ! ora a ; see if any more selected devices
	jrnz cos$next
	ori	true	; if all selected were ready, return true
;	jr	xitusr

xitusr: mov	b,a
	pop	psw
	ora	a
	jrz	xu0
	call	bnksel	;preserves BC.
	lspd	iostkp
xu0:	mov	a,b
	ora	a
	ret

swtosys:
	pop	d	;routine return address
	lda	@cbnk
	ora	a
	jrz	sw0
	sspd	iostkp
	lxi	sp,iostk
	push	psw
	xra	a
	call	bnksel
	pop	psw
sw0:	push	psw
	push	d
	ret 

indjmp1:
	push	h
	push	d
	push	b
	call	indjmp
	pop	b
	pop	d
	pop	h
	ret

indjmp: xchg
	add	m	;a=0,3,6,9,12,...
	mov	e,a
	mvi	a,0
	inx	h
	adc	m
	mov	d,a
	xchg
	pchl		;indirect call

addjmp: add	l	;a=0,3,6,9,...
	mov	l,a
	mvi	a,0
	adc	h
	mov	h,a
icall:	pchl		;indirect call

@memstr: db	'256K ',0,'Kaypro RAM MMU ',0,'v3.10'
	dw	vers
	db	'$'
bnksel:
	sta	@cbnk	; remember current bank
	push	b
	mov	b,a
	add	a
	add	a
	ora	b
	ori	compag
	out	mmu
	pop	b
	ret

timex:		;time get/set.
	sded	savede
	call	swtosys ;destroys DE
	push	h
	call	gett
	pop	h
	lded	savede
	jmp	xitusr

savede: ds	2

xmove:
	mov	a,b	;WR bnk
	add	a
	add	a
	ora	c	;RD bnk
	ori	compag
	sta	xmbnk
	ret

xmbnk:	ds	1

move:	lda	xmbnk
	ora	a
	jrz	xxm0
	out	mmu
xxm0:	xchg
	ldir
	xchg
	ora	a	;test xmbnk again
	lda	@cbnk
	cnz	bnksel
	xra	a
	sta	xmbnk
	ret

@cbnk:	db	0		; bank for processor operations

signon: db	13,10,7,'KAYPRO CP/M 3.10'
	dw	vers
	db	' (c) 1985 DRI and DRM',13,10,'$'

ccp$msg db	13,10,7,'No CCP$'

ccprecs db	0

ccp$com db	1,'CCP     COM',0,0,0,0
	ds	16
fcb$nr	db	0,0,0,0

tictbl: db	true,0
	dw	$-$
	db	true,0
	dw	$-$
numtic equ ($-tictbl)/4

;must be at end of all "cseg" code.
thread	equ	$

	dseg	; this part can be banked
@login: ds	2	;position is assumed by special BNKBDOS3.SPR...
			; must be first item in DSEG.

hlast:	dw	hstart
hleft:	dw	bnktop-hstart

boot:	lxi	sp,stack
	lxi	h,@vect
	mov	a,h
	stai
	im2
; Verify that we have banked RAM...
; init PIO,RTC and tick interupt
	call	clrpio	;reset any PIO interupts pending
	mvi	a,11$001111b	;bit control mode
	out	pioActl
	mvi	a,11000000b	;7,6 inputs
	out	pioActl
	lxi	h,piovec+0	;bit-0 of vector must be 0
	mov	a,l
	out	pioActl
	mvi	a,1011$0111b	;EI, OR, HI, mask follows
	out	pioActl 	;
	mvi	a,10111111b	;bit 6 only
	out	pioActl
	lxi	h,tick
	shld	piovec+0
	mvi	a,rtcis
	out	rtcadr
	in	rtcdta
	mvi	a,rtcic
	out	rtcadr
	mvi	a,00000100b	;enable INT on 1-second interval
	out	rtcdta
;
	mvi	a,01$001111b	;input mode
	out	pioBctl
	mvi	a,0000$0111b	;no interupts
	out	pioBctl
	mvi	a,01001010b
	out	pioBdat
	lxi	h,piovec+2
	mov	a,l
	out	pioBctl
;
	mvi	a,2
	out	sio1ctlB
	out	sio2ctlB
	lxi	h,sio1vec
	mov	a,l
	out	sio1ctlB
	lxi	h,sio2vec
	mov	a,l
	out	sio2ctlB
	ei
; Initialize all modules and build tables.
	lxi	h,thread	;thread our way through the modules,
in0:	mov	e,m		;initializing as we go.
	inx	h
	mov	d,m	;next module, or "0000" if we're past the end.
	inx	h
	mov	a,d
	ora	e
	jz	init$done
	mov	a,m	;device base number
	inx	h
	inx	h	;thread+4 = init entry (JMP)
	sui	200	;if Char I/O module, build entry(s) in tables.
	jc	notchr
	push	d	;save NEXT module address
	mov	c,a
	mvi	b,0
	dcx	h
	mov	a,m	;number of devices
	inx	h
	xchg		;DE=init entry point
	lxi	h,cdtbl
	dad	b
	dad	b
	mov	b,a
	mov	a,c
in1:	cpi	12
	jnc	in4	;if device # overflows, adjust next step.
	mov	m,e		;
	inx	h		;
	mov	m,d		;
	inx	h		;
	inr	a
	djnz	in1
	dcx	d
	ldax	d	;number of devices
in3:	mov	b,a
	mov	a,c	;DE=module address, C=device base
	add	a	; *2
	add	a	; *4
	add	a	; *8
	mov	c,a
	mov	a,b	;number of devices
	mvi	b,0
	lxi	h,@ctbl
	dad	b
	xchg		;DE=@ctbl indexed by device base
	mvi	c,17+1	;B=0 still, point to CHRTBL vector
	dad	b	;point to chrtbl location
	mov	c,m
	inx	h
	mov	h,m
	mov	l,c	;HL=chrtbl
	add	a
	add	a
	add	a	;num.dev * 8 = number of bytes in module's table.
	mov	c,a	;B=0 still
	ldir		;copy modules chrtbl into system table.
in2:	pop	h
	jmp	in0

in4:	sub	c	;compute number of devices that will fit.
	jnz	in3	;continue with initialization of tables
	jmp	in2

notchr: 		;HL point to init entry
	push	d
	call	icall	;"call" (HL)
	pop	h
	jmp	in0

clrpio: call	twice
twice:	reti

init$done:		;all Disk I/O modules are initialized.
	mvi	c,11
in5:	push	b
	call	cinit
	pop	b
	dcr	c
	jp	in5

	lhld	icovec
	shld	@covec	;set console I/O
	lhld	icivec
	shld	@civec	;
	lhld	ilovec
	shld	@lovec	;set list output device
	lhld	iaovec
	shld	@aovec	;set auxiliary I/O device
	lhld	iaivec
	shld	@aivec	;
	lxi	h,defsrc
	lxi	d,@ermde+1	;location of default search chain in SCB
	lxi	b,5
	ldir
	lda	srctyp
	ani	000$11$000b
	mov	c,a
	lda	@civec-10	;location of search type flags in CCP section
	ani	111$00$111b
	ora	c
	sta	@civec-10
	lxi	d,signon
	mvi	c,9
	call	bdose
; was there enough RAM?
	call	set$jumps  ;setup system jumps and put in all banks
; fetch CCP for first time, system will put it in bank 1.
	mvi	a,0feh	;don't try warm boot on error...
	sta	@ermde	;
	lxi	d,ccp$com
	mvi	c,15	;open file
	call	bdose
	inr	a
	jz	noccp
	xra	a
	sta	fcb$nr
	lxi	d,ccp
	mvi	c,26	;set DMA address
	call	bdose
	mvi	e,64	;read upto 64 records (8K)
	mvi	c,44	;set multi-sector count
	call	bdose
	lxi	d,ccp$com
	mvi	c,20	;read record(s)
	call	bdose
	mov	a,h	;H=number of records actually read
	sta	ccprecs
	xra	a	;back to
	sta	@ermde	;default mode for user
	lxi	b,0001h ; save CCP in bank 0 for warm boots.
	call	xmovccp ;NOTE: this restricts banked OS size.
	jmp	goccp	; (allowing 8K for "CCP" and reserving page 0)

wboot1: call	set$jumps	; initialize page zero, selects bank 0
	lxi	b,0100h
	call	xmovccp
	lhld	wbtrap	; allow I/O modules to partake in the warm$boot.
	mov	a,h	;
	ora	l	;
	cnz	icall	;
	jmp	goccp

xmovccp:
	call	xmove
	lda	ccprecs
	mov	b,a
	mvi	c,0
	srlr	b
	rarr	c	;BC=number of bytes in CCP
	lxi	h,ccp
	lxi	d,ccp
	jmp	move

set$jumps:
	mvi a,(JMP)
	sta cpm ! sta bdos	; set up jumps in page zero
	lxi h,BIOS$0+3 ! shld cpm+1	; BIOS warm start entry
	lhld @mxtpa ! shld bdos+1	; BDOS system call entry
	lxi	b,0100h ;source bank 0, dest bank 1
	call	xmove
	lxi	h,0
	lxi	d,0
	lxi	b,64
	call	move
	lxi	b,0200h ;source bank 0, dest bank 2
	call	xmove
	lxi	h,0
	lxi	d,0
	lxi	b,64
	call	move
	lxi	b,0300h ;source bank 0, dest bank 3
	call	xmove
	lxi	h,0
	lxi	d,0
	lxi	b,64
	jmp	move

?timot: 			; (B)=I.D. (C)=count, (DE)=routine address
	push	d
to1:	mvi	e,numtic
	lxi	h,tictbl
	di
to0:	mov	a,m
	cpi	true
	jrz	to2
	cmp	b
	jrz	to2
	inx	h
	inx	h
	inx	h
	inx	h
	dcr	e
	jrnz	to0
	ei
	mov	a,c	;don't wait if all it wants is to clear a possible
	ora	a	;existing entry, since none exists for that module.
	jrnz	to1	;-- maybe we should "ei hlt" and then jump --
	pop	d
	ret
to2:
	pop	d
	mov	m,b
	inx	h
	mov	m,c
	inx	h
	mov	m,e
	inx	h
	mov	m,d
	ei
	ret

noccp:	lxi	d,ccp$msg
errx:	mvi	c,9
	call	bdose
	di ! hlt

gett:	inr	c	;test for "FF"
	jz	sett	;FF=set time
ti0:	lxi	d,rtcsts+(numrtc shl 8)
	lxi	h,time
	lxi	b,rtcadr+(rtcsec shl 8)
ti1:	outp	b	;select reg
	inr	b
	in	rtcdta
	mov	m,a
	inx	h
	outp	e	;select status reg
	in	rtcdta
	ora	a
	jrnz	ti0
	dcr	d
	jrnz	ti1
	lda	timemon 	;if last accessed month is greater
	lxi	h,lstmnth	;than current month, the year must be
	cmp	m		;changed.
	cc	setyear$1	;assumes 1 year elapsed
	lda	timesec
	sta	@sec
	lda	timemin
	sta	@min
	lda	timehrs
	sta	@hour
	mvi	a,28
	sta	mondays+1	;set February=28
	lda	timeyrs
	call	bcdbin
	mov	b,a
	lda	timecnt
	sui	19h
	mov	a,b
	jrz	ti1@0
	adi	100	;adjust for century
ti1@0:	sui	78	;years since 1978 (base year)
	mov	b,a	;
	inr	a	;adjustment for leap year calc.
	mov	c,a	;
	srlr	c	;
	srlr	c	;divide by 4 = number of leap years (exclusive)
	ani	11b
	cpi	11b	;is this year a leap year?
	jrnz	ti2
	mvi	a,29
	sta	mondays+1	;set february=29
ti2:	lxi	h,0
	lxi	d,365
ti3:	dad	d	;find number of days since 1978
	djnz	ti3
	dad	b	;(B=0) add in 1 day for each leap year
	lda	timedat
	call	bcdbin
	mov	c,a
	mvi	b,0
	dad	b	;add in days of this month
	lda	timemon
	call	bcdbin
	dcr	a	;if January, nothing left to add.
	jrz	ti4
	mov	b,a
	lxi	d,mondays	;add in days of each month upto this.
ti5:	ldax	d
	inx	d
	add	l
	mov	l,a
	mvi	a,0
	adc	h
	mov	h,a
	djnz	ti5
ti4:	shld	@date
	lda	@sec
	ret

sett:	lda	@hour
	sta	timehrs
	lda	@min
	sta	timemin
	lda	@sec
	sta	timesec
	lhld	@date
	lxi	d,365
	mvi	a,28
	sta	mondays+1	;set february=28
	mvi	b,0	;start counting years since 1978
ti6:	mov	a,b	; check for leap year
	ani	11b	;every 4 years,
	xri	10b	;starting with 1980
	jrnz	ti7
	stc		;one extra day for leap years
ti7:	dsbc	d	;does this year fit in @date?
	inr	b	;count a year.
	jrnc	ti6	;yes, keep taking out more days (by years)
	mov	a,b	;is this year a leap year?
	ani	11b
	xri	10b
	jrnz	ti8
	mvi	a,29
	sta	mondays+1	;February=29
	stc
ti8:	dadc	d	;normalize @date (we subtracted one too many)
	dcr	b
	mov	a,b
	adi	78	;adjust year to 1900
	mvi	b,19	;century
	cpi	100
	jrc	ti8@0
	inr	b
	sui	100
ti8@0:	call	binbcd
	sta	timeyrs
	mov	a,b
	call	binbcd
	sta	timecnt
	xchg		;remainder into DE
	mvi	b,1	;start taking out months.
	lxi	h,mondays
ti9:	mov	a,e
	sub	m
	mov	c,a
	mov	a,d
	sbi	0
	jrc	ti10
	mov	e,c
	mov	d,a
	inx	h
	inr	b
	mov	a,b
	cpi	13
	jrc	ti9
ti10:	mov	a,b
	call	binbcd
	sta	timemon
	sta	lstmnth 	;also set last accessed month
	mov	a,e	;left-over must be date of month
	call	binbcd
	sta	timedat
; set day-of-week using Zeller's congruence:
	lda	timeyrs 	;E=([2.6m-.2]+K+D+[D/4]+[C/4]-2C) mod 7
	call	bcdbin		;0=sunday
	mov	d,a
	lda	timemon
	call	bcdbin
	mov	b,d
	sui	2
	jrz	ti11
	jrnc	ti12
ti11:	adi	12
	dcr	b
ti12:	mov	c,a
	add	a
	add	c	;*3
	add	a
	add	a	;*12
	add	c	;*13
	dcr	a
	mvi	c,0
ti13:	inr	c
	sui	5
	jrnc	ti13
	dcr	c
	lda	timedat
	push	b
	call	bcdbin
	pop	b
	add	c	;[2.6m-.2]+K
	add	b	;+D
	srlr	b
	srlr	b	; [D/4]
	add	b	;+[D/4]
	mov	c,a
	lda	timecnt ;century
	call	bcdbin
	mov	b,a
	slar	b	; 2*C
	srlr	a	;;
	srlr	a	; [C/4]
	add	c	;+[C/4]
	sub	b	;-2*C
	mov	c,a
	jp	ti14
	neg
ti14:	mvi	b,0
ti15:	inr	b
	sui	7
	jrz	ti16
	jrnc	ti15
	bit	7,c
	jrnz	ti16
	dcr	b
ti16:	mov	a,b
	add	a
	add	b	;*3
	add	a
	add	b	;*7
	bit	7,c
	jrz	ti17
	neg
ti17:	mov	b,a
	mov	a,c
	sub	b
	inr	a
	sta	timeday
	mvi	a,clrcnt	;
	out	rtcadr		;
	mvi	a,00000011b	;reset fractional seconds
	out	rtcdta	;we now have one second to set time
	mvi	d,numrtc
	lxi	h,time
	lxi	b,rtcadr+(rtcsec shl 8)
ti18:	outp	b	;select reg
	inr	b
	mov	a,m
	out	rtcdta
	inx	h
	dcr	d
	jrnz	ti18
	ret

setyear$1:
	mov	m,a	;set last-month
	dcx	h
	dcx	h
	mov	a,m
	adi	1
	daa
	mov	m,a
	jrnc	sy0
	inx	h
	mov	a,m
	adi	1
	daa
	mov	m,a
	dcx	h
sy0:	mvi	d,3	;3 registers to update
	lxi	b,rtcadr+(rtcyrs shl 8)
	jr	ti18

bcdbin: mov	b,a
	ani	00001111b
	mov	c,a
	mov	a,b
	ani	11110000b
	rrc
	mov	b,a
	rrc
	rrc
	add	b
	add	c
	ret

binbcd: sui	100
	jrnc	binbcd
	adi	100
	mvi	c,0
bb0:	sui	10
	inr	c
	jrnc	bb0
	adi	10
	dcr	c
	slar	c
	slar	c
	slar	c
	slar	c
	ora	c
	ret

mondays: db 31,28,31,30,31,30,31,31,30,31,30,31

time:
timesec: db	0
timemin: db	0
timehrs: db	0
timeday: db	0
timedat: db	0
timemon: db	0
	 db	0	;thousandths of seconds, 4 bits only
timeyrs: db	0
timecnt: db	0
lstmnth: db	0
numrtc equ $-time

getdrv:
	lxi h,@dtbl ! ret

@dtbl:	dw	dnull,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

dnull:	dw 0,0,0,0,0,0,0,0,0,@dircb,@dtacb,0
	db 0

seldsk:
	mov a,c ! sta @adrv			; save drive select code
	lxi	h,@lptbl
	mvi b,0 ! dad b 	      ; create index from drive code
	mov	a,m
	cpi	255
	jrz	selerr
	sta	@pdrv
	mov	c,a
	mov	b,e	;save login flag thru "search" routine
	call	search
	jrc	selerr
	sta	@rdrv
	shld	curmdl
	push	b	;save login bit
	lxi	d,14
	dad	d	;point to dphtbl
	mov	e,m	;DE=dphtbl
	inx	h
	mov	d,m
	inx	h
	mov	c,m	;BC=modtbl
	inx	h
	mov	b,m
	lda	@rdrv
	add	a
	add	a
	add	a	;*8
	mov	l,a
	mvi	h,0
	dad	b	;select mode bytes
	shld	@cmode	;set current mode pointer
	pop	b	;get login bit back.
	bit	0,b	;test for initial select.
	jrnz	notlgi
	xchg		;DE=modes
	mov	c,a
	mvi	b,0
	dad	b	;+*8
	dad	b	;+*16
	dad	b	;+*24
	lda	@rdrv
	mov	c,a
	dad	b	;+*1 = +*25
	shld	@dph
	call	setup$dph
	jrc	selerr
	xra	a
	sta	@rcnfg
	mvi	a,3
	call	calmod	;call module's "login" routine.
	ora	a	;see if an error occured.
	jrnz	selerr
	lda	@rcnfg
	ora	a
	cnz	setup$dph
	jrc	selerr
	lda	@adrv
	add	a
	mov	c,a
	mvi	b,0
	lxi	h,@dtbl
	dad	b
	lded	@dph
	mov	m,e	;set current DPH in @dtbl
	inx	h
	mov	m,d
	jr	selcom	;DE=dph

selerr: lxi	h,0
	ret

notlgi: lda	@adrv
	add	a
	mov	c,a
	mvi	b,0
	lxi	h,@dtbl
	dad	b
	mov	e,m	;get current DPH from @dtbl
	inx	h
	mov	d,m	;DE=dph
	sded	@dph
selcom: lhld	@cmode
	lxi	b,0	;
	bit	7,m	;Tracks-per-side not valid for Hard disks.
	jrnz	selxit
	inx	h
; ;	bit	1,m	;unless its Z17...
; ;	jrz	sc0
; ;	mvi	b,4	;then side 1 has 4 less tracks (8 on DT)
sc0:	mvi	a,40	;assume 5" ST
	inx	h
	bit	7,m	;check 5" drive
	jrz	sc1
	mvi	a,77	;8" drives have 77 tracks
sc1:	mov	c,a	;set side 0 tracks
	sub	b
	mov	b,a
	inx	h	;fix for HT bug
	bit	5,m	;check for DT
	jrz	selxit
	slar	b	;multiply # of tracks by 2 if DT
	slar	c	;
selxit: sbcd	@tps
	lded	@dph
	lxi	h,+12
	dad	d	;point to DPB entry
	mov	c,m
	inx	h
	mov	b,m
	push	b	;save DPB
	ldax	b	;sectors-per-track, byte value
	lxi	h,+15
	dad	b
	mov	b,m	;psh
	inr	b
gh2:	dcr	b
	jz	gh3
	srlr	a
	jr	gh2
gh3:	sta	@pspt	;physical sectors per track
	xchg	;put DPH in (HL) for BDOS
	mov	e,m
	inx	h
	mov	d,m	;DE=sectrn
	dcx	h
	pop	b	;BC=dpb
	ret

setup$dph:
	ora	a	;reset [CY]
	lhld	@cmode	;HL=modes
	bit	7,m	;check for hard-disk drive (modes not standard)
	rnz
	call	?getdp
	stc
	rnz
	lhld	@dph	;restore dph
	mov	m,c	;set XLAT table
	inx	h
	mov	m,b
	lxi	b,12-1
	dad	b	;point to dpb
	mov	c,m	;get DPB addr
	inx	h
	mov	h,m	;(HL=dpb)
	mov	l,c
	xchg
	lxi	b,17
	ldir
	ora	a	;reset [CY]
	ret

; Allocate space from hash pool.
; Does nothing if space exhausted (caller must init for "no hash")
; BC = size of hash, DE = &DPH.HASH
; Preserves BC, A
?halloc:
	lhld	hleft
	ora	a
	dsbc	b
	rc	; no space
	shld	hleft
	lhld	hlast
	xchg
	mov	m,e
	inx	h
	mov	m,d
	inx	h
	mvi	m,hbnk
	xchg
	dad	b
	shld	hlast
	ret

home:	lxi b,0 	; same as set track zero
settrk: sbcd trk
	ret

setsec: sbcd sect
	ret

setdma: sbcd @dma
	lda @cbnk	; default DMA bank is current bank
setbnk: sta @dbnk
	ret

sectrn: mov l,c ! mov h,b
	mov a,d ! ora e ! rz
	xchg ! dad b ! mov l,m ! mvi h,0
	dcx	h	;sectors numbered 0 - (n-1)
	ret

read:	mvi	e,6	;read entry is +6
	jmp rw$common			; use common code

write:	mvi	e,9	;write entry is +9

rw$common:	;do any track/sector/side conversion...
	xra	a
	sta	@side
	lhld	trk
	shld	@trk
	lhld	sect
	shld	@sect
	lhld	@cmode
	bit	7,m	;floppy or hard-disk?
	jrnz	rw0
	inx	h
	inx	h
	inx	h
	bit	6,m	;DS
	jrz	rw0
	mov	a,m
	ani	01110b	;DSALG
	lxi	h,dstbl
	mov	c,a
	mvi	b,0
	dad	b
	mov	c,m
	inx	h
	mov	h,m
	mov	l,c
	call	icall
rw0:	mov	a,e
calmod: lhld	curmdl
	jmp	addjmp			; leap to driver

;;		 0    1    2	 3     4    5	  6	7
dstbl:	dw	wrap,alt1,cont1,cont2,alt2,dsret,dsret,dsret

cont2:	lda	@pspt	;as done by Gnat
	srlr	a	;SPT must be EVEN
	mov	c,a
	lxi	h,@sect
	mov	a,m
	sub	c	;don't change the sector number on side 1
	rc
	mov	c,a	;save for cont1
	jr	side1

cont1:	call	cont2
	rc
	mov	m,c
	ret	;side1 already set

alt1:	lxi	h,@trk
	rarr	m
	mvi	a,0
	ral
	jr	sside

alt2:	call	alt1	;Kaypro
	ora	a		;side 0?
	rz			;yes, done.
	lxi	h,@sect 	;for KAYPRO, sectors on side 1
	lda	@pspt		;are numbered PSPT+1 to PSPT*2.
	add	m		;
	mov	m,a
	ret

wrap:	lbcd	@tps	;B=tracks on side 1, C=tracks on side 0
	lda	@trk	;(for all except Z17, B=C)
	cmp	c
	rc
	neg
	add	c
	add	b
	dcr	a
	sta	@trk
side1:	mvi	a,1
sside:	sta	@side
dsret:	ret

multio: sta @cnt ! ret

flush:	xra a ! ret		; return with no error

@side:	ds	1		; current side of media (floppy only)
@trk:	ds	2		; current track number
@sect:	ds	2		; current sector number
@cnt:	db	0		; record count for multisector transfer
@dbnk:	db	0		; bank for disk DMA operations
@pspt:	ds	1
@tps:	ds	2
@rcnfg: ds	1
trk:	ds	2
sect:	ds	2

@dtacb: dw	dtacb1
@dircb: dw	dircb1

dircb1: db 0ffh ;drive
	db 0,0,0,0,0
	dw 0,0,2100h	;directly after CCP image (max 8K CCP)
	db 0
	dw dircb2

dircb2: db 0ffh ;drive
	db 0,0,0,0,0
	dw 0,0,2500h
	db 0
	dw dircb3

dircb3: db 0ffh ;drive
	db 0,0,0,0,0
	dw 0,0,2900h
	db 0
	dw dircb4

dircb4: db 0ffh ;drive
	db 0,0,0,0,0
	dw 0,0,2d00h	;dir buffers: 2100-3100
	db 0
	dw 0000 ;end of DIR buffers

dtacb1: db 0ffh ;drive
	db 0,0,0,0,0
	dw 0,0,3100h
	db 0
	dw dtacb2

dtacb2: db 0ffh ;drive
	db 0,0,0,0,0
	dw 0,0,3500h
	db 0
	dw dtacb3

dtacb3: db 0ffh ;drive
	db 0,0,0,0,0
	dw 0,0,3900h
	db 0
	dw dtacb4

dtacb4: db 0ffh ;drive
	db 0,0,0,0,0
	dw 0,0,3d00h	;data buffers: 3100-4100
	db 0
	dw 0000 ;end of data buffers

@scrbf	dw	4100h	;scratch buffer 4100-4500

; Max. system space: 4500h to "bnktop", 38K if 8K common.

	end

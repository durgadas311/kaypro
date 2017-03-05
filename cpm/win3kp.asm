vers equ '0a' ; March 1, 2017  19:20  drm  "WIN3KP.ASM"
;*********************************************************
; Winchester Disk I/O module for CP/M 3.1 on KAYPRO
; Copyright (c) 2017 Douglas Miller
;*********************************************************

	MACLIB Z80

	extrn @dph,@rdrv,@side,@trk,@sect,@dma,@dbnk,@dstat
	extrn @dtacb,@dircb,@scrbf,@rcnfg,@cmode
	extrn ?bnksl,?timot,?getdp

false	equ	0
true	equ	not false

; Ports and Constants
sysctl	equ	014h	;winchester disk control bits

dev0	equ	50		; first drive in system
ndev	equ	2		; # of drives is system


;       *********************************************************
;       *                                                       *
;       *       D a t a     D e f i n i t i o n s               *
;       *                                                       *
;       *********************************************************
;
windta  equ     80h	;1002 data port
winpcmp equ     81h	;1002 precomp port
winerr  equ     81h	;1002 error port
winsc   equ     82h	;1002 sector count port
winsec  equ     83h	;1002 sector number port
winlsb  equ     84h	;1002 lsb of cylinder port
winmsb  equ     85h	;1002 msb of cylinder port
winsdh  equ     86h	;1002 size/drive/head port
winstat equ     87h	;1002 status port
wincmd  equ     87h	;1002 command port
;
rstcmd  equ     10h	;1002 restore command
seekcmd equ     70h	;1002 seek command
rdcmd   equ     20h	;1002 read command
wrcmd   equ     30h	;1002 write command
;
wincfg  equ     10100000b	;ecc and sector size bits
nosel   equ     10111000b	;winchester de-select

; TODO: abstract all this to allow other drive types
; ST412 drive parameters (as used by Kaypro):
ncyl	equ	306	; total number of cylinders
lcyl	equ	ncyl-1	; last cylinder number
pcmpcyl equ     ncyl/2	;starting precomp cylinder number
nhed	equ	4
nsec	equ	17
zsec	equ	512
fsec	equ	zsec/128

;--------- Start of Code-producing Source --------------

	cseg		;put only whats necessary in common memory...

	dw	thread
	db	dev0,ndev
	jmp	init$win
	jmp	login$win
	jmp	read$win
	jmp	write$win
	dw	string
	dw	dphtbl,modtbl

string: DB	'KAYPRO ',0,'Winchester Disk Interface ',0,'3.10'
	dw	vers
	db	'$'

; Both partitions use cyls 0-305, but different heads.
; head = (PTN << 1) + (track & 1)
; track >>= 1
modtbl: ; -PTN  LUN--------addr-------------
 DB   10000000b,00000000b,00000000B,00000000B ; 
   db 11111111b,11111111b,11111111b,11111111b
 DB   10000001b,00000000b,00000000B,00000000B ;
   db 11111111b,11111111b,11111111b,11111111b

; currently, both (all) partitions are identical,
; due to head-slice algorithm for partitioning.
dpb0:	dw	nsec*fsec	; SPT
	db	5,01fh,1	; BSH,BSM,EXM
	dw	1125,1023	; DSM,DRM
	db	0ffh,000h	; ALV0
	dw	0,4		; CKS,OFF
	db	2,003h		; PSH, PSM

; Controller is already done by now
win$rw:
	lda	cmdbuf
	ani	010h
	mvi	a,0b2h	; inir
	jrz	nread
	mvi	a,0b3h	; outir
nread:
	sta	here+1
	lda	@dbnk
	call	?bnksl
	lhld	@dma
	lxi	b,windta
	mvi	e,2
here:	inir
	dcr	e
	jrnz	here
	xra	a
	call	?bnksl
	ret

offline	db	0	; fatal error prevents use
cmdbuf	db	0
romid	db	0

thread	equ	$
	dseg

dphtbl:
	dw	0,0,0,0,0,0,dpb0,0,alv0,@dircb,@dtacb,0
	db	0
	dw	0,0,0,0,0,0,dpb0,0,alv1,@dircb,@dtacb,0
	db	0

alv0:	ds	512
alv1:	ds	512

; driver init
init$win:
	xra	a
	sta	offline
	lda	0050h	; gift from loader: ROM id
	sta	romid
	; TODO: move to login code, for each LUN...
	call	winrest
	ret

login$win:
	lda	offline
	ora	a
	rnz	; This should prevent read/write from
		; ever being called
	; TODO: check init flag (per LUN, not partition)
	; and call winrest (anything else?).
	; Could always select LUN and test READY.
	ret

setup$win:
	lhld	@cmode
	mov	a,m	; PTN
	ani	00000011b	; max 4 partitions
	add	a
	mov	b,a	; -----HH-
	inx	h
	mov	a,m	; LUN
	ani	01100000b	; only 4 LUNs, not 8
	rrc
	rrc		; in position for SDH
	ora	b
	mov	b,a	; ---DDHH-
	lda	@trk
	ani	1
	ora	b	; ---DDHHH
	ori	wincfg	; eSSDDHHH
	out	winsdh
	call	winrdy
	rz	; timeout
	mvi	a,pcmpcyl
	out	winpcmp
	; This is horrible, but since 302C ROM does it
	; we also must to keep compatible on disk:
	; if (trk > 7) trk += 4;
	; else if (trk >= 4) trk += (trk - 4);
	; trk >>= 1;
	; putCyl(trk);
	lhld	@trk
	lda	romid
	cpi	'3'
	jrnz	setup2
	mov	a,l
	ani	11111000b
	ora	h
	jrz	setup1
	lxi	d,4
	dad	d
	jr	setup2
setup1:
	mov	a,l
	cpi	4
	jrc	setup2
	sui	4
	add	l
	mov	l,a
setup2:
	ora	a
	rarr	h
	rarr	l
	mov	a,l
	out	winlsb
	mov	a,h
	out	winmsb
	lda	@sect
	out	winsec
	mvi	a,1
	out	winsc
	ora	a
	ret

read$win:
	mvi	a,rdcmd
	sta	cmdbuf
	call	setup$win
	jrz	error	; timeout on READY
	lda	cmdbuf
	out	wincmd
	call	winbusy
	jrz	error	; timeout on BUSY
	in	winstat
	bit	0,a
	jrnz	error	; ERROR set
	bit	3,a
	jrz	error	; no DRQ
	; no more errors from here on...
	call	win$rw	; xfer from common memory...
	xra	a
	ret

write$win:
	mvi	a,wrcmd
	sta	cmdbuf
	call	setup$win
	jrz	error	; timeout on READY
	lda	cmdbuf
	out	wincmd
	lxi	d,0
	mvi	h,3
write1:
	in	winstat
	bit	3,a	; DRQ
	jrnz	write2
	call	timer
	jrnz	write1
	; timeout - no failure here? we'll get error from winbusy?
write2:
	call	win$rw	; xfer from common memory...
	call	winbusy
	jrz	error
	in	winstat
	bit	0,a	; ERROR
	jrnz	error
	xra	a
	ret

error:
	; possible retry...
	; possible recovery - step, restore, etc.
	xra	a
	inr	a
	ret

;
;       WD 1002 interface routines.
;
;       Written by:     T. Hayes
;
;       These routines provide the physical interface between the system
;       and the WD 1002 winchester controller.
;
winrest:
;
;       Reset and restore the winchester disk
;
;       On entry:
;               B contains the configuration byte of the drive to be accessed
;
;       On exit:
;               A and B contain the configuration byte altered as follows:
;                       Bits 2 and 3 will be set if the drive is off line
;                       or reset if the controller is ready
;
;
	in sysctl	;first issue a controller reset
	setb 1,a
	out sysctl
	push psw
;
	mvi h,1		;hold reset for > 50 ms
	lxi d,0
winrest1:
        call    timer
	jrnz winrest1
	pop psw
;
	res 1,a	;select controller (MR off)
	out sysctl
;
	mvi h,3
	lxi d,6000h
winrest11:
	in winstat	;Check busy
	bit 7,a	;
	jrz winrest3	;go on if not busy
;       
        call    timer	;else count down
	jrnz winrest11
;
disable:
	xra	a
	dcr	a
	sta	offline ; disable drive...
        ret	;and return that status to caller

winrest3:
	in winerr	;check for diagnostic errors
	cpi 1	;if error
	jrz winrest31	;ignore "diagnostic only" errrors
;
	ana a	;believe all others
	jrnz disable	;abort if an error shown
;       
winrest31:
	call	winpsel
;
        call    winrdy	;ready wait
	jrnz winrest32
        call    winrdy	;wait for device ready (again?)
	jrz disable	;abort if timed out (twice)
;
winrest32:
	mvi a,rstcmd	;issue the restore command
	out wincmd
;
        call winbusy	;wait for not busy
	jrz disable	;abort if timed out
;
	in winstat	;get device status
;
	bit 0,a	;if there was an error
	jrnz disable	;abort
winrest6:
	xra	a
	sta	offline
        ret	;return that status to caller

;
winpsel:
;
;       WD 1002 physical select routine
;
	; TODO: get LUN from somewhere... (head too?)
	; for now, assume only LUN 0.
;
	xra a
	ori wincfg	;select ecc and sector size options
;
	out winsdh	;and issue the select
        ret		;return to caller

timer:
;
;       General down counter routine
;
;       On entry:
;               HDE are a 24 bit counter
;       On exit:
;               The counter will have been decremented
;               zero is set if the counter is done
;               zero is reset if the counter is not at 000000h
;
;       Typical timings are 25 t states in the loop with an additional
;       overhead of 29 t states in the calling routine.  This assumes
;       that the calling routine is using a call xxx and jr nz,xxxx.
;       This gives a time of 13.5 usec for each iteration of the loop.
;       Times when de goes 0 will be marginally longer but should not
;       be significant.
;
	dcx d
	mov a,d
	ora e
	rnz 
	dcr h
	ret

; TODO: make use of this somehow...
winoff:
;
;       If the 1002 is not at 305, seek track
;       305 then select physical unit 3. It is assumed that
;       the host buffer has been flushed.
;
	in winlsb		;see if the drive is at 305 already
	cpi high lcyl
	jrnz winoff1
	in winmsb
	cpi low lcyl
	jrz winoff2
winoff1:
;
	mvi a,high lcyl
	out winmsb
	mvi a,low lcyl
	out winlsb
;
	mvi a,seekcmd	;now issue a seek to that cylinder
	out wincmd
;
        ret		;return to caller
winoff2:        
	mvi a,nosel	;now deselect the drive
	out winsdh
;
        ret		;and return to caller

winrdy:
;
;       Wait for device ready
;
	mvi h,5
	lxi d,0
winrdy1:
	in winstat		;check for ready
	bit 6,a
	rnz		;return if it is
;
        call    timer	;else count down
	rz		;return if timed out
        jr      winrdy1	;else try again
;
;
winbusy:
;
;       Wait for device not busy
;
	mvi h,7	;set up dead man counter
	lxi d,0
winbusy1:
	in winstat	;get status
	cma
	bit 7,a	;if not busy
	rnz		;return
        call    timer	;else count down
	rz		;and return if timed out
        jr      winbusy1
;
        end

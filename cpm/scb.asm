; System Control Block definitions

	public @civec,@covec,@aivec,@aovec,@lovec
	public @mxtpa,@ermde,@date,@hour,@min,@sec

scb	equ	0fb9ch

@civec	equ	scb+22h
@covec	equ	scb+24h
@aivec	equ	scb+26h
@aovec	equ	scb+28h
@lovec	equ	scb+2ah

@ermde	equ	scb+4bh

@date	equ	scb+58h
@hour	equ	scb+5ah
@min	equ	scb+5bh
@sec	equ	scb+5ch

@mxtpa	equ	scb+62h

	end

VPATH = drm cpnet

all: makehelp help.hlp

HELPS = commands.help \
	cntrlchars.help \
	copysys.help \
	cpnet.help \
	cpnetsts.help \
	date.help \
	device.help \
	dir.help \
	dskreset.help \
	dump.help \
	ed.help \
	erase.help \
	filespec.help \
	gencom.help \
	get.help \
	help.help \
	hexcom.help \
	initdir.help \
	lib.help \
	link.help \
	local.help \
	login.help \
	logoff.help \
	mac.help \
	mode.help \
	netstat.help \
	network.help \
	ntpdate.help \
	patch.help \
	pip.help \
	put.help \
	rename.help \
	rmac.help \
	rsxrm.help \
	save.help \
	set.help \
	setdef.help \
	show.help \
	sid.help \
	submit.help \
	tpa.help \
	tr.help \
	type.help \
	user.help \
	xref.help

help.hlp: $(HELPS)
	cat $^ | unix2dos >help.dat
	./makehelp help.dat >$@
	@echo "If needed, use HELP [CREATE] on CP/M3 to convert help.dat to help.hlp"

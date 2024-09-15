## This is Downloads, a _public_ repo for _managing_ Downloads

current: target
-include target.mk
Ignore = target.mk

# -include makestuff/perl.def

vim_session:
	bash -cl "vmt"

######################################################################

Makefile:

Ignore += dfiles
dfiles.get dfiles.put: cloudFolder=dropbox:Download_files/2407
dfiles: dir=~/Downloads
dfiles: 
	$(linkdirname)

up.time: $(wildcard dfiles/*)
pushup: dfiles.put
pullup: dfiles.get
up.time: $(wildcard Downloads/*)

######################################################################

### Makestuff

Sources += Makefile

Ignore += makestuff
msrepo = https://github.com/dushoff

Makefile: makestuff/00.stamp
makestuff/%.stamp:
	- $(RM) makestuff/*.stamp
	(cd makestuff && $(MAKE) pull) || git clone --depth 1 $(msrepo)/makestuff
	touch $@

-include makestuff/os.mk

## -include makestuff/pipeR.mk

-include makestuff/git.mk
-include makestuff/cloud.mk
-include makestuff/visual.mk

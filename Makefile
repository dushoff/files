## This is Downloads, a _public_ repo for _managing_ Downloads

current: target
-include target.mk
Ignore = target.mk

# -include makestuff/perl.def

vim_session:
	bash -cl "vmt"

######################################################################

Makefile:

Downloads.get Downloads.put: cloudFolder=dropbox:Download_files/2407
Downloads: dir=~/
Downloads: 
	$(linkdir)

up.time: $(wildcard Downloads/*)
pushup: Downloads.put
pullup: Downloads.get

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

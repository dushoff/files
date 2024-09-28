## This is Downloads, a _public_ repo for _managing_ Downloads

current: target
-include target.mk
Ignore = target.mk

# -include makestuff/perl.def

vim_session:
	bash -cl "vmt"

######################################################################

Ignore += dfiles
dfiles.get dfiles.put: cloudFolder=macdrive_root:cloud/Downloads2409/
dfiles: dir=~/Downloads
dfiles: 
	$(linkdirname)

######################################################################

Stelmach_form.signed.pdf: Stelmach_form.print.pdf formDrop/jsig.30.pdf Makefile
	pdfjam $< 2 -o /dev/stdout | \
	cpdf -stamp-on $(word 2, $^) -pos-left "420 330" \
		-stdin -stdout | \
	pdfjam $< 1 /dev/stdin 1 $< 3-4 -o /dev/stdout | \
	cat > $@

Sources += content.mk

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

-include makestuff/forms.mk

-include makestuff/git.mk
-include makestuff/cloud.mk
-include makestuff/visual.mk

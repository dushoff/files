## This is files, a _public_ repo for managing files

current: target
-include target.mk
Ignore = target.mk

# -include makestuff/perl.def

vim_session:
	bash -cl "vmt"

######################################################################

Makefile: | Downloads
Ignore += Downloads
Downloads: dir=~
Downloads:
	$(linkdir)

######################################################################

Ignore += *.pdf

######################################################################

## https://vote.phila.gov/voting/vote-by-mail/umova-notice/
fpca2013jd.signed.pdf: Downloads/fpca2013jd.print.pdf formDrop/jsig.25.pdf
	pdfjam $< 1 -o /dev/stdout | \
	cpdf -stamp-on $(word 2, $^) -pos-left "240 75" \
		-stdin -stdout | \
	cat > $@

## https://vote.phila.gov/voting/vote-by-mail/umova-notice/
fpca2013cfs.signed.pdf: Downloads/fpca2013cfs.print.pdf formDrop/csig.25.pdf
	pdfjam $< 1 -o /dev/stdout | \
	cpdf -stamp-on $(word 2, $^) -pos-left "240 75" \
		-stdin -stdout | \
	cat > $@

Stelmach_form.signed.pdf: Stelmach_form.print.pdf formDrop/jsig.30.pdf
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

Makefile: makestuff/01.stamp
makestuff/%.stamp:
	- $(RM) makestuff/*.stamp
	(cd makestuff && $(MAKE) pull) || git clone --depth 1 $(msrepo)/makestuff
	touch $@

-include makestuff/os.mk

-include makestuff/forms.mk

-include makestuff/git.mk
-include makestuff/cloud.mk
-include makestuff/visual.mk

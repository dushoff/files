## This is files, a _public_ repo for managing files

current: target
-include target.mk
Ignore = target.mk

# -include makestuff/perl.def

vim_session:
	bash -cl "vmt"

######################################################################

## Don't mirror anything from here; put things into directories mirrored from elsewhere

Downloads/%: | Downloads ;
Ignore += Downloads
Downloads: dir=~
Downloads:
	$(linkdir)

mirrors += cloud

######################################################################

Ignore += *.pdf

######################################################################

turkey.jpg: Downloads

######################################################################

pcloud/%: | pcloud ;
Ignore += pcloud
pcloud: dir=~/screens/org/Planning/cloud
pcloud:
	$(linkdirname)

######################################################################

Ignore += *.pdf *.png *.jpg

######################################################################

## Too tall to be a FB profile
turkey.jpg: pcloud/turkey.jpg Makefile
	convert -crop 960x720+500+080 $< $@

## Voting 2024

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

absentee_sticker.pdf: Downloads/jdAbsentee.print.pdf
	pdfjam -o $@ $< 6
absentee_sticker.png: absentee_sticker.pdf Makefile
	convert -crop 300x300 $< $@

######################################################################

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

Makefile: makestuff/02.stamp
makestuff/%.stamp:
	- $(RM) makestuff/*.stamp
	(cd makestuff && $(MAKE) pull) || git clone --depth 1 $(msrepo)/makestuff
	touch $@

-include makestuff/os.mk

-include makestuff/forms.mk

-include makestuff/git.mk
-include makestuff/visual.mk

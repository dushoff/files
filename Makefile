## This is files, a _public_ repo for managing files

current: target
-include target.mk
Ignore = target.mk

# -include makestuff/perl.def

vim_session:
	bash -cl "vmt"

test.md:
	pandoc -o $@ Downloads/*.docx

######################################################################

## Don't mirror anything from here; put things into directories mirrored from elsewhere

Downloads/%: | Downloads ;
Ignore += Downloads
Downloads: dir=~
Downloads:
	$(linkdir)

mirrors += cloud

######################################################################

## This breaks things like .go ... use a Makefile dependency or what?
## pcloud/%: | pcloud ;
Ignore += pcloud
pcloud: dir=~/screens/org/Planning/cloud
pcloud:
	$(linkdirname)

######################################################################

Ignore += *.pdf *.png *.jpg

######################################################################

## Too tall to be a FB profile
turkey.jpg: pcloud/turkey.jpg
	convert -crop 960x720+500+080 $< $@

######################################################################

pcloud/durrantReferral.pdf: cloud/durrantReferral.pdf formDrop/jsig.30.pdf Makefile
	pdfjam $< -o /dev/stdout | \
	cpdf -stamp-on $(word 2, $^) -pos-left "80 360" \
		-stdin -stdout | \
	cat > $@

######################################################################

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

## cloud/hutchCurrent.pdf
hutchCurrent.pdf: cloud/hutchCurrent.print.pdf formDrop/jsig.30.pdf Makefile
	pdfjam $< 1 -o /dev/stdout | \
	cpdf -stamp-on $(word 2, $^) -pos-left "155 272" \
		-stdin -stdout | \
	cat > $@

W9.signed.pdf: cloud/W9.print.pdf formDrop/jsig.30.pdf date_1.2.pdf
	pdfjam $< 1 -o /dev/stdout | \
	cpdf -stamp-on $(word 2, $^) -pos-left "155 255" \
		-stdin -stdout | \
	cpdf -stamp-on $(word 3, $^) -pos-left "315 -670" \
		-stdin -stdout | \
	cat > $@

## UMD_wire.pdf: Makefile
UMD_wire.pdf: cloud/UMD_wire.print.pdf formDrop/jsig.30.pdf date_1.2.pdf name_1.2.pdf
	pdfjam $< 1 -o /dev/stdout | \
	cpdf -stamp-on $(word 2, $^) -pos-left "310  105" \
		-stdin -stdout | \
	cpdf -stamp-on $(word 3, $^) -pos-left "335 -820" \
		-stdin -stdout | \
	cpdf -stamp-on $(word 4, $^) -pos-left "115 -820" \
		-stdin -stdout | \
	cat > $@

UMD_sub.pdf: W9.signed.pdf UMD_wire.pdf
	$(pdfdog)

Stelmach_form.signed.pdf: Stelmach_form.print.pdf formDrop/jsig.30.pdf
	pdfjam $< 2 -o /dev/stdout | \
	cpdf -stamp-on $(word 2, $^) -pos-left "420 330" \
		-stdin -stdout | \
	pdfjam $< 1 /dev/stdin 1 $< 3-4 -o /dev/stdout | \
	cat > $@

## This is the old Downloads Makefile I guess
Sources += content.mk

## This is probably also the right place for the Makefile that lives in ~/Downloads; accumulate stuff first and them make some sort of link rule
Sources += Downloads.mk

Downloads/Makefile: fake
	cd $(dir $@) && ln -fs $(CURDIR)/Downloads.mk $(notdir $@)
fake: ;

######################################################################

### Makestuff

Sources += Makefile

Ignore += makestuff
msrepo = https://github.com/dushoff

Makefile: makestuff/03.stamp
makestuff/%.stamp:
	- $(RM) makestuff/*.stamp
	(cd makestuff && $(MAKE) pull) || git clone --depth 1 $(msrepo)/makestuff
	touch $@

-include makestuff/os.mk

-include makestuff/forms.mk
-include makestuff/mirror.mk

-include makestuff/git.mk
-include makestuff/visual.mk

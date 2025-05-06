## This is files, a _public_ repo for managing files

current: target
-include target.mk
Ignore = target.mk
## Figure out how to filter this out from wildcard below

-include makestuff/perl.def

vim_session:
	bash -cl "vmt"

test.md:
	pandoc -o $@ Downloads/*.docx

######################################################################

## lpr.pdf from elsewhere to here
## print.pdf stay in place

## Don't mirror anything from here; put things into directories mirrored from elsewhere …

## This breaks Downloads.*go – not order-dependent, deep makinessH
## Downloads/%: | Downloads ;
Makefile: | Downloads
Ignore += Downloads
Downloads: dir=~
Downloads:
	$(linkdir)

## Haven't quite kept this up, and not sure why it matters
mirrors += cloud

######################################################################

## This breaks things like .go ... use a Makefile dependency or what?
## Or don't make things there from here??
## pcloud/%: | pcloud ;
Ignore += pcloud
pcloud: dir=~/screens/org/Planning/cloud
pcloud:
	$(linkdirname)

stash/%: | stash ;
Ignore += stash
stash: dir=~/screens/org/Planning/stash
stash:
	$(linkdirname)

######################################################################

Ignore += *.pdf *.png *.jpg

######################################################################

## Current

hiring.lpr.pdf: Downloads/hiring.pdf

######################################################################

## Compile reimbursement requests

pdaRequest.pdf: pdaRequest.lpr.pdf
	pdfjam -o $@ $< 1
Downloads/pdaRequest.pdf: pdaRequest.print.pdf stash/pdaNarrative.pdf stash/entertainment.pdf stash/phoenixForm.pdf
	$(pdfcat)

## Downloads/memEligible.print.pdf:

######################################################################

## Too tall to be a FB profile
turkey.jpg: pcloud/turkey.jpg
	convert -crop 960x720+500+080 $< $@

######################################################################

Sources += signing.md

## Signing
Downloads/SFUF300.pdf: Makefile
Downloads/SFUF300.pdf: cloud/SFUF300.pdf formDrop/jsig.30.pdf date_1.2.pdf
	pdfjam $< 1 -o /dev/stdout | \
	cpdf -stamp-on $(word 2, $^) -pos-left "50  160" \
		-stdin -stdout | \
	cpdf -stamp-on $(word 3, $^) -pos-left "10 -820" \
		-stdin -stdout | \
	cat > $@

jezreelTransfer.sig.pdf: stash/jezreelTransfer.print.pdf formDrop/jsig.30.pdf Makefile
	pdfjam $< 2 -o /dev/stdout | \
	cpdf -stamp-on $(word 2, $^) -pos-left "270 190" \
		-stdin -stdout | \
	cat > $@

jezreelTransfer.pages.pdf: stash/jezreelTransfer.print.pdf jezreelTransfer.sig.pdf Makefile
	pdfjam -o $@ $< 1 $(word 2, $^)

pcloud/durrantReferral.pdf: cloud/durrantReferral.pdf formDrop/jsig.30.pdf
	pdfjam $< -o /dev/stdout | \
	cpdf -stamp-on $(word 2, $^) -pos-left "80 360" \
		-stdin -stdout | \
	cat > $@

Downloads/dongXuanFinal.sig.pdf: pcloud/dongXuan.pdf formDrop/jsig.30.pdf
	pdfjam $< 4 -o /dev/stdout | \
	cpdf -stamp-on $(word 2, $^) -pos-left "110 245" \
		-stdin -stdout | \
	cat > $@

Downloads/hkuEFT.pdf: pcloud/hkuEFT.print.pdf formDrop/jsig.30.pdf Makefile
	pdfjam $< -o /dev/stdout | \
	cpdf -stamp-on $(word 2, $^) -pos-left "117 167" \
		-stdin -stdout | \
	cat > $@

Downloads/mckeeFirst.signed.pdf: Downloads/mckeeFirst.print.pdf formDrop/jsig.30.pdf Makefile
	pdfjam $< -o /dev/stdout | \
	cpdf -stamp-on $(word 2, $^) -pos-left "400 257" \
		-stdin -stdout | \
	cat > $@

Downloads/HutchLabGrade.pdf: cloud/HutchLabGrade.print.pdf formDrop/jsig.30.pdf
	pdfjam $< -o /dev/stdout | \
	cpdf -stamp-on $(word 2, $^) -pos-left "150 275" \
		-stdin -stdout | \
	cat > $@

######################################################################

## Playing

Sources += size.txt
size.pdf: size.txt Makefile
	pdfroff $< > $@

######################################################################

## ll.left.jpg: ll.jpg

%.left.jpg: %.jpg
	convert -rotate 270 $< $@

%.right.jpg: %.jpg
	convert -rotate 90 $< $@ 

mmedFlyer.jpg: stash/mmedFlyer.pdf Makefile

mmedFlyer.png: stash/mmedFlyer.pdf Makefile
	convert -density 400 -trim -quality 95 -sharpen 0x1.0 $< $@
	## convert $< $@

######################################################################

## alpine etc.

Sources += $(wildcard *.R)

## contacts.Rout.tsv: contacts.R Downloads/contacts.csv
contacts.Rout: contacts.R Downloads/contacts.csv
	$(pipeR)

Ignore += contacts.txt
contacts.txt: contacts.Rout.tsv contacts.pl
	$(PUSH)

######################################################################

brinForm.signed.pdf: pcloud/brinForm.pdf.pdf formDrop/jsig.30.pdf
	pdfjam $< 1 -o /dev/stdout | \
	cpdf -stamp-on $(word 2, $^) -pos-left "155 110" \
		-stdin -stdout | \
	cat > $@

brinReimburse.pdf: brinForm.signed.pdf pcloud/unitedBrin.pdf 
	$(pdfdog)

######################################################################

Ignore += name.txt X.txt

## cloud/hutchCurrent.pdf (gD here)
hutchCurrent.pdf: cloud/hutchCurrent.print.pdf formDrop/jsig.30.pdf Makefile
	pdfjam $< 1 -o /dev/stdout | \
	cpdf -stamp-on $(word 2, $^) -pos-left "365 262" \
		-stdin -stdout | \
	cat > $@

W9.signed.pdf: cloud/W9.print.pdf formDrop/jsig.30.pdf date_1.2.pdf
	pdfjam $< 1 -o /dev/stdout | \
	cpdf -stamp-on $(word 2, $^) -pos-left "155 255" \
		-stdin -stdout | \
	cpdf -stamp-on $(word 3, $^) -pos-left "315 -670" \
		-stdin -stdout | \
	cat > $@

UMD_wire.pdf: cloud/UMD_wire.print.pdf formDrop/jsig.30.pdf date_1.2.pdf name_1.2.pdf
	pdfjam $< 1 -o /dev/stdout | \
	cpdf -stamp-on $(word 2, $^) -pos-left "310  105" \
		-stdin -stdout | \
	cpdf -stamp-on $(word 3, $^) -pos-left "335 -820" \
		-stdin -stdout | \
	cpdf -stamp-on $(word 4, $^) -pos-left "115 -820" \
		-stdin -stdout | \
	cat > $@

Ignore += *.out
Ignore += GammaPowerLaw.bib
GammaPowerLaw.pdf: cloud/GammaPowerLaw.tex
	$(RUNLatex)

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

Sources += $(filter-out target.mk, $(wildcard *.mk))

prompt:

-include dongxuan.mk

Downloads/Makefile: fake
	cd $(dir $@) && ln -fs $(CURDIR)/Downloads.mk $(notdir $@)
fake: ;

## If we want to take stuff directly from pcloud (or maybe stash?)
## To use a local file, use .print instead (from forms.mk)
%.lpr.pdf: pcloud/%.pdf | ~/PDF
	$(cups_print)

%.lpr.pdf: Downloads/%.pdf | ~/PDF
	$(cups_print)

%.lpr.pdf: stash/%.pdf | ~/PDF
	$(cups_print)

%.lpr.pdf: cloud/%.pdf | ~/PDF
	$(cups_print)

######################################################################

### Makestuff

Sources += Makefile

Ignore += makestuff
msrepo = https://github.com/dushoff

Makefile: makestuff/04.stamp
makestuff/%.stamp:
	- $(RM) makestuff/*.stamp
	(cd makestuff && $(MAKE) pull) || git clone --depth 1 $(msrepo)/makestuff
	touch $@

-include makestuff/os.mk

-include makestuff/forms.mk
-include makestuff/mirror.mk
-include makestuff/texj.mk
-include makestuff/pipeR.mk

-include makestuff/git.mk
-include makestuff/visual.mk

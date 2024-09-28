## Downloads Makefile
## This Downloads Makefile is a Dropbox file
## Not revision-controlled anymore 2024 Jul 09 (Tue)

######################################################################

current:

runscreen: ;

######################################################################

Stelmach_form.lpr.pdf: Stelmach_form.pdf

## gradinstructions.doc.md: gradinstructions.docx
## chooser.docx.html: chooser.docx
%.docx.html: %.docx
	$(pandocs)

%.docx.md: %.docx
	$(pandocs)

######################################################################

current: update_copies quote_names
-include target.mk

vim_session: 
	bash -cl "vmt"

update_copies: .
	rename -f "s/ *\([0-9]\)//" *\([0-9]\).*
	touch $@

quote_names:
	rename -f "s/'//" *.*

list_conflicts:
	ls *confl*

remove_conflicts:
	$(RM) *confl*

######################################################################

## EPL service
## https://www.espn.com/soccer/standings/_/league/eng.1

jiefuLunch.send.jpg: jiefuLunch.jpg Makefile
	convert -crop 1024x1024+412+57 $< $@

treeHeight.right.jpg: treeHeight.jpg
	convert -rotate 270 $< $@

treeHeight.left.jpg: treeHeight.jpg
	convert -rotate 90 $< $@ 

eBalance.right.jpg: eBalance.jpeg
	convert -rotate 270 $< $@ 

eBalance.left.jpg: eBalance.jpeg
	convert -rotate 90 $< $@ 

######################################################################

## Collating pages
SU_FCOI.sig.pdf: SU_FCOI.lpr.pdf formDrop/jsig.30.pdf
	pdfjam $< 1 -o /dev/stdout | \
	cpdf -stamp-on $(word 2, $^) -pos-left "420 10" \
		-stdin -stdout | \
	cat > $@

SU_FCOI.signed.pdf: SU_FCOI.lpr.pdf SU_FCOI.sig.pdf Makefile
	pdfjam -o $@ $(word 2, $^) 1 $< 2- 

## Sig and Date
reinerConflict.signed.pdf: reinerConflict.lpr.pdf formDrop/jsig.30.pdf date_1.2.pdf
	pdfjam $< -o /dev/stdout | \
	cpdf -stamp-on $(word 2, $^) -pos-left "72 112" \
		-stdin -stdout | \
	cpdf -stamp-on $(word 3, $^) -pos-left "350 -820" \
		-stdin -stdout | \
	cat > $@

onePage.sign_date.pdf: onePage.pdf formDrop/jsig.30.pdf date_1.2.pdf Makefile
	pdfjam $< -o /dev/stdout | \
	cpdf -stamp-on $(word 2, $^) -pos-left "155 230" \
		-stdin -stdout | \
	cpdf -stamp-on $(word 3, $^) -pos-left "315 -695" \
		-stdin -stdout | \
	cat > $@

######################################################################

DushoffWire.signed.pdf: DushoffWire.lpr.pdf formDrop/jsig.30.pdf date_1.3.pdf
	pdfjam $< 1 -o /dev/stdout | \
	cpdf -stamp-on $(word 2, $^) -pos-left "130 68" \
		-stdin -stdout | \
	cpdf -stamp-on $(word 3, $^) -pos-left "240 -938" \
		-stdin -stdout | \
	cat > $@

######################################################################

## ~ files made by manual printing
## See something about loading drivers or something? In linux_setup?
hargrove_budget.pdf: ~/hargrove_sheets.pdf ~/hargrove_sig.pdf
	pdfjam --landscape -o $@ $(word 2, $^) 1 $< 2-

## This at least worked on fiVe 2023 Jun 14 (Wed)
%.lpr.pdf: %.pdf
	lpr -P PDF < $<
	sleep 2
	$(MV) ~/PDF/*.* $@

%.lpr.pdf: %.png
	lpr -P PDF < $<
	sleep 2
	$(MV) ~/PDF/*.* $@

######################################################################

## With page split/joins

test.big.pdf: date.txt
	groff -Tpdf $< > $@

test.small.pdf: test.big.pdf
	cpdf -crop "0.9in 10.8in 0.9in 0.2in" $< -o $@ 

######################################################################

abx.bw.jpg: abx.jpg
	convert $< -threshold 45% $@

######################################################################

htmldirs = $(wildcard *_files)
hdirzip: $(htmldirs:_files=.html.tgz)
%.html.tgz:
	tar czf $@ $*.html $*_files
	$(RMR) $*.html $*_files

%.dir.tgz:
	tar czf $@ $*
	$(RMR) $*

######################################################################

## go thanksgivingphotos.zipdir ##
rephotos.zipdir:
papstTut.zipdir:
hkguanyin.zipdir:

sevens.crop.jpg: sevens.jpg
	convert -crop 1350x500+100+735 $< $@

jdoldsquare.jpg: jdoldhead.jpg
	convert -crop 1500x1500+460+135 $< $@

pr.jpg: prbig.jpg
	convert -crop 2000x2800+444+112 $< $@

jdhead.jpg: jdprof.jpg
	convert -crop 1300x1000+860+150 $< $@

##################################################################

## Try to get sound from the dancing babies video
# ffmpeg -i PA090140.avi -vn -acodec copy jump.aac

## Cribbing
olddir = /home/dushoff/Dropbox/Download_files/2301/
%: $(olddir)/%
	$(copy)

######################################################################

## Process downloaded zip files of pdfs

## This seems better; make last zipfile into a single pdf
## olumide.lz.pdf: olumide.zip

## Does this chain right? 2023 Feb 13 (Mon)
## idrc.zipdir: idrc.zip
## idrc.zipdir.empty: idrc.zip
## hoiResource.zipdir.empty: hoiResource.zip
## mcheck.zipdir:
%.zipdir: %.zip | zips
	mkdir $@
	$(MAKE) $*.zipadd
	mv $@ zips/$*

zips:
	$(mkdir)

%.zipadd:
	cp `ls -t *.zip | head -1` $*.zipdir
	cd $*.zipdir && unzip *.zip && $(RM) *.zip

## Move files up to current directory
%.up:
	touch $*/*
	mv $*/* .
	rmdir $*

##################################################################

## Make zipdir and combined pdf
%.lz.pdf: %.zipdir
	pdfjam -o $@ $</*.pdf

## convergence.lz.pdf: convergence.zip

##################################################################

# Some extra rules

hagaddah-book.pdf:
%-book.pdf: %.pdf Makefile; pdfbook2 $<

######################################################################

## Some image examples

## Trivial (crop for MOm)
jacob.jpg: 30.jpg
	convert -crop 600x1200+0+0 $< $@

## Color adjustment

nCoV.png: China_corona.png
	convert -scale 80% -colorspace Gray -modulate 111 -crop 750x550+8+50 $< $@

tuna.jpg: tuna-school.jpg
	convert $< -modulate 222 $@

## Backgrounds
image.jpg: image.png
	convert $< -background white -alpha remove $@

## Rotation

## pdfjam --landscape when needed
WallisMH.pdf: scan0001.pdf 
	pdfjam $< --angle 180 -o $@

jd_init.jpg: init.jpg
	convert $< -rotate 270 $@

phys1.jpg: phys1.jpeg
	convert $< -rotate 270 $@

phys2.jpg: phys2.jpeg
	convert $< -rotate 270 $@

## Highlighting

tulio.highlight.png: tulio.png 
	convert -region 400x50+165+550 +level-colors black,gold $< $@

moveon.highlight.png: moveon.png
	convert -region 275x10+815+380 +level-colors black,gold $< $@

######################################################################

## Signing

up_date:

sign: jsig.jpg
	touch $<

## Multiply 800 by date size for range of starting negative offset? Maybe?
date_100.pdf:

rutgers_trans.pdf: reference.pdf formDrop/jsig.100.pdf date_2.0.pdf 
	cat $< | \
	cpdf -stamp-on $(word 2, $^) -pos-left "50 228" \
		-stdin -stdout | \
	cpdf -stamp-on $(word 3, $^) -pos-left "260 -1330" \
		-stdin -stdout | \
	cpdf -stamp-on $(word 3, $^) -pos-left "260 -1400" \
		-stdin -stdout | \
	cat > $@

ccsign.pdf: cc.pdf formDrop/csig.40.pdf date_2.0.pdf 
	pdfjam $< 4 -o /dev/stdout | \
	cpdf -stamp-on $(word 2, $^) -pos-left "120 120" \
		-stdin -stdout | \
	cpdf -stamp-on $(word 3, $^) -pos-left "-20 -1470" \
		-stdin -stdout | \
	cat > $@

cccombine.pdf: cc.pdf ccsign.pdf
	pdfjam -o $@ $< 1-3 $(word 2, $^)

Pictures:
	/bin/ln -s ~/Pictures .

######################################################################

## Secondary ghetto

jdaz.pdf.zip:
.SECONDEXPANSION:
%.pdf.zip: $$(wildcard $$*/_*.pdf)
	$(ZIP)

######################################################################

BASE = ~/screens
Makefile: makestuff/Makefile
	touch $@
makestuff/Makefile:
	ls $(BASE)/makestuff/Makefile && /bin/ln -s $(BASE)/makestuff 

-include makestuff/pipeR.mk
-include makestuff/rmd.mk
-include makestuff/pandoc.mk
-include makestuff/forms.mk
-include makestuff/drop.mk

-include makestuff/os.mk
-include makestuff/visual.mk

## This is the ~/Downloads make file; managed in org/files
## and served to ~/Downloads as a link

## Downloads is not a repo, so stable subdirectories should also be managed by files -- unless we can over-ride all.time and add this to alldirs? Which seems kind of brilliant. Dropped this because I don't understand how Downloads is interacting with all right now 2025 Dec 26 (Fri):
## This is in alldirs, but doesn't seem to all, nor to kick an error on sink

## This directory does not use makestuff right now 2025 Dec 26 (Fri)
## Should I just move all these rules out to files/? Isn't that what it's for?

all: update_copies
runscreen: ;

-include target.mk
target.mk:
	/bin/cp ~/screens/$@ .

default: update_copies

## There are things here that are intended as mirrors but not maintained since nextcloud collapse. Maybe make them as links to where. files?

## Maybe maintained now. I see some mirrors, but not a lot of explanation

default: update_copies

ffolder = ~/screens/org/files/

######################################################################
## Moving stuff around

new:
	mkdir -p $@
	cp *.zip $@
	cd $@ && bash -cl lastunzip && $(RM) *.zip

## What is this for?? Should I delete and see if I re-invent it? 2025 Sep 27 (Sat)
%.contents: contents
	mv $< $*

contents: 
	mkdir $@
	mv *.* $@

######################################################################

newdoc.pdf: | cache
	ls -t *.docx *.DOCX | head -1 | xargs -i libreoffice --headless --convert-to pdf "{}"
	ls -t *.pdf *.PDF | head -1 | xargs -i mv "{}" $@
	ls -t *.docx *.DOCX | head -1 | xargs -i mv "{}" cache/

cache:
	$(mkdir) 

######################################################################

update_copies: .
	rename -f "s/ *\([0-9]\)//" *\([0-9]\).*
	touch $@

quote_names:
	rename -f "s/'//" *.*

filenames: ..filenames ;
%.filenames:
	rename "s/[()& ,?!-]+/_/g" $*/*.*

######################################################################

## folders += stash library cloud reviewDocs sent
folders += jd picture transit attach

folders: $(folders)

$(folders):
	/bin/ln -s ~/screens/org/files/$@ .

%.get %.syncup:
	cd $(ffolder) && $(MAKE) $@
get = $(folders:%=%.get)
pullup: $(get)

syncup = $(folders:%=%.syncup)
sync: $(syncup)

######################################################################

## Is it becoming stupid not to have makestuff here?
## Or should I move all of this stuff to files?

%.pptx.pdf: %.pptx
	mkdir $*.dir 
	soffice --headless --convert-to pdf --outdir $*.dir $<
	mv $*.dir/*.pdf $@
	rm -fr $*.dir

pptxf = $(wildcard *.pdf)
pptxp = $(pptxf:%=%.pdf)

conversions:
	@echo $(pptxf)

######################################################################

## Sandboxing

## Does not work at all despite copilot
effects.md: effects.pptx
	pandoc $< -t markdown -o $@

## effects.pptx.html: effects.pptx
## Tremendously horrible
%.pptx.html: %.pptx
	soffice --headless --convert-to html "$<" --outdir .
	sleep 1
	/bin/mv $*.html $@

## python pptxq.py effects.pptx -o effects.qmd ##

######################################################################

## Less needed than before

nuke: delall clean syncup

delall:
	$(RM) *.*

clean:
	$(RM) $(folders)

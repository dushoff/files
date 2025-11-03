
default: update_copies

## There are things here that are intended as mirrors but not maintained since nextcloud collapse. Maybe make them as links to where. files?

vim_session: 
	bash -cl "vm ~/screens/org/files/Downloads.md"

mirrors += jd picture transit attach

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

update_copies: .
	rename -f "s/ *\([0-9]\)//" *\([0-9]\).*
	touch $@

quote_names:
	rename -f "s/'//" *.*

filenames: ..filenames ;
%.filenames:
	rename "s/[()& ,?!-]+/_/g" $*/*.*

## Resting

folders += stash library cloud reviewDocs sent

folders: $(folders)

$(folders):
	/bin/ln -s ~/screens/org/Planning/$@ .

nuke: delall clean up

delall:
	$(RM) *.*

clean:
	$(RM) $(folders)

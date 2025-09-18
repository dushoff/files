## This file is _included_ from the Downloads actual Makefile
all: update_copies
runscreen: ;

vim_session: 
	bash -cl "vm ~/screens/org/files/Downloads.mk ~/screens/org/files/Downloads.md"

mirrors += jd picture transit attach

######################################################################
## Moving stuff around

new:
	mkdir -p $@
	cp *.zip $@
	cd $@ && bash -cl lastunzip && $(RM) *.zip

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

put up:
	cd ~/screens/org/Planning/ && $(MAKE) downup

get down: 
	cd ~/screens/org/Planning/ && $(MAKE) Downloads.get

######################################################################


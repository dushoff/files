all: update_copies
runscreen: ;

vim_session: 
	bash -cl "vmt" ~/screens/org/files/Downloads.mk

######################################################################

folders += stash library cloud reviewDocs sent

folders: $(folders)

$(folders):
	/bin/ln -s ~/screens/org/Planning/$@ .

nuke: delall clean up

delall:
	$(RM) *.*

clean:
	$(RM) $(folders)

up:
	cd ~/screens/org/Planning/ && $(MAKE) downup

down: 
	cd ~/screens/org/Planning/ && $(MAKE) Downloads.get

new:
	mkdir -p $@
	cp *.zip $@
	cd $@ && bash -cl lastunzip && del *.zip

######################################################################

update_copies: .
	rename -f "s/ *\([0-9]\)//" *\([0-9]\).*
	touch $@

quote_names:
	rename -f "s/'//" *.*


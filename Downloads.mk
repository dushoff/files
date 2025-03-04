all: update_copies
runscreen: ;

vim_session: 
	bash -cl "vmt"

######################################################################

folders += stash library cloud reviewDocs sent

folders: $(folders)

$(folders):
	/bin/ln -s ~/screens/org/Planning/$@ .

clean:
	$(RM) $(folders)

up:
	cd ~/screens/org/Planning/ && $(MAKE) downup

######################################################################

update_copies: .
	rename -f "s/ *\([0-9]\)//" *\([0-9]\).*
	touch $@

quote_names:
	rename -f "s/'//" *.*


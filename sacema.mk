## Tech is fun, but you should do SACEMA on the remarkable (too many blanks)
## Or maybe keep p1 and p3 from here.

sacemaName.pdf: stash/contract.1.select.pdf name.pdf Makefile
	cat $< > /dev/stdout | \
	cpdf -stamp-on $(word 2, $^) -pos-left "200 -265" \
		-stdin -stdout | \
	cat > $@

sacemaFill.pdf: stash/contract.3.select.pdf address.txt.pdf Makefile
	cat $< > /dev/stdout | \
	cpdf -stamp-on $(word 2, $^) -pos-left "200 -615" \
		-stdin -stdout | \
	cat > $@

## sacemaSigned.pdf via remarkable
sacemaSign.pdf: stash/contract.4.select.pdf address.txt.pdf Makefile
	cat $< > /dev/stdout | \
	cpdf -stamp-on $(word 2, $^) -pos-left "200 -615" \
		-stdin -stdout | \
	cat > $@
	
sacemaFiles += sacemaName.pdf stash/contract.2.select.pdf
sacemaFiles += sacemaFill.pdf sacemaSigned.pdf
sacema.cat.pdf: $(sacemaFiles)
	$(pdfcat)


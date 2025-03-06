chenFinal.signed.pdf: cloud/chenFinal.pdf formDrop/jsig.30.pdf
chenFinal.signed.pdf: name_1.2.pdf 
chenFinal.signed.pdf: date_1.2.pdf 
chenFinal.signed.pdf: X_1.2.pdf 
chenFinal.signed.pdf: dongxuan.mk
chenFinal.signed.pdf:
	pdfjam $< 1 -o /dev/stdout | \
	cpdf -stamp-on $(word 2, $^) -pos-left "195 205" \
		-stdin -stdout | \
	cpdf -stamp-on $(word 3, $^) -pos-left "115 -760" \
		-stdin -stdout | \
	cpdf -stamp-on $(word 4, $^) -pos-left "115 -790" \
		-stdin -stdout | \
	cpdf -stamp-on $(word 5, $^) -pos-left "-4 -434" \
		-stdin -stdout | \
	cat > $@

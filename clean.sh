_docmd() {
	local day num seq args
	day=15
	num=$((day*3))
	seq=0 args=""
	ls log/[0-9]* 2>/dev/null || return 0
	for i in $(cd log; ls [0-9]*|tail -$num); do if ((seq>0)); then args+="-o -name $i "; fi; ((seq++)) || true; done
	find log -type f -not \( -name "$(cd log; ls [0-9]*|tail -$num|head -1)" $(echo $args) \) -delete
}

if [ -d log ]; then _docmd; fi
for md in {,other/*/}bing-wallpaper.md; do
	dup="$(awk '{print$1}' ${md} | sort | uniq -d)"
	if [ -n "$dup" ]; then echo -e "${md}:${dup}\n" >>log/duplicate.txt; fi
done
find log -empty -delete

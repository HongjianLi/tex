bibfields=(author title journal year volume number pages)
suffix="},\n"
for f in ~/Downloads/*.bib
do
	printf "\n%s{%s,\n" $(grep '@.*{' $f | cut -d{ -f1 | tr '[:upper:]' '[:lower:]') $(basename $f .bib)
	for bibfield in ${bibfields[@]}
	do
		prefix="\t${bibfield}\t=\t{"
		regexp="${bibfield[@]}[[:space:]]*=[[:space:]]*"
		if [[ $bibfield == "title" ]]
		then
			printf "${prefix}{$(grep -i "${regexp}" $f | cut -d{ -f2 | cut -d} -f1)}${suffix}"
		else
			printf "${prefix}$(grep -i "${regexp}" $f | cut -d{ -f2 | cut -d} -f1)${suffix}"
		fi
	done
	echo "}"
done | sed -e 's/\r/\n/g' -e 's/[_&$]/\\&/g' -e 's/α/$\\alpha$/g' -e 's/β/$\\beta$/g' >> refworks.bib
risfields=(AU TI JA PY VL IS [S,E]P)
for f in ~/Downloads/*.ris
do
	entry=""
	if [[ $(grep "TY[[:space:]]*-[[:space:]]*" $f | cut -d- -f2 | sed 's/[[:space:]]*//') == "JOUR" ]]
	then
		entry="article"
	fi
	printf "\n%s{%s,\n" "@${entry}" $(basename $f .ris)
	for i in $(seq 0 ${#bibfields})
	do
		bibfield=${bibfields[i]}
		risfield=${risfields[i]}
		prefix="\t${bibfield}\t=\t{"
		regexp="${risfield[@]}[[:space:]]*-[[:space:]]*"
		if [[ $bibfield == "title" ]]
		then
			printf "${prefix}{$(grep "${regexp}" $f | cut -d- -f2 | sed 's/[[:space:]]*//')}${suffix}"
		elif [[ $bibfield == "author" ]]
		then
			printf "${prefix}$(grep "${regexp}" $f | cut -d- -f2 | sed 's/[[:space:]]*//' | head -c -1 | tr '\n' '=' | sed 's/=/ and /g')${suffix}"
		elif [[ $bibfield == "pages" ]]
		then
			printf "${prefix}$(grep "${regexp}" $f | cut -d- -f2 | sed 's/[[:space:]]*//' | head -c -1 | tr '\n' '-')${suffix}"
		else
			printf "${prefix}$(grep "${regexp}" $f | cut -d- -f2 | sed 's/[[:space:]]*//')${suffix}"
		fi
	done
	echo "}"
done | sed -e 's/\r/\n/g' -e 's/[_&$]/\\&/g' -e 's/α/$\\alpha$/g' -e 's/β/$\\beta$/g' >> refworks.bib

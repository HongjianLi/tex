id=$(tail refworks.bib | grep '@.*{' | cut -d{ -f2 | head -c -2)
bibfields=(author title journal year volume number pages)
risfields=(AU TI JA PY VL IS [S,E]P)
suffix="},\n"
while true
do
	id=$((id+1))
	f=$(find bib -name $id.*)
	if [[ -z $f ]]
	then
		break
	fi
	sed -i 's/\r//g' $f
	case ${f##*.} in
	bib)
		printf "\n%s{%s,\n" $(grep '@.*{' $f | cut -d{ -f1 | tr '[:upper:]' '[:lower:]') $id
		for bibfield in ${bibfields[@]}
		do
			prefix="\t${bibfield}\t=\t{"
			regexp="${bibfield[@]}[[:space:]]*=[[:space:]]*"
			if [[ $bibfield == "author" ]]
			then
				printf "${prefix}$(grep -i "${regexp}" $f | cut -d{ -f2 | cut -d} -f1 | sed 's/ AND / and /g')${suffix}"
			elif [[ $bibfield == "title" ]]
			then
				printf "${prefix}{$(grep -i "${regexp}" $f | cut -d{ -f2 | cut -d} -f1)}${suffix}"
			else
				printf "${prefix}$(grep -i "${regexp}" $f | cut -d{ -f2 | cut -d} -f1)${suffix}"
			fi
		done
	;;
	ris)
		entry=""
		if [[ $(grep "TY[[:space:]]*-[[:space:]]*" $f | cut -d- -f2 | sed 's/[[:space:]]*//') == "JOUR" ]]
		then
			entry="article"
		fi
		printf "\n%s{%s,\n" "@${entry}" $id
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
				printf "${prefix}$(grep "${regexp}" $f | cut -d- -f2 | sed 's/[[:space:]]*//' | awk '{if (length($0)) print $0}' | head -c -1 | tr '\n' '-')${suffix}"
			else
				printf "${prefix}$(grep "${regexp}" $f | cut -d- -f2 | sed 's/[[:space:]]*//')${suffix}"
			fi
		done
	;;
	esac
	echo "}"
done | sed -e 's/\r/\n/g' -e 's/[_&$]/\\&/g' -e 's/α/$\\alpha$/g' -e 's/β/$\\beta$/g' >> refworks.bib

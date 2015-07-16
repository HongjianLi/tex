for l in $(for i in `grep bibitem{ $1.bbl | cut -d{ -f2 | cut -d} -f1 | sort -n`
do
	grep -n "{$i," ~/tex/refworks.bib
done | cut -d: -f1)
do
	n=`tail -n +$l ~/tex/refworks.bib | grep -nm 1 "^}$" | cut -d: -f1`
	tail -n +$l ~/tex/refworks.bib | head -$((n+1))
done > $1.bib

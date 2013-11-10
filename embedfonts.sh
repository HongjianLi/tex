s=${1:0:${#1}-4}
epstopdf $s.eps
pdftops $s.pdf
ps2eps -f -q $s.ps
rm $s.pdf $s.ps

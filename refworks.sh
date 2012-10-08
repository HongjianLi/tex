sed 's/[_&$]/\\&/g' JackyLeeHongJian-RefList.txt > refworks.bib
sed -i 's/α/$\\alpha$/g' refworks.bib
sed -i 's/β/$\\beta$/g' refworks.bib


cat JackyLeeHongJian-RefList.txt | sed 's/[_&$]/\\&/g' | sed 's/α/$\\alpha$/g' | sed 's/β/$\\beta$/g' > refworks.bib

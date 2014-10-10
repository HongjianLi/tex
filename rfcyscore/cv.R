#!/usr/bin/env Rscript
d=read.csv('cv.csv')
for (p in 1:5) {
	tiff(sprintf('cv-p%s.tiff',p),compress='lzw')
	par(cex.lab=2,cex.axis=2,cex.main=2)
	hist(d[d$Partition==p,]$pKd,xlab='pKd',main=sprintf('Partition %s',p),bg='transparent')
	dev.off()
}

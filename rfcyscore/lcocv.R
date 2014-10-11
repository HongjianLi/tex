#!/usr/bin/env Rscript
clusters=c('A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z')
d=read.csv('lcocv.csv')
for (p in 1:26) {
	c=clusters[p]
	tiff(sprintf('lcocv-p%s.tiff',c),compress='lzw')
	par(cex.lab=2,cex.axis=2,cex.main=2)
	hist(d[d$Cluster==c,]$pKd,xlab='pKd',main=sprintf('Partition %s',c),bg='transparent')
	dev.off()
}

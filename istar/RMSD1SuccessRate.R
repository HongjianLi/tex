#!/usr/bin/env Rscript
bs=c("PDBbind v2012","PDBbind v2011","CSAR NRC HiQ")
ps=c("idock","Vina")
d=read.csv('RMSDmSuccessRate.csv')
par(cex.lab=1.3,cex.axis=1.3,cex.main=1.3)
for (b in 1:length(bs)) {
for (p in 1:length(ps)) {
	plot(d[d$b==bs[b]&d$p==ps[p],"x"],d[d$b==bs[b]&d$p==ps[p],"y"],xlim=c(0.5,2.5),ylim=c(0,1),type="b",xaxt="n",yaxt="n",xlab="",ylab="",pch=p,col=b)
	par(new=T)
}
}
title(xlab="RMSD threshold",ylab="Success rate")
legend("topleft",title="Benchmarks",legend=bs,fill=1:length(bs),cex=1.3)
legend("bottomright",title="Programs",legend=ps,pch=1:length(ps),cex=1.3)
axis(1)
axis(2)

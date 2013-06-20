#!/usr/bin/python

f=open("/Users/dashazhernakova/Documents/UMCG/hapmapData/tophat/1671_5_1/accepted_hits.sorted.sam")
out=open("/Users/dashazhernakova/Documents/UMCG/hapmapData/tophat/1671_5_1/accepted_hits_chr.sorted.sam","w")
for line in f:
	spl=line.split("\t")
	spl[2]='chr'+spl[2]
	out.write("\t".join(spl))
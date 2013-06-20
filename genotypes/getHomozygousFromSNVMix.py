#!/usr/bin/python

f = open("/Users/dashazhernakova/Documents/UMCG/data/lincRNA_Sebo/mappedData/L2/accepted_hits.filtered.mpileup.cov5.snvmix")

for l in f:
	spl = l.strip().split("\t")[3].split(",")
	n1 = spl[0].split(":")[1]
	n2 = spl[1].split(":")[1]
	g = spl[5]
	
	if g in ["1","2"]:
		if (int(n1) > 50) and (int(n2) > 50) :
			if ( int(n1) > 10*int(n2) ) or ( int(n2) > 10*int(n1) ):
				print l.strip()
f.close()


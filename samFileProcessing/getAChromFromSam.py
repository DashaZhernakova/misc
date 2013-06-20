#!/usr/bin/python
import sys

sam = open(sys.argv[1])
spl=sys.argv[1].split("/")
out = open(sys.argv[1].replace(spl[len(spl)-1],sys.argv[2] + "_" + spl[len(spl)-1]),"w")
#sam = open("/Users/dashazhernakova/Documents/UMCG/pickrell_data/tophat_out/NA18522_yale/accepted_hits.filtered.sorted.sam")
#out = open("/Users/dashazhernakova/Documents/UMCG/pickrell_data/tophat_out/NA18522_yale/6.filtered.sorted.sam","w")
chr = sys.argv[2]
for line in sam:
	if line.startswith("@"):
		if line.startswith("@HD"):
			out.write(line)
		if "SN:"+chr in line:
			out.write(line)
	else:
		if line.split("\t")[2] == chr:
			out.write(line)

out.close()
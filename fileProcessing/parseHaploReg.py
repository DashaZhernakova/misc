#!/usr/bin/python

import sys

f = open(sys.argv[1])

d = {}
l=[]
snp=""
line = f.readline()
while line.startswith("Enhancers"):
	line = f.readline()
while line:
	if line.startswith("Query"):
		if not "was not found" in line:
			d[snp] = l
			snp=line.split(" ")[2]
			l = ["0"]*6
			f.readline()
			
	elif (not line.startswith("Converted") ):
		spl = line.split("\t")
		#print line
		#print spl[11:17]
		#print len(spl), snp
		#print line
		for k in range(11,17):
			if spl[k] != "":
				l[k-11] = "1"

	line = f.readline()
for snp, l in d.items():
	print snp + "\t" + "\t".join(l)
f.close()
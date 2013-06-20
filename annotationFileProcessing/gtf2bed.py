#!/usr/bin/python
import sys

gtf = open(sys.argv[1])
bed = open(sys.argv[1].replace(".gtf",".bed"), "w")
feature = sys.argv[2]
for line in gtf:
	spl = line.strip().split("\t")
	if spl[2] == feature:
		tr = spl[8].split("\"")[3]
		bed.write(spl[0] + "\t" + str(int(spl[3]) - 1) + "\t" + spl[4] + "\t" + tr + "\n")
gtf.close()
bed.close()

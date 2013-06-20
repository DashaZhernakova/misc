#!/usr/bin/python
import sys

bed = open(sys.argv[1])
txt = open(sys.argv[1].replace(".bed",".txt"), "w")

for line in bed:
	spl = line.strip().split("\t")
	spl[1] = str(int(spl[1]) + 1)
	txt.write("\t".join(spl) + "\n")
	
txt.close()
bed.close()
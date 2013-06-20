#!/usr/bin/python
import sys

txt = open(sys.argv[1])
bed = open(sys.argv[1].replace(".txt",".bed"), "w")

for line in txt:
	spl = line.strip().split("\t")
	spl[1] = str(int(spl[1]) - 1) 
	bed.write("\t".join(spl) + "\n")
	
txt.close()
bed.close()
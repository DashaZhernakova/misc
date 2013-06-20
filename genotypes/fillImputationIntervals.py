#!/usr/bin/python
import sys

#Template contains 2 lines: header and 1 line of filled parameters without last 3 args: chr,fromChrPos,toChrPos
template = open(sys.argv[1])
header = template.readline()
templLine = template.readline().strip()
intervals = open(sys.argv[2])
intervals.readline()

#to fill the template only for 1 chromosome, pass the chr name as the 3rd parameter
chrom = ""
if len(sys.argv) > 3:
	chrom = sys.argv[3]

for line in intervals:
	chr,st,end = line.strip().split(",")
	if chrom == "":
		print templLine + "," + chr + "," + st + "," + end
	else:
		if chrom == chr:
			print templLine + "," + chr + "," + st + "," + end
	
template.close()
intervals.close()
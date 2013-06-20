#!/usr/bin/python
import sys
fq = open(sys.argv[1])
aln_sam = open(sys.argv[2])
unaln = open(sys.argv[3], 'w')

names = []
for line in aln_sam:
	if not line.startswith('@'):
		names.append(line.split("\t")[0])
#print names
cur_r = ""
for line in fq:
	if line.startswith("@"):
		if not cur_r == "":
			unaln.write(cur_r)
		cur_r = ""
		if line[1:len(line) - 3] not in names:
			cur_r += line
	elif not cur_r == "":
		cur_r += line
unaln.write(cur_r)
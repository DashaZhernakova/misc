#!/usr/bin/python
import sys
from collections import defaultdict

f = open(sys.argv[1])
counts = defaultdict(int)
for line in f:
	if not line.startswith("@"):
		nM = line.strip().split("\t")[14].split(":")[2]
		counts[nM] += 1
for nM in sorted(counts):
	print nM + "\t" + str(counts[nM])
f.close()




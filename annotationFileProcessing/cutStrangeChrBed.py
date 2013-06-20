#!/usr/bin/python

import sys

f = open(sys.argv[1])

for l in f:
	l = l.strip()
	spl = l.split("\t")
	#if (spl[0].isdigit()) or (spl[0] in ["X", "Y", "MT", "M"]) or (spl[0].startswith("GL")):
	if (spl[0].isdigit()) or (spl[0] in ["X", "Y", "MT", "M"]):
		print l
f.close()
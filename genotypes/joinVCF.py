#!/usr/bin/python
import sys
import os
import glob

path = sys.argv[1]
for infile in glob.glob( os.path.join(path, '*.vcf') ):
	f = open(infile)
	for line in f:
		if not line.startswith("#"):
			print line.strip()
	f.close()
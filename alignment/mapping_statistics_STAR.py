#!/usr/bin/python

import sys

import os
import glob
 
path = sys.argv[1]
for infile in glob.glob( os.path.join(path, '*/Log.final.out') ):
	f = open(infile)
	print infile.readlines()[10].strip().split()
	
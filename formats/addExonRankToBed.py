#!/usr/bin/python

import sys

f = open(sys.argv[1])

i = 0
cur_tr = ""
for line in f:
	spl=line.strip().split("\t")
	tr = spl[3]
	if tr == cur_tr:
		i += 1
	else:
		cur_tr = tr
		i = 1
	print line.strip().replace(cur_tr, cur_tr + ":" + str(i))	

f.close()
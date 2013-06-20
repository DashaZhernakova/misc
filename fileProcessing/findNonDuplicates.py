#!/usr/bin/python
import sys

in_f = open(sys.argv[1])
out_f = open(sys.argv[2], "w")
#in_f = [1,2,3,4,3,1,9,1]
all = set([])
dup = set([])
for line in in_f:
	str = line.strip()
	
	if str in all:
		dup.add(str)
	else:
		all.add(str)

for s in all:
	if s not in dup:
		out_f.write(str + "\n")
in_f.close()
out_f.close()
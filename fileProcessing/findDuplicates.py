#!/usr/bin/python
import sys
import fileinput

#in_f = open(sys.argv[1])
#out_f = open(sys.argv[2], "w")
for file in fileinput:
	print file
'''nd = set([])
for line in in_f:
	str = line.strip()
	if str in nd:
		out_f.write(line)
	else:
		nd.add(str)

in_f.close()
out_f.close()'''
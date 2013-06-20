#!/usr/bin/python
import sys
print sys.argv
in_f=open(sys.argv[1])
out = open (sys.argv[2],"w")
pos=[]
for i in sys.argv[3:]:
	pos.append(int(i))
print pos
for line in in_f:
	spl=line.split("\t")
	out.write(spl[pos[0]])
	for p in pos[1:]:
		out.write("\t" + spl[p])
	out.write("\n")
out.close()
in_f.close()

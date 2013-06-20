#!/usr/bin/python
import sys
in_f = open(sys.argv[1])
list_f = open(sys.argv[2])

list = set([])
for it in list_f:
	list.add(it.strip())

for obj in in_f:
	if obj.strip() not in list:
		print obj.strip()
in_f.close()
list_f.close()
#!/usr/bin/python
"""
replaces strings specified in -f (whatToReplace \t withWhatToReplace), in the file specified in -i 
-d - delimiter doesn't work
"""
import sys
import getopt

delim = ""
try:
	opts, args = getopt.getopt(sys.argv[1:],"i:f:d:")
	for opt, arg in opts:
		#print opt, arg
		if opt == "-i": 
			in_f = open(arg)
		elif opt  == "-f":
			list = open(arg)
		elif opt == "-d":
			delim = arg
			
except getopt.GetoptError:          
	#usage()                         
	sys.exit(2) 
delim = " "
replace = {}
for line in list:
	spl = line.strip().split(delim)
	replace[spl[0]] = spl[1]
list.close()


for line in in_f:
	spl = line.strip().split(delim)
	new_l = []
	for el in spl:
		if el in replace.keys():
			el = replace[el]
		new_l.append(el)
	print delim.join(new_l)
in_f.close()
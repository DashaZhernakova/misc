#!/usr/bin/python

import sys
from collections import defaultdict
if len(sys.argv) > 1:
        if sys.argv[1] != "-":
                f = open(sys.argv[1])
        else:
                f = sys.stdin
else:
        f = sys.stdin
map=defaultdict(set)
for line in f:
        spl = line.strip().split("\t")
        read = spl[3]
        gene = spl[15].split(":")[1]
        map[gene].add((read))
for g, reads in map.items():
        print g + "\t" + str(len(reads))

f.close()
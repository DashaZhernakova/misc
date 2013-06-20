#!/usr/bin/python
import sys
import gzip
import glob
import os

path = "/Users/dashazhernakova/Documents/UMCG/data/geuvadis/genotypes/FIN/rna-seq/impute/CR0.5_pr0.8/"
'''for in_f in glob.glob( os.path.join(path, '*.gen.gz') ):
	with gzip.open(in_f) as f:
		print "Processing", in_f
		out_f = open(in_f.replace(".gen.gz", ".rmdup.gen"), "w")
		snps = set()
		for l in f:
			pos = l.strip().split(" ")[2]
			if pos not in snps:
				out_f.write(l)
				snps.add(pos)
			else:
				print "DUPLICATE: " + pos
		
		out_f.close()'''
for in_f in glob.glob( os.path.join(path, '*_info.gz') ):
	with gzip.open(in_f) as f:
		print "Processing", in_f
		out_f = open(in_f.replace("_info.gz", ".rmdup_info"), "w")
		out_f.write(f.readline())
		snps = set()
		for l in f:
			pos = l.strip().split(" ")[2]
			if pos not in snps:
				out_f.write(l)
				snps.add(pos)
			else:
				print "DUPLICATE: " + pos
		
		out_f.close()
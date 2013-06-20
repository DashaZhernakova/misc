#!/usr/bin/python
import sys

f = open(sys.argv[1])
#f = open("/Users/dashazhernakova/Documents/UMCG/hg19/exonic_genes_v69_stranded.bed12")

'''for l in f:
	spl = l.strip().split("\t")
	lengths = spl[10]
	gene_len = 0
	for len in lengths.rstrip(",").split(","):
		gene_len += int(len)
	print spl[3] + "\t" + str(gene_len)
	
f.close()'''

l = f.readline().strip()
spl = l.split("\t")
cur_gene = spl[3]
lengths = spl[10]

for l in f:
	spl = l.strip().split("\t")
	gene = spl[3]
	if cur_gene == gene:
		lengths += spl[10]
	else:
		gene_len = 0
		for len in lengths.rstrip(",").split(","):
			gene_len += int(len)
		print cur_gene + "\t" + str(gene_len)
		lengths = spl[10]
		cur_gene = spl[3]
f.close()	

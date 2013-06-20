#!/usr/bin/python
from collections import defaultdict
import sys

def getStrandInf(mart_export):
	f = open(mart_export)
	geneToStrand = defaultdict()
	for line in f:
		spl = line.strip().split("\t")
		if spl[6] == "-1":
			geneToStrand[spl[4]] = "-"
		else:
			geneToStrand[spl[4]] = "+"
	f.close()
	return geneToStrand

def main(fname, mart_export):
	f = open(fname)
	geneToStrand = getStrandInf(mart_export)
	
	for line in f:
		spl = line.strip().split("\t")
		exs = spl[3].split(";")
		genes = set()
		gene_ids = set()
		exons = set()
		
		for ex in exs:
			#print ex.split(":")
			genes.add(ex.split(":")[2])
			gene_ids.add(ex.split(":")[1])
			exons.add(ex.split(":")[0])
		g = gene_ids.pop()	
		strand = geneToStrand[g]
		gene_ids.add(g)
		if len(gene_ids) > 1:
			for g in gene_ids:
				if not geneToStrand[g] == strand:
					strand = "."
					break
		
		attributes = "meta-exon_id \"" +  spl[0] + "_" + str(int(spl[1]) + 1) + "_" + spl[2] + "\"; gene_id \"" + ",".join(gene_ids) + "\"; gene_name \"" + ",".join(genes) + "\"; exon_id \"" + ",".join(exons) + "\";"
		#if len(genes) > 1:
		print "\t".join([spl[0], "ensembl_v71", "meta-exon", str(int(spl[1]) + 1), spl[2], ".", strand, ".", attributes])
	f.close()

if __name__ == "__main__":
	#main("/Users/dashazhernakova/Documents/UMCG/hg19/v71/tmp.bed")
	main(sys.argv[1], sys.argv[2])
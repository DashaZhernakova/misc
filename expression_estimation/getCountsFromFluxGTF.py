#!/usr/bin/python
import re

def writeExpressedGenes(fname, outfname):
	f = open(fname)
	out = open(outfname, "w")
	genes = set()
	
	for l in f:
		spl = l.strip().split("\"")
		tr = spl[1]
		gene = spl[5]
		reads = re.split(';| ', spl[6])[3]
		if float(reads) > 0:
			genes.add(gene)
	
	for g in genes:
		out.write(g + "\n")
		
	f.close()
	out.close()

def writeTranscriptCounts(fname, outfname):
	f = open(fname)
	out = open(outfname, "w")
	for l in f:
		spl = l.strip().split("\"")
		tr = spl[1]
		gene = spl[6]
		reads = re.split(';| ', spl[6])[3]
		if float(reads) > 0:
			out.write(tr + "\t" + reads + "\n")	
		
	f.close()
	out.close()
if __name__ == "__main__":
	fname = "/Users/dashazhernakova/Documents/UMCG/data/geuvadis/mappedData_masked/ERR188032/reads_unique_hits.sorted.flux.gtf"
	#outfname = "/Users/dashazhernakova/Documents/UMCG/data/geuvadis/mappedData_masked/ERR188032/flux_transcrCounts.txt"
	outfname = "/Users/dashazhernakova/Documents/UMCG/data/geuvadis/mappedData_masked/ERR188032/flux_genes.txt"
	#writeTranscriptCounts(fname, outfname)
	writeExpressedGenes(fname, outfname)
	
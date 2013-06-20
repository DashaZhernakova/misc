#!/usr/bin/python
import sys

exSNPs = set()

#gets all SNPs that are in exons
def getExonic(fname):
	exonic = open(fname)
	global exSNPs
	
	for line in exonic:
		line = line.strip().replace("chr", "")
		spl = line.strip().split("\t")
		exSNPs.add(spl[0]+":"+spl[2])
	exonic.close()

#calculate insertSize
#def calcInsertSize()

#check coverage threshold
def enoughCoverage(line):
	exThres = 5
	inThres = 15
	spl = line.split("\t")
	coverage = spl[3]
	#print coverage
	
	if spl[0] + ":" + spl[1] in exSNPs:
		if int(coverage) >= exThres:
			return True
		else:
			return False
	else:
		if int(coverage) >= inThres:
			return True
		else:
			return False
	return False

def main():
	f = open(sys.argv[1])
	#f = open("/Users/dashazhernakova/Documents/UMCG/tmp.txt")
	#f = open("/Users/dashazhernakova/Documents/UMCG/data/geuvadis/mappedData_masked/ERR188032/reads_unique_hits.sorted.mpileup.cov5true")
	getExonic(sys.argv[2])
	for line in f:
		line = line.strip().replace("chr", "")
		#print line
		enoughCoverage(line)
		if enoughCoverage(line):
			print line
	f.close()
			
if __name__ == "__main__":
	main()

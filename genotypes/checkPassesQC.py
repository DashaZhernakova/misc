#!/usr/bin/python
import sys

def paste(spl, passes, maf, cr, hwep):
	if passes:
		if (float(spl[3]) > maf) and (float(spl[4]) > cr) and (float(spl[5]) > hwep):
			print "\t".join(spl)
	if not passes:
		if (float(spl[3]) <= maf) or (float(spl[4]) <= cr) or (float(spl[5]) <= hwep):
			print "\t".join(spl)
def main(fName, passes, maf, cr, hwep):
	qc=open(fName)
	line=qc.readline()
#	print line
	while not line.startswith("SNP"):
		line=qc.readline()
	for line in qc:
#		print line
		if (line.startswith("=")):
			break
		if (line.startswith("ERROR")) or (line.startswith("Allele")):
			continue
		spl=line.strip().split("\t")
		paste(spl, passes, maf, cr, hwep)
	qc.close()

if __name__ == "__main__":
	passes = True
	if sys.argv[2] == "false" or sys.argv[2] == "False":
		passes = False
		
	if sys.argv[2] == "true" or sys.argv[2] == "True":
		passes = True
		
	if len(sys.argv) == 6:
		maf = float(sys.argv[3])
		cr = float(sys.argv[4])
		hwep = float(sys.argv[5])
	else:
		maf = 0.05
		cr = 0.95
		hwep = 0.001
	
	main(sys.argv[1], passes, maf, cr, hwep)
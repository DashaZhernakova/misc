import sys
if len(sys.argv) < 2:
	print "no input file"
f_name=sys.argv[2]
if sys.argv[1] == 'se':
	#reads=open(f_name+".fastq")
	reads=open("/Users/dashazhernakova/Documents/UMCG/pickrell_data/tophat_out/NA19141_yale/NA19141_yale.fastq")
	
elif sys.argv[1] == 'pe':
	reads=open(f_name+"_1.fastq")
else:
	print "paired-end or single-end? Please specify as the 1st argument!"
#sam_file=open(f_name+".sam")
sam_file=open("/Users/dashazhernakova/Documents/UMCG/pickrell_data/tophat_out/NA19141_yale/accepted_hits.sorted.filtered.sam")

num_reads=0
num_aln=0
for line in sam_file:
	if line[0] != "@":
		num_aln+=1
print "number of aligned reads: " + str(num_aln)
for line in reads:
	if line[0] == "@":
		num_reads+=1
print "number of reads: " + str(num_reads)

if sys.argv[1] == 'se':
	rate=float(num_aln)/float(num_reads)*100
elif sys.argv[1] == 'pe':
	rate=float(num_aln)/float(num_reads)/2*100


print "%(rate).1f"  % {'rate':rate} + "% of reads mapped"
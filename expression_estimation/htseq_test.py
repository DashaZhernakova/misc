import HTSeq
i=0
for aln in HTSeq.SAM_Reader("/Users/dashazhernakova/Documents/UMCG/hapmapData/1382_1.sam"):
	if i==10:
		break
	if aln.aligned:
		i+=1
		print aln.iv.chrom
		print aln.iv.start
		print aln.iv.end
		print aln.iv.strand
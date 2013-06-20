fasta = open("/Users/dashazhernakova/Documents/UMCG/hg19/human_g1k_v37.fa")
path = "/Users/dashazhernakova/Documents/UMCG/hg19/referenceByChr/"
first = True
for line in fasta:
	if  line.startswith(">"):
		if not first:
			out.close()
		out = open(path + line.strip().replace(">","")+".fa","w")
		first = False
	out.write(line)

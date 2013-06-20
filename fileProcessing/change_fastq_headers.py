fasta=open("/Users/dashazhernakova/Documents/UMCG/hg19/human_g1k_v37.fasta")
new_fa=open("/Users/dashazhernakova/Documents/UMCG/hg19/human_g1k_v37_newheaders.fasta", "w")

for line in fasta:
	if line.startswith(">"):
		new_fa.write(line.split(" ")[0] + "\n")
		#print line.split(" ")[0] + "\r"
	else:
		new_fa.write(line)
		#print line
new_fa.close()
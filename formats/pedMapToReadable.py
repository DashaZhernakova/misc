#!/sr/bin/python

ped = open("/Users/dashazhernakova/Documents/UMCG/GeneticalGenomicsDatasets/RNA-Seq_Sebo/iCHIP_individual212-0169/pedMap/212-0169_hg19.ped")
map = open("/Users/dashazhernakova/Documents/UMCG/GeneticalGenomicsDatasets/RNA-Seq_Sebo/iCHIP_individual212-0169/pedMap/212-0169_hg19.map")
out = open ("/Users/dashazhernakova/Documents/UMCG/GeneticalGenomicsDatasets/RNA-Seq_Sebo/iCHIP_individual212-0169/pedMap/212-0169_hg19.out", "w")

for line in ped:
	genotypes = line.strip().split(" ")[6:]
	print len(genotypes)
	for i in range(0,len(genotypes) - 1,2):
		snp = map.readline().strip().split("\t")[1]
		out.write(snp + "\t" + genotypes[i] + genotypes[i + 1] + "\n")
		
out.close()
ped.close()
map.close()
	
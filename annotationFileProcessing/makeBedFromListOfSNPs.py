#!/usr/bin/python

f = open("/Users/dashazhernakova/Documents/UMCG/Sasha_SNP_lncRNA/proxies.txt")
out = open ("/Users/dashazhernakova/Documents/UMCG/Sasha_SNP_lncRNA/proxies.bed","w")
pos = open("/Users/dashazhernakova/Documents/UMCG/1000g/allSNPMappings_b37.txt")

needed = set([])
for snp in f:
	needed.add(snp.strip())
i = 0

for line in pos:
	spl = line.strip().split("\t")
	if spl[2] in needed:
		out.write(spl[0] + "\t" + spl[1] + "\t" + str(int(spl[1]) + 1) + "\t" + spl[2] + "\n")
		i += 1
		
print len(needed)
print i
out.close()
'''

f2 = open("/Users/dashazhernakova/Documents/UMCG/lincRNA/lincRNA.bed")
f3 = open("/Users/dashazhernakova/Documents/UMCG/lincRNA/lincRNA_genes.bed","w")
t2g = open("/Users/dashazhernakova/Documents/UMCG/lincRNA/lincRNAs_transcript_gene_id_mapping.txt")
i = 0
j = 0
map = {}
for line in t2g:
	spl = line.strip().split("\t")
	map[spl[0]] = spl[1]
print map["TCONS_00007754"]
for line in f2:
	spl = line.strip().split("\t")
	if map.has_key(spl[3]):
		f3.write(spl[0] + "\t" + spl[1] + "\t" + spl[2] + "\t" + map[spl[3]] + "\n")
		i+= 1
	else:
		print "no gene!" + spl[4]
		j+=1
print i

f3.close()'''
import os
import glob
import sys
from Bio import SeqIO
from Bio.Seq import Seq
from Bio.SeqRecord import SeqRecord

snp_dict = {}
#make 2 fasta files: ref- with all reference alleles and alt - with all alternative alleles
def makeFasta(fa_path, path):
	#snps = open("/Users/dashazhernakova/Documents/UMCG/GeneticalGenomicsDatasets/HapMapPhase3GenotypeData/SNPMappings.txt")
	snps = open(path+"SNPAnnotation.txt")
	print "generating SNP dictionary"
	for snp in snps:
		fields = snp.strip().split("\t")
		ma = fields[5]
		
		alleles = list(set([fields[3], fields[4]]).difference([fields[5]]))
		alleles.append(fields[5])
		if snp_dict.has_key(fields[1]):
			snp_dict[ fields[1] ].append( (fields[2], alleles) )
		else:
			snp_dict[ fields[1] ] = [ (fields[2], alleles ) ]
	
	#print snp_dict
	#path = "/Users/dashazhernakova/Documents/UMCG/hg19/referenceByChr/"
	#path = "/Users/dashazhernakova/Documents/UMCG/"
	print "generating new fasta files"
	for in_f in glob.glob( os.path.join(fa_path, '*.fa') ):
		chr_num = in_f.split("/")[len(in_f.split("/")) - 1].replace(".fa", "")
		ref_fa = open(path + chr_num + "_ref.fa","w")
		alt_fa = open(path + chr_num + "_alt.fa","w")
		print "processing " + in_f
		print "processing " + chr_num
		for seq_record in SeqIO.parse(in_f, "fasta"):
			seq_ref = seq_record.seq
			seq_alt = seq_record.seq
			#id = in_f.split("/")[ len(in_f.split("/")) - 1 ].replace(".fa","") 
			id = chr_num
			for pos, al in snp_dict[id]:
				#print pos, al
				pos = int(pos)
				seq_ref = Seq(str(seq_ref[:pos - 1]) + al[0] + str(seq_ref[pos:]))
				seq_ref.id = id
				seq_alt = Seq(str(seq_alt[:pos - 1]) + al[1] + str(seq_alt[pos:]))
				seq_alt.id = id
			
		SeqIO.write([SeqRecord(seq_ref,id = seq_ref.id, description = 'ref')], ref_fa, "fasta")
		SeqIO.write([SeqRecord(seq_alt,id = seq_ref.id, description = 'alt')], alt_fa, "fasta")
#print seq
	alt_fa.close()
	ref_fa.close()
	print "finished generating fasta files"

def generateReads(l, path):
	ref_reads = open(path +"tmp_ref_reads.fasta","w")
	alt_reads = open(path +"tmp_alt_reads.fasta","w")
	#path = "/Users/dashazhernakova/Documents/UMCG/"
	#print snp_dict
	for in_f in glob.glob( os.path.join(path, '*ref.fa') ):
		ref_fa = open(in_f)
		alt_fa = open(in_f.replace("ref.fa", "alt.fa"))
		for s_r in SeqIO.parse(ref_fa, "fasta"):
			ref_seq = s_r.seq
			break
		for s_a in SeqIO.parse(alt_fa, "fasta"):
			alt_seq = s_a.seq
			break
		
		id = in_f.split("/")[ len(in_f.split("/")) - 1 ].replace("_ref.fa","") 
		start_pos = []
		for pos, al in snp_dict[id]:
			for i in range(0,l):
				start = int(pos) - l + i
				if start not in start_pos:
					start_pos.append(start)
					ref_reads.write(">" + str(id) + "_" + str(start) + "_ref\n")
					ref_reads.write(str(ref_seq[start:start+l])+"\n")
					alt_reads.write(">" + str(id) + "_" + str(start) + "_alt\n")
					alt_reads.write(str(alt_seq[start:start+l])+"\n")			
if __name__ == "__main__":
	#path = "/Users/dashazhernakova/Documents/UMCG/"
	makeFasta(sys.argv[1], sys.argv[2])
	#generateReads(3, path)
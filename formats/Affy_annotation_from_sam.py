#!/usr/bin/python

coord = {}
def getGeneCoordinates():
	annot = open("/Users/dashazhernakova/Documents/UMCG/hg19/annotations/HG-U219_noAmb.txt")
	print "getting gene coords"
	global coord
	for line in annot:
		spl = line.strip().split("\t")
		coord[spl[1]] = spl[3:]
	annot.close()

def withinInterval(chr, pos, id):
	
	if coord.has_key(id):
		(g_chr, st, end) = coord[id]
		if chr == g_chr:
			if (int(pos) >= int(st)) and (int(pos) <= int(end)):
				#print "True: gene coords: ", g_chr, st, end 
				return True
		#print "False: gene coords: ", g_chr, st, end 
	else:
		#print "No key"
		return False
	return False

def getPosToAppend(line):
	spl=line.split("\t")
	id = spl[0].split(":")[2]
	pos = spl[3]
	if withinInterval(spl[2], pos, id):
		return int(pos)
	elif "CP:i:" in line:
		alt_chr = spl[13].split(":")[2]
		alt_pos = spl[14].split(":")[2]
		if alt_chr == "=":
			alt_chr = spl[2]
		if withinInterval(alt_chr, alt_pos, id):
			return int(alt_pos)
	return 0
	
def run():
	sam = open("/Users/dashazhernakova/Documents/UMCG/GeneticalGenomicsDatasets/Peter-Bram_array_data/HG-U219_probe_tophat/accepted_hits.sortedByName.filtered.sam")
	bed = open("/Users/dashazhernakova/Documents/UMCG/GeneticalGenomicsDatasets/Peter-Bram_array_data/HG-U219_probe_tophat/annotation_probes.txt", "w")
	
	for line in sam:
		if not line.startswith("@"):
			break
	print "started"
	spl=line.split("\t")
	cur_id = spl[0].split(":")[2]
	cur_pos = spl[3]
	cur_cigar=spl[5]
	#bed.write(spl[2] + "\t" + str(int(cur_pos) - 1) + "\t")
	cur_chr = spl[2]
	wrong=[]
	i = 0
	starts = [getPosToAppend(line)]
	for line in sam:
		spl=line.split("\t")
		id = spl[0].split(":")[2]
		pos = spl[3]
		cigar=spl[5]
		if id == cur_id:
			starts.append(getPosToAppend(line))
		else:	
			#bed.write(str(int(cur_pos) + 25) + "\t" + cur_id + "\n")
			#bed.write(spl[2] + "\t" + str(int(pos) - 1) + "\t")
			starts = filter (lambda a: a != 0, sorted(starts))
			print starts, cur_id
			if len(starts) > 0:
				bed.write(cur_chr + "\t" + str(starts[0] - 1) + "\t" + str(starts[len(starts)-1] + 25) + "\t" + cur_id + "\n")
			cur_id = id
			cur_chr = spl[2]
			starts = [getPosToAppend(line)]
		cur_pos = pos
		
		#	print "outside ", spl[2], pos, id
		#if i>10:
		#	break
		#i+=1	
	print i
	sam.close()
	bed.close()

if __name__ == "__main__":
	
	getGeneCoordinates()
	run()
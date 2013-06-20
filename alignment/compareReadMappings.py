#!/usr/bin/python

import HTSeq as h
from collections import defaultdict

#reader_masked = h.SAM_Reader("/Users/dashazhernakova/Documents/UMCG/data/geuvadis/mappedData/ERR188022/aligned_masked.sam")
#reader = h.SAM_Reader("/Users/dashazhernakova/Documents/UMCG/data/geuvadis/mappedData/ERR188022/aligned.sam")

reader = h.SAM_Reader("/Users/dashazhernakova/Documents/UMCG/data/geuvadis/mappedData/ERR188022_masked/Aligned.out.filtered.new.1017680.sam")
reader_masked = h.SAM_Reader("/Users/dashazhernakova/Documents/UMCG/data/geuvadis/mappedData/ERR188022/Aligned.out.filtered.new1mb.sam")
it_p = iter(h.pair_SAM_alignments(reader))
it_p_m = iter(h.pair_SAM_alignments(reader_masked))

same_aligned = 0
one_same_pos = 0
both_same_pos = 0
masked_more_pos = 0
simple_more_pos = 0
#cur_read = {}
#cur_m_read = {}
not_in_simple = 0
not_in_masked = 0

n_m = defaultdict(list)
i = 0
for r1, r2 in h.pair_SAM_alignments(reader):
	n_m[r1.read.name].append((r1,r2))
	i += 1
	if i%10000 == 0:
		print i, " lines"
#for k,v in n_m.items():
#	print k, "\t", v
print "finished reading non-masked"

for r1_m, r2_m in h.pair_SAM_alignments(reader_masked):
	#print "\nmasked\t\t", r1_m, r2_m
	#print ""
	if n_m.has_key(r1_m.read.name):
		alns = n_m[r1_m.read.name]
		
		match = False
		for i, (r1, r2) in enumerate(alns):
			#print r1, r2
			if r1.iv == r1_m.iv: #one mate same positions 
				#print "one mate same positions"
				one_same_pos += 1
				if r2.iv == r2_m.iv: #both mates same position 
					#print "both mates same position"
					both_same_pos += 1
				#alns.remove((r1,r2))
				#r1,r2 = None,None
				del(alns[i])
				match = True
			elif r2.iv == r2_m.iv: #one mate same positions 
				#print "one mate same positions"
				one_same_pos += 1
				del(alns[i])
				match = True
			'''else: #extra alignment for the read in non-masked
				print "extra alignment for the read in non-masked"
				simple_more_pos += 1'''
		if match == False:
			#print "extra alignment for the read in masked"
			masked_more_pos += 1
		#print len(alns)
		if len(alns) == 0:
			del(n_m[r1_m.read.name])
	else:
		#print "extra read in masked"
		not_in_simple += 1
	#print n_m
	
	#for name, aln in n_m:
not_in_masked = len(n_m)

print "\n\n"
print "Same positions in both: ", both_same_pos
print "One of the pair has different position: ", one_same_pos - both_same_pos
print "Not in masked: ", not_in_masked
print "Not in non-masked: ", not_in_simple
#print "More alignment positions in masked: ", masked_more_pos
#print "More alignments in non-masked: ", simple_more_pos
print ""

		
'''
r1, r2 = it_p.next()
r1_m, r2_m = it_p_m.next()

cur_r1, cur_r2 = None, None
cur_r1_m, cur_r2_m = None, None
while 1:
	print r1, r2, "\t\t", r1_m, r2_m
	if r1.read.name == r1_m.read.name: #same read
		print "same read"
		same_aligned += 1
		if r1.iv == r1_m.iv: #one mate same positions 
			print "one mate same positions"
			left_same_pos += 1
			if r2.iv == r2_m.iv:
				print "both mates same position"
				right_same_pos += 1 #both mates same position
		cur_r1, cur_r2 = r1, r2
		cur_r1_m, cur_r2_m = r1_m, r2_m
		
		r1, r2 = it_p.next()
		r1_m, r2_m = it_p_m.next()
	
	else:
		if r1.read.name == cur_r1_m: #extra alignment for the read in non-masked
			print "extra alignment for the read in non-masked"
			simple_more_pos += 1
			cur_r1, cur_r2 = r1, r2
			r1, r2 = it_p.next()
			continue
		elif r1_m.read.name == cur_r1: #extra alignment for the read in masked
			print "extra alignment for the read in masked"
			masked_more_pos += 1
			cur_r1_m, cur_r2_m = r1_m, r2_m
			r1_m, r2_m = it_p_m.next()
			continue
		else: #check next alignment
			print "check next alignment"
			next_r1, next_r2 = it_p.next()
			next_r1_m, next_r2_m = it_p_m.next()
			
			if next_r1.read.name == r1_m.read.name: #skipped read in masked
				print "skipped read in masked"
				not_in_masked += 1
				cur_r1, cur_r2 = r1, r2
				r1, r2 = next_r1, next_r2
				#continue
			elif next_r1_m.read.name == r1.read.name: #skipped read in non-masked
				print "skipped read in non-masked"
				not_in_simple += 1
				cur_r1_m, cur_r2_m = r1_m, r2_m
				r1_m, r2_m = next_r1_m, next_r2_m
				#continue
			#ONLY FOR UNIQUE MAPPINGS		
			else: #diferent reads in both
				print "diferent reads in both"
				not_in_simple += 1
				not_in_masked += 1
				r1, r2 = next_r1, next_r2
				r1_m, r2_m = next_r1_m, next_r2_m'''

	
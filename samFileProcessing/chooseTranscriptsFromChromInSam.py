#!/usr/bin/python
import sys

sam = open(sys.argv[1])
annot = open(sys.argv[2])
spl=sys.argv[1].split("/")
out = open(sys.argv[1].replace(spl[len(spl)-1],sys.argv[3] + "_" + spl[len(spl)-1]),"w")

print "reading transcripts" 
transcripts = set()

for line in annot:
	spl = line.split("\t")
		
	if spl[3] == sys.argv[3]:
		transcripts.add(spl[1])
print str(len(transcripts)) + " transcripts read"
print "choosing chromosome " + sys.argv[3] + " from .sam file"
for line in sam:
	if line.startswith("@"):
		if line.startswith("@SQ"):
			tr = (line.split("\t")[1])[3:]
			if tr in transcripts:
				out.write(line)
		else:
			out.write(line)
	else:
		if line.split("\t")[2] in transcripts:
			out.write(line)

out.close()
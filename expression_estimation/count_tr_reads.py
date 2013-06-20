import sys

if len(sys.argv) < 2:
	print "no input file"
f_name=sys.argv[1]
ex_counts=open(f_name)
tr_counts=open(f_name[:len(f_name)-4]+"_out.txt","w")

line=""
cur_transcr=""
count=""
transcr=""
cur_count=0;
for line in ex_counts:
	line = line.strip()
	fields = line.split("\t")
	count = fields[0]
	transcr = fields[1]
	if (transcr == cur_transcr):
		cur_count += int(count)
	else:
		if (cur_transcr != ''): 
			tr_counts.write(cur_transcr + "\t" + str(cur_count)+"\n");
		cur_count=int(count)
		cur_transcr=transcr
tr_counts.write(cur_transcr + "\t" + str(cur_count));
                
tr_counts.close();
ex_counts.close(); 
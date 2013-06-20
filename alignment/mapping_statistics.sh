
#mapping statistics
start=$(date +"%T")
echo "Started at: $start"
sam_file=${2}_filtered.sam
if [ "$1" = "se" ]; then
 read1=${2}.fastq
fi
if [ "$1" = "pe" ]; then
 read1=${2}_1.fastq
fi
num_lines=$(($(wc -l $read1 | awk '{print $1}')+1))
num_reads=$((num_lines / 4))
#echo "overall number of reads=$num_reads"
#num_mapped=$(($(wc -l $sam_file | awk '{print $1}')+1))
#echo "number of mapped reads=$num_mapped"

echo "overall number of reads=$num_reads"
num_mapped=$(grep -c -v ^@ $sam_file)
echo "number of mapped reads=$num_mapped"

if [ "$1" = "se" ]; then
echo "se"
 rate=`echo "scale=2;100 * $num_mapped / $num_reads" | bc`
fi

if [ "$1" = "pe" ]; then 
 read1=${read1%_1}_2.fastq
 rate=`echo "scale=2;100 * $num_mapped / $num_reads / 2" | bc`
fi
echo "% reads mapped=$rate%"
finish=$(date +"%T")
echo "Started at: $start"
echo "Finished at: $finish"
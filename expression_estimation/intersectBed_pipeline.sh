#!/bin/bash 
#PBS -N count_reads_intersect
#PBS -q gcc
#PBS -l nodes=1:ppn=1
#PBS -l mem=1gb
#PBS -l walltime=02:30:00
#PBS -j oe
#PBS -o /target/gpfs2/gcc/home/dasha/hapmapData/scripts/output/intersectBed_pipeline.out
#PBS -e /target/gpfs2/gcc/home/dasha/hapmapData/scripts/output/intersectBed_pipeline.err

# it takes apx  mins to process 1 file

start=$(date +"%T")
echo "Started at: $start"
#FILES=("/target/gpfs2/gcc/home/dasha/tophat_out/emtab1/3125_2_1/")
FILES=("/target/gpfs2/gcc/home/dasha/tophat_out/emtab1/1382_1_1/" "/target/gpfs2/gcc/home/dasha/tophat_out/emtab1/1671_5_1/" "/target/gpfs2/gcc/home/dasha/tophat_out/emtab1/1974_1_1/" "/target/gpfs2/gcc/home/dasha/tophat_out/emtab1/1974_2_1/" "/target/gpfs2/gcc/home/dasha/tophat_out/emtab1/1974_3_1/" "/target/gpfs2/gcc/home/dasha/tophat_out/emtab1/1974_5_1/" "/target/gpfs2/gcc/home/dasha/tophat_out/emtab1/1974_6_1/" "/target/gpfs2/gcc/home/dasha/tophat_out/emtab1/1974_7_1/" "/target/gpfs2/gcc/home/dasha/tophat_out/emtab1/1974_8_1/" "/target/gpfs2/gcc/home/dasha/tophat_out/emtab1/1982_8_1/" "/target/gpfs2/gcc/home/dasha/tophat_out/emtab1/2003_6_1/" "/target/gpfs2/gcc/home/dasha/tophat_out/emtab1/2003_7_1/" "/target/gpfs2/gcc/home/dasha/tophat_out/emtab1/2005_1_1/" "/target/gpfs2/gcc/home/dasha/tophat_out/emtab1/2005_2_1/" "/target/gpfs2/gcc/home/dasha/tophat_out/emtab1/3125_3_1/" "/target/gpfs2/gcc/home/dasha/tophat_out/emtab1/2005_5_1/" "/target/gpfs2/gcc/home/dasha/tophat_out/emtab1/2005_6_1/" "/target/gpfs2/gcc/home/dasha/tophat_out/emtab1/2005_7_1/" "/target/gpfs2/gcc/home/dasha/tophat_out/emtab1/2005_8_1/" "/target/gpfs2/gcc/home/dasha/tophat_out/emtab1/2011_5_1/" "/target/gpfs2/gcc/home/dasha/tophat_out/emtab1/2011_6_1/" "/target/gpfs2/gcc/home/dasha/tophat_out/emtab1/2036_1_1/" "/target/gpfs2/gcc/home/dasha/tophat_out/emtab1/2036_2_1/" "/target/gpfs2/gcc/home/dasha/tophat_out/emtab1/2036_3_1/" "/target/gpfs2/gcc/home/dasha/tophat_out/emtab1/2036_5_1/" "/target/gpfs2/gcc/home/dasha/tophat_out/emtab1/2036_6_1/" "/target/gpfs2/gcc/home/dasha/tophat_out/emtab1/2036_7_1/" "/target/gpfs2/gcc/home/dasha/tophat_out/emtab1/2208_1_1/" "/target/gpfs2/gcc/home/dasha/tophat_out/emtab1/2208_2_1/" "/target/gpfs2/gcc/home/dasha/tophat_out/emtab1/2208_5_1/" "/target/gpfs2/gcc/home/dasha/tophat_out/emtab1/2208_6_1/" "/target/gpfs2/gcc/home/dasha/tophat_out/emtab1/2208_7_1/" "/target/gpfs2/gcc/home/dasha/tophat_out/emtab1/2208_8_1/" "/target/gpfs2/gcc/home/dasha/tophat_out/emtab1/2250_2_1/" "/target/gpfs2/gcc/home/dasha/tophat_out/emtab1/2257_8_1/" "/target/gpfs2/gcc/home/dasha/tophat_out/emtab1/2262_8_1/" "/target/gpfs2/gcc/home/dasha/tophat_out/emtab1/2872_8_1/" "/target/gpfs2/gcc/home/dasha/tophat_out/emtab1/3125_5_1/" "/target/gpfs2/gcc/home/dasha/tophat_out/emtab1/3122_8_1/" "/target/gpfs2/gcc/home/dasha/tophat_out/emtab1/2872_6_1/" "/target/gpfs2/gcc/home/dasha/tophat_out/emtab1/2992_6_1/" "/target/gpfs2/gcc/home/dasha/tophat_out/emtab1/2872_2_1/" "/target/gpfs2/gcc/home/dasha/tophat_out/emtab1/2963_6_1/" "/target/gpfs2/gcc/home/dasha/tophat_out/emtab1/2992_5_1/" "/target/gpfs2/gcc/home/dasha/tophat_out/emtab1/2354_1_1/" "/target/gpfs2/gcc/home/dasha/tophat_out/emtab1/3122_7_1/" "/target/gpfs2/gcc/home/dasha/tophat_out/emtab1/3125_1_1/" "/target/gpfs2/gcc/home/dasha/tophat_out/emtab1/3125_7_1/" "/target/gpfs2/gcc/home/dasha/tophat_out/emtab1/2420_1_1/" "/target/gpfs2/gcc/home/dasha/tophat_out/emtab1/2420_2_1/" "/target/gpfs2/gcc/home/dasha/tophat_out/emtab1/2420_3_1/" "/target/gpfs2/gcc/home/dasha/tophat_out/emtab1/2421_5_1/" "/target/gpfs2/gcc/home/dasha/tophat_out/emtab1/2992_7_1/" "/target/gpfs2/gcc/home/dasha/tophat_out/emtab1/2527_7_1/" "/target/gpfs2/gcc/home/dasha/tophat_out/emtab1/3125_6_1/" "/target/gpfs2/gcc/home/dasha/tophat_out/emtab1/2589_8_1/" "/target/gpfs2/gcc/home/dasha/tophat_out/emtab1/2631_1_1/" "/target/gpfs2/gcc/home/dasha/tophat_out/emtab1/2781_3_1/" "/target/gpfs2/gcc/home/dasha/tophat_out/emtab1/2787_2_1/" "/target/gpfs2/gcc/home/dasha/tophat_out/emtab1/3125_2_1/")
for pathToBam in "${FILES[@]}"
do
#pathToBam='/target/gpfs2/gcc/home/dasha/tophat_out/emtab1/1382_1_1/'
echo "processing $pathToBam..."

#filtering reads: "Here “-F 1796” indicates that we will skip the sequence read that is unmapped (4), or the alignment is not primary (256), or it fails quality checks (512), or it is PCR duplicates (1024)"
/target/gpfs2/gcc/tools/samtools-0.1.8/samtools view -F 1796 -b ${pathToBam}accepted_hits.bam > ${pathToBam}tmp_filtered.bam 
/target/gpfs2/gcc/tools/samtools-0.1.8/samtools sort ${pathToBam}tmp_filtered.bam ${pathToBam}tmp_filtered.sorted 
/target/gpfs2/gcc/tools/samtools-0.1.8/samtools rmdup ${pathToBam}tmp_filtered.sorted.bam ${pathToBam}filtered.bam

#searching for intersections with annotation exons ("the option “-f 0.50” means at least 50% of the sequence reads need to overlap with an exon to be counted as an “overlap”")
#and counting reads per exons
/target/gpfs2/gcc/home/dasha/BEDTools-Version-2.13.4/bin/intersectBed \
-f 0.50 \
-abam ${pathToBam}filtered.bam \
-b /target/gpfs2/gcc/home/dasha/ref_data/exons_ensembl54.bed -wa -wb -bed -split | \
cut -f 7-10 | \
sort | \
uniq -c \
> ${pathToBam}exon_counts.txt

#sorting
tr -s ' ' <  ${pathToBam}exon_counts.txt | sort -k5 | awk 'BEGIN { FS = "[ \t:]+" } ;{ OFS = "\t" } ; { print $2,$6}' > ${pathToBam}exon_counts_sorted.txt
#counting reads per transcript
python /target/gpfs2/gcc/home/dasha/hapmapData/scripts/processExonCounts.py ${pathToBam}exon_counts_sorted.txt
#python /Users/dashazhernakova/Documents/UMCG/cluster/scripts/count_tr_reads.py ${pathToBam}exon_counts_sorted.txt

#removing temporary files
rm ${pathToBam}exon_counts_sorted.txt
rm ${pathToBam}tmp_filtered.sorted.bam
rm ${pathToBam}tmp_filtered.bam
done
finish=$(date +"%T")
echo "Started at: $start"
echo "Finished at: $finish"
 
#./samtools view -F 1796 -bS /Users/dashazhernakova/Documents/UMCG/hapmapData/1382_1_1/bwa/1382_1.sam | ./samtools sort - - | ./samtools rmdup - /Users/dashazhernakova/Documents/UMCG/hapmapData/1382_1_1/bwa/1382_1_filtered2.bam
#./intersectBed -f 0.50 -abam /Users/dashazhernakova/Documents/UMCG/hapmapData/1382_1_1/bwa/1382_1_filtered.bam -b /Users/dashazhernakova/Documents/UMCG/articles/exons_ensembl54.bed -wa -wb -bed -split | cut -f 7-10 | sort | uniq -c > /Users/dashazhernakova/Documents/UMCG/hapmapData/1382_1_1/bwa/exon_counts.txt
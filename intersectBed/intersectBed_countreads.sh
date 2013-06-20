#!/bin/bash

path="${1}*/"
if [ -z $1 ];then
 echo "no input path given"

else
start=$(date +"%T")
echo "Started at: $start"
#path=/target/gpfs2/gcc/home/dasha/tophat_out/mtab1_hg19/*/
for pathToBam in $path
do
 
 #if [ ! -e ${pathToBam}exon_counts.txt ];then
 echo "intersectBed: processing $pathToBam"
 gunzip ${pathToBam}accepted_hits.filtered.bam.gz
 #searching for intersections with annotation exons ("the option “-f 0.50” means at least 50% of the sequence reads need to overlap with an exon to be counted as an “overlap”")
 #and counting reads per exons
 #-f 0.50 \
 intersectBed \
 -abam ${pathToBam}accepted_hits.filtered.bam \
 -b /Users/dashazhernakova/Documents/UMCG/hg19/hg19_exons.bed lincRNAs_transcripts.bed -bed -split | \
 awk 'BEGIN { FS = "[\t]|(:exon:)" } ;{ OFS = "\t" } ; { print $4,$10 }' \
 > ${pathToBam}reads2transcr.txt
#fi
 #echo "sorting ${pathToBam}exon_counts.txt"
 #sorting
 #tr -s ' ' <  ${pathToBam}exon_counts.txt | sort -k5 | awk 'BEGIN { FS = "[ \t:]+" } ;{ OFS = "\t" } ; { print $2,$6}' > ${pathToBam}exon_counts_sorted.txt
 
 #counting reads per transcript
 #echo "counting reads per transcript"
 #/cm/shared/apps/sunjdk/jdk1.6.0_21/bin/java \
#-classpath /Users/dashazhernakova/Documents/UMCG/cluster/scripts/intersectBed/ \
#ProcessExonCounts \
#${pathToBam}exon_counts_sorted.txt 
 #removing temporary files
 #rm ${pathToBam}exon_counts_sorted.txt
done
finish=$(date +"%T")
echo "Started at: $start"
echo "Finished at: $finish"
fi

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
 
 #if [ ! -e ${pathToBam}exonicReads_counts.txt ];then
  echo "intersectBed: processing $pathToBam"


  intersectBed \
  -bed \
  -f 0.50 \
  -abam ${pathToBam}accepted_hits.filtered.bam \
  -b /Users/dashazhernakova/Documents/UMCG/hg19/hg19_exons.bed \
  -wa \
  -u \
  > ${pathToBam}exonicReads_counts.txt
  
  #cut -f4 ${pathToBam}exonicReads_counts.txt | uniq > ${pathToBam}exonicReads_counts_uniq.txt
 #else
 # echo "file ${pathToBam}exonicReads_counts.txt exists, skipping"
 #fi
done
finish=$(date +"%T")
echo "Started at: $start"
echo "Finished at: $finish"
fi
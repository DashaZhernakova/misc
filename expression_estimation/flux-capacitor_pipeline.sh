#!/bin/bash

#better sort the gtf and bed12
path=/Users/dashazhernakova/Documents/UMCG/data/lincRNA_Sebo/mappedData/*/

for dir in $path
do
 f=${dir}accepted_hits.filtered
 if [ -f ${f}.bam ]; then
 echo "Started processing $f"
 #flux needs the mappings file have the extension .bed
 bamToBed -bed12 -i ${f}.bam > ${f}.bed
 /Users/dashazhernakova/barna/barna.capacitor/build/distributions/flux-capacitor-1.2.3-SNAPSHOT/bin/flux-capacitor \
 -i ${f}.bed \
 -a /Users/dashazhernakova/Documents/UMCG/hg19/genomicIntervals/gtf/Homo_sapiens.GRCh37.70.gtf \
 -o ${f}.flux.gtf \
 -m SINGLE \
 -d SIMPLE \
 -r true
 else
 echo "No such file: ${f}.bam"
 fi
done
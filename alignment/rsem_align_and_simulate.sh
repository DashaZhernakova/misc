#!/bin/bash

path=${1}*argonne.fastq.gz
simupath=/Users/dashazhernakova/Documents/UMCG/simulation/
for f in $path
do
#f=/Users/dashazhernakova/Documents/UMCG/pickrell_data/NA19239_argonne.fastq.zip
 fq=${f//.fastq.zip/}
 curdir=${simupath}${fq//*\//}/
 echo " processing $curdir"
 #if [ ! -d "$curdir" ]
 #then

 
 mkdir $curdir
 echo "MAQ simulation"
 echo "${f//.zip/}"
 #/Applications/RNA-Seq/maq-0.7.1/maq simutrain \
 #${curdir}simupars.dat \
 #${f//.zip/}
 
 mv ${curdir}reads1.fastq ${curdir}reads1_old.fastq
 mv ${curdir}reads2.fastq ${curdir}reads2_old.fastq

 /Applications/RNA-Seq/maq-0.7.1/maq simulate \
 ${curdir}reads1.fastq \
 ${curdir}reads2.fastq \
 /Users/dashazhernakova/Documents/UMCG/hg19/chr6_cdna_noSmall.fa \
 ${curdir}simupars.dat

 echo "aligning & estimating expression"
 /Applications/RNA-Seq/rsem-1.1.18-modified/rsem-calculate-expression \
 -p 6 \
 --paired-end \
 ${curdir}reads1.fastq \
 ${curdir}reads2.fastq \
 /Users/dashazhernakova/Documents/UMCG/hg19/bowtie_index_6/bowtie_index_6 \
 ${curdir}new_sample

 #else
 # echo "file exists"
 #fi
done
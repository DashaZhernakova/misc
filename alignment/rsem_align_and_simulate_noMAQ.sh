#!/bin/bash

#simupath=/Users/dashazhernakova/Documents/UMCG/simulation_new/
path=${1}$2
simupath=$3
fname_pattern=$4
for f in $path
do
 gunzip $f
 #f=/Users/dashazhernakova/Documents/UMCG/pickrell_data/NA18486_argonne.fastq.gz
 fq=${f//.fastq.gz/}
 
 echo "Aligning $fq"
 curdir=${simupath}${fq//*\//}/
 mkdir $curdir
 /Applications/RNA-Seq/rsem-1.1.18-modified/rsem-calculate-expression \
 -p 8 \
 ${fq}.fastq \
 /Users/dashazhernakova/Documents/UMCG/hg19/bowtie_index_6/bowtie_index_6 \
 ${curdir}${fname_pattern}
 
 gzip ${fq}.fastq
 
 echo "Simulating reads"
 /Applications/RNA-Seq/rsem-1.1.18-modified/rsem-simulate-reads \
 /Users/dashazhernakova/Documents/UMCG/hg19/bowtie_index_6/bowtie_index_6 \
 ${curdir}${fname_pattern}.stat/${fname_pattern}.model \
 ${curdir}${fname_pattern}.isoforms.results \
 0.001 \
 400000 \
 ${curdir}read
done 

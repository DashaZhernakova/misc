#!/bin/bash

in=/Users/dashazhernakova/Documents/UMCG/data/fromCleo/rawData/121113_SN163_0482_BC1B32ACXX_L8_ACTTGA.fq
out=/Users/dashazhernakova/Documents/UMCG/data/fromCleo/rawData/121113_SN163_0482_BC1B32ACXX_L8_ACTTGA_trimmed.fq
adapters=/Applications/RNA-Seq/FastQC/Contaminants/contaminant_list.fa

java -classpath /Applications/RNA-Seq/Trimmomatic-0.22/trimmomatic-0.22.jar \
org.usadellab.trimmomatic.TrimmomaticSE \
-threads 4 \
$in \
$out \
ILLUMINACLIP:${adapters}:2:40:15 \
MINLEN:95
#!/bin/bash

f=$1

tail -n +2 $f \
| awk 'BEGIN {FS="\t"}; {OFS="\t"}; {if ($7 == "-1") $7 = "-"; else $7 = "+"}; {print $1, $2 - 1, $3, $4 ":" $5 ":" $6, ".", $7}' \
| sort -k1,1n -k2,2n \
| mergeBed -nms -i stdin \
> ${f}.merged.tmp

/Users/dashazhernakova/Documents/UMCG/cluster/scripts/annotationFileProcessing/mergedBed_to_gtf2.py \
${f}.merged.tmp \
${f} | \
sort -k1,1n -k4,4n

#/Users/dashazhernakova/Documents/UMCG/cluster/scripts/annotationFileProcessing/cutStrangeChrBed.py <file>

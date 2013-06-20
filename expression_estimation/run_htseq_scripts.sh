#!/bin/bash

files='/Users/dashazhernakova/Documents/UMCG/hapmapData/tophat/*/accepted_hits.sam'
i=0
for f in $files
do
 if [ $i -lt 10 ]
 then
  flist=$flist" \"$f\""
  i=$(( $i + 1 ))
 else
  echo "flist=$flist"
  echo "/Users/dashazhernakova/Documents/UMCG/cluster/scripts/htseq-count_pipeline.sh $flist"
  flist=""
  i=0
 fi
done
#!/bin/bash

path=/Users/dashazhernakova/Documents/UMCG/1000g/Chr*
out=/Users/dashazhernakova/Documents/UMCG/1000g/allSNPMappings_b37.txt
touch $out
for f in $path
do
 echo $f
 cat $f >> $out
done

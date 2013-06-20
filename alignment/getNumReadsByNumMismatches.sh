#!/bin/bash
samfile=$1
outfile=${samfile//.sam/numReadsByNumMismatches}

echo "Output files:"
echo "${outfile}.txt"
echo "${outfile}.pdf"

getNumMismatchesCounts.py \
${samfile} \
> ${outfile}.txt

plotNumMappedReadsByNumMismatches.R ${outfile}.txt ${outfile}.pdf
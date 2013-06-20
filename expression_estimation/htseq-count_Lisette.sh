#!/bin/bash

samtools sort -n \
/Users/dashazhernakova/Documents/UMCG/data/Lisette/mappedData/A/249/249_sorted.bam \
/Users/dashazhernakova/Documents/UMCG/data/Lisette/mappedData/A/249/249_sortedbyname

samtools view -h -F 1792 \
/Users/dashazhernakova/Documents/UMCG/data/Lisette/mappedData/A/249/249_sortedbyname.bam | \
htseq-count -m intersection-nonempty -s no - \
/Users/dashazhernakova/Documents/UMCG/pig/Sus_scrofa.Sscrofa10.2.71.gtf \
> /Users/dashazhernakova/Documents/UMCG/data/Lisette/mappedData/A/249/249_htseq_counts.txt

samtools sort -n \
/Users/dashazhernakova/Documents/UMCG/data/Lisette/mappedData/C/153/153_sorted.bam \
/Users/dashazhernakova/Documents/UMCG/data/Lisette/mappedData/C/153/153_sortedbyname

samtools view -h -F 1792 \
/Users/dashazhernakova/Documents/UMCG/data/Lisette/mappedData/C/153/153_sortedbyname.bam | \
htseq-count -m intersection-nonempty -s no - \
/Users/dashazhernakova/Documents/UMCG/pig/Sus_scrofa.Sscrofa10.2.71.gtf \
> /Users/dashazhernakova/Documents/UMCG/data/Lisette/mappedData/C/153/153_htseq_counts.txt
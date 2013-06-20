#!/bin/bash

java -Xmx4g -jar \
/Users/dashazhernakova/Documents/NetBeansProjects/CoordinatesConverter/dist/CoordinatesConverter.jar \
--mode chooseChrFromFq \
--fq /Users/dashazhernakova/Documents/UMCG/pickrell_data/ \
--sam /Users/dashazhernakova/Documents/UMCG/pickrell_data/tophat_out/ \
--aln_pattern accepted_hits.filtered.sam.gz \
--id_pattern _yale \
--chr 6
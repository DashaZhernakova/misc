#!/bin/bash

java -Xmx4g \
-jar /Users/dashazhernakova/Documents/NetBeansProjects/QualityControl/dist/QualityControl.jar \
/Users/dashazhernakova/Documents/UMCG/pickrell_data/ \
/Users/dashazhernakova/Documents/UMCG/pickrell_data/tophat_out/ \
false \
> /Users/dashazhernakova/Documents/UMCG/pickrell_data/statistics.txt
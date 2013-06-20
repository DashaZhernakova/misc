affy_log<-read.table("/Users/dashazhernakova/Documents/UMCG/GeneticalGenomicsDatasets/new/deepSAGE_tag/array/expression_table_log.txt", header=T, row.names=1)
affy_log_qn<-read.table("/Users/dashazhernakova/Documents/UMCG/GeneticalGenomicsDatasets/Peter-Bram_array_data/eQTLmapping/expression_table.txt.QuantileNormalized.Log2Transformed.txt", header=T, row.names=1)
dS_raw<-read.table("/Users/dashazhernakova/Documents/UMCG/GeneticalGenomicsDatasets/new/deepSAGE_tag/tagwise_expression_table_SNP_in_recognition_sequence_tags_excluded.txt", header=T, row.names=1)
dS_log_qn<-read.table("/Users/dashazhernakova/Documents/UMCG/GeneticalGenomicsDatasets/new/deepSAGE_tag/tagwise_expression_table_SNP_in_recognition_sequence_tags_excluded.txt.QuantileNormalized.Log2Transformed.txt", header=T, row.names=1)
#check whether IDs in same order
identical(colnames(affy), colnames(dS))

intersection<-read.table("/Users/dashazhernakova/Documents/UMCG/GeneticalGenomicsDatasets/new/deepSAGE_tag/array_vs_tags/intersection_stranded.txt")

#test if there is difference in average gene expression of lincRNA genes vs protein-coding genes (independent of eQTL mapping)
linc<-read.table("/Users/dashazhernakova/Documents/UMCG/GeneticalGenomicsDatasets/fromTophat_coverageBed_Montgomery/lincRNA_genes_avg_montgomery.txt", sep="\t")
prot<-read.table("/Users/dashazhernakova/Documents/UMCG/GeneticalGenomicsDatasets/fromTophat_coverageBed_Montgomery/protein_coding_genes_avg_montgomery.txt", sep="\t")
wilcox.test(linc[,2],prot[,2])
boxplot(linc[,2],prot[,2], log="y")

linc<-read.table("/Users/dashazhernakova/Documents/UMCG/GeneticalGenomicsDatasets/Yale+Argonne/lincRNA_genes_avg_pickrell.txt")
prot<-read.table("/Users/dashazhernakova/Documents/UMCG/GeneticalGenomicsDatasets/Yale+Argonne/protein_coding_genes_avg_pickrell.txt")
wilcox.test(linc[,2],prot[,2])
boxplot(linc[,2],prot[,2], log="y")

linc<-read.table("/Users/dashazhernakova/Documents/UMCG/GeneticalGenomicsDatasets/deepSAGE_transcr/lincRNA_genes_avg_transcr.txt", sep="\t")
prot<-read.table("/Users/dashazhernakova/Documents/UMCG/GeneticalGenomicsDatasets/deepSAGE_transcr/protein_coding_genes_avg_transcr.txt", sep="\t")
wilcox.test(linc[,2],prot[,2])
boxplot(linc[,2],prot[,2], log="y")

linc<-read.table("/Users/dashazhernakova/Documents/UMCG/GeneticalGenomicsDatasets/deepSAGE_tag/lincRNA_genes_avg_tag.txt", sep="\t")
prot<-read.table("/Users/dashazhernakova/Documents/UMCG/GeneticalGenomicsDatasets/deepSAGE_tag/protein_coding_genes_avg_tag.txt", sep="\t")
boxplot(linc[,2],prot[,2], log="y")
wilcox.test(linc[,2],prot[,2])

#look on average expression of eQTL probes vs p-value

expr <- read.table("/home/marijke/Data/GeneExpression/Pritchard_2007/qtl_analysis/expression/ExpressionData.txt", sep="\t", header=TRUE,row.names=1)
meth <- read.table("/home/marijke/Data/Methylation/Pritchard_2010/qtl_analysis/renamed/expression/batchNormalization/ExpressionData.txt", sep="\t", header=TRUE,row.names=1)

# get common column names
meth_ids <- colnames(meth)
expr_ids <- colnames(expr)
common_ids <- meth_ids[which(meth_ids %in% expr_ids)]

# sort data on common column names
expr_sorted <- expr[,common_ids]
meth_sorted <- meth[,common_ids]

write.table(expr_sorted, file = "/home/marijke/Analyses/HapMap_integration/expressionData_sorted.txt", sep = "\t", col.names=NA)
write.table(meth_sorted, file = "/home/marijke/Analyses/HapMap_integration/methylationData_sorted.txt", sep = "\t", col.names=NA)

# read probe information for shared genes
exprProbes <- read.table("/home/marijke/Analyses/HapMap_integration/expressionProbesSharedGenes.txt", sep="\t", header=FALSE)
methProbes <- read.table("/home/marijke/Analyses/HapMap_integration/methylationProbesSharedGenes.txt", sep="\t", header=FALSE)
colnames(exprProbes) <- c("gene","probe")
colnames(methProbes) <- c("gene","probe")

# get unique gene names
genes <- exprProbes$gene
genes <- unique(genes)

corrResults <- c()

# loop through genes and combine intensity valyes for probes of the same gene
for (i in 1:length(genes)) {
  
    # get probes for the
    selProbesExpr <- exprProbes$probe[which(exprProbes$gene == genes[i])]
    selProbesMeth <- methProbes$probe[which(methProbes$gene == genes[i])]
    
    # get intensity values for the probes
    selValuesExpr <- expr_sorted[which(rownames(expr_sorted) %in% selProbesExpr),]
    selValuesMeth <- meth_sorted[which(rownames(meth_sorted) %in% selProbesMeth),]
    
    # get average of values if more than 1 probe
    # check expression probes
    if (length(selProbesExpr) > 1) {
        finalExprValues <- apply(selValuesExpr, 2, mean)
    } else {
        finalExprValues <- selValuesExpr
    }
    
    # check methylation probes
    if (length(selProbesMeth) > 1) {
        finalMethValues <- apply(selValuesMeth, 2, mean)
    } else {
        finalMethValues <- selValuesMeth
    }
    
    # calculate the correlation between the final values
    correl <- cor(c(as.matrix(finalMethValues)),c(as.matrix(finalExprValues)),method = c("pearson"))
    result <- c(gene = paste(genes[i],"",sep=""), cor = as.numeric(correl))
    corrResults <- rbind(corrResults,result)
}

# sort by correlation and write to file
corrSorted <- corrResults[order(as.numeric(corrResults[,"cor"])),]
rownames(corrSorted) <- 1:length(genes)
write.table(corrSorted, file = "/home/marijke/Analyses/HapMap_integration/geneCorrelationsMethExprPearson_sorted.txt", sep = "\t",col.names=NA, quote=FALSE)


# plots the density (frequency) distribution for the correlations
data <- read.table(file = "/home/marijke/Analyses/HapMap_integration/geneCorrelationsMethExprPearson_sorted.txt", sep="\t", header=TRUE, row.names=1)
pdf(file = "/home/marijke/Analyses/HapMap_integration/geneCorrelationsMethExprPearson_freqDistr.pdf")  
hist(data[,2], freq=T, main="Correlation distribution (pearson)",xlab="Correlation (pearson)",ylab="# genes",xlim=c(-1,1))
dev.off()


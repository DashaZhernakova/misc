Design <- data.frame(
   names = c("148", "401"),  
   filenames = c("148_htseq_counts.txt","401_htseq_counts.txt"),
   condition = c( "fat", "lean") )
Design

countdata <- newCountDataSetFromHTSeqCount(Design, directory="C:/PhD/RNASeq") 
cds = estimateSizeFactors( countdata )
sizeFactors( cds )
head( counts( cds, normalized=TRUE ) )
cds = estimateDispersions( cds , method="blind", sharingMode="fit-only")
str( fitInfo(cds) )
plotDispEsts( cds )
head( fData(cds) )

res = nbinomTest( cds, "fat", "lean" )
head(res)
plotMA(res)
hist(res$pval, breaks=100, col="skyblue", border="slateblue", main="")
resSig = res[ res$padj < 0.1, ]
head( resSig[ order(resSig$pval), ] )
head( resSig[ order( resSig$foldChange, -resSig$baseMean ), ] )
head( resSig[ order( -resSig$foldChange, -resSig$baseMean ), ] )

write.csv( res, file="Differential Expression results.csv" )

cdsFullBlind = estimateDispersions( cds, method = "blind" , sharingMode="fit-only")
vsdFull = varianceStabilizingTransformation( cdsFullBlind )
library("RColorBrewer")
library("gplots")
select = order(rowMeans(counts(cds)), decreasing=TRUE)[1:30]
hmcol = colorRampPalette(brewer.pal(9, "GnBu"))(100)
heatmap.2(exprs(vsdFull)[select,], col = hmcol, trace="none", margin=c(10, 6))
heatmap.2(counts(cds)[select,], col = hmcol, trace="none", margin=c(10,6))

print(plotPCA(vsdFull, intgroup=c("condition")))
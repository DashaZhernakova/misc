#!/usr/bin/Rscript
args <- commandArgs(TRUE)
#path="/Users/dashazhernakova/tmp.txt"
#outpath="/Users/dashazhernakova/tmp.pdf"
path=args[1]
outpath=args[2]
data <- read.table(path, header=F, sep="\t")
pdf(outpath)
bar<-barplot(data$V2, names.arg=data$V1, xlab = "Number of mismatches", ylab = "Number of mapped reads", col="Light Steel Blue")
text(bar, rowMeans(data), data$V2)
dev.off()
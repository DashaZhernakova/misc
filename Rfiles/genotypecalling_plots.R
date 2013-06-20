table <-read.table("/Users/dashazhernakova/Documents/UMCG/data/geuvadis/mappedData_masked/ERR188032/reads_unique_hits.sorted.mpileup.cov5.snvmix.stats_new", row.names=1, header=T)

#exonic SNPs have higher coverage:
plot(log(table$Overall_coverage), pch=19,cex=0.3, col=table$SNP_is_exonic)
boxplot(log(table$Overall_coverage) ~ as.factor(table$SNP_is_exonic), col=c("blue","orange"), varwidth=TRUE, xlab = "SNP is exonic?", ylab = "Log(coverage)")

#exonic SNPs have higher CR and MAF?
boxplot(table$CR ~ as.factor(table$SNP_is_exonic), col=c("blue","orange"), varwidth=TRUE, xlab = "SNP is exonic?", ylab = "CR", main = "CR for exonic vs intronic SNPs")
boxplot(table$MAF ~ as.factor(table$SNP_is_exonic), col=c("blue","orange"), varwidth=TRUE, xlab = "SNP is exonic?", ylab = "MAF", main = "MAF for exonic vs intronic SNPs")
boxplot(table$HWEP ~ as.factor(table$SNP_is_exonic), col=c("blue","orange"), varwidth=TRUE, xlab = "SNP is exonic?", ylab = "HWEP", main = "HWEP for exonic vs intronic SNPs")

# number of exonic SNPs by SNVMix Prob
pr_factor <- cut(table$SNVMix_probability, breaks = c(0, 0.5, 0.6, 0.7, 0.8, 0.9, 0.95, 0.97, 1), include.lowest = TRUE)
ggplot(table, aes(x=pr_factor, fill=factor(table$SNP_is_exonic))) + geom_bar(position="fill") + xlab("SNVMix genotype probability bins") + scale_fill_brewer("SNP is exonic?", palette="Paired")

#concordant SNPs have higher coverage:
boxplot(log(table$Overall_coverage) ~ as.factor(table$Genotypes_concordant), col=c("blue","orange"), varwidth=TRUE)

#concordant genotypes have higher SNVMix probability:
boxplot(table$SNVMix_probability ~ as.factor(table$Genotypes_concordant), col=c("blue","orange"), varwidth=TRUE, xlab = "Genotypes concordant?", ylab = "SNVMix probability")
plot(density(subset(table$SNVMix_probability, table$Genotypes_concordant == 1)), col='blue')
lines(density(subset(table$SNVMix_probability, table$Genotypes_concordant == 0)), col='red')

ggplot(table, aes(x=pr_factor, fill=factor(table$Genotypes_concordant))) + geom_bar(position="fill") + xlab("SNVMix genotype probability bins") + scale_fill_brewer("Genotypes concordant?", palette="Paired")
ggplot(table, aes(table$SNVMix_probability, fill = as.factor(table$Genotypes_concordant))) + geom_density(alpha = 0.2) + scale_fill_manual("Called genotypes\nare concorant with \nDNA-seq genotypes?",values=c("blue","green")) + xlab("SNVMix genotype probability")
qplot(table$SNVMix_probability, data = table, geom = "histogram", binwidth = 0.01, xlim = c(0.5, 1), fill = as.factor(table$Genotypes_concordant))

plot(table$SNVMix_probability,jitter(table$Genotypes_concordant), pch=19,cex=0.3, col=table$SNP_is_exonic+1)



#concordant genotype have higher CR?
boxplot(table$CR ~ as.factor(table$Genotypes_concordant))
tapply(table$CR, table$Genotypes_concordant, mean, na.rm=TRUE)
wilcox.test(table$CR ~ as.factor(table$Genotypes_concordant), na.rm=TRUE)

#Coverage correlates with CR:
CRfactor<-cut(table$CR, breaks=2)
boxplot(log(table$Overall_coverage)~as.factor(CRfactor))

cov_log <- cut(log(table$Overall_coverage), breaks = 100)
plot(cov_log, table$CR, na.rm=TRUE, pch=19,cex=0.3, col=table$SNP_is_exonic + 1)

#Logistic regression predicting concordance:
table2 <-read.table("/Users/dashazhernakova/Documents/UMCG/data/geuvadis/mappedData_masked/ERR188032/reads_unique_hits.sorted.mpileup.cov5.snvmix.stats_2", row.names=1, header=T)
glmod <- glm(table2$Genotypes_concordant ~ log(table2$Overall_coverage), family="binomial")
summary(glmod)
plot(log(table2$Overall_coverage),glmod$fitted)
#odds ratio
exp(glmod$coeff)
#as confidence intervals > 1 => significance increases
exp(confint(glmod))



#separate concordant vs non-concordant
false <- subset(table, table$Genotypes_concordant == 0)
true <- subset(table, table$Genotypes_concordant == 1)

plot(log(false$Overall_coverage), jitter(false$SNP_is_exonic), pch=19,cex=0.1)
plot(log(true$Overall_coverage), jitter(true$SNP_is_exonic), pch=19,cex=0.1)

plot(log(true$Overall_coverage), true$SNVMix_probability, pch=19,cex=0.05, col=true$SNP_is_exonic+1)
plot(log(false$Overall_coverage), false$SNVMix_probability, pch=19,cex=0.05, col=false$SNP_is_exonic+1)


#make summary table with counts
library(plyr)

ddply(table, .(Genotypes_concordant, SNP_is_exonic, Overall_coverage > 1000, Overall_coverage > 100, Overall_coverage > 50, Overall_coverage > 10, SNVMix_probability > 0.9, SNVMix_probability > 0.95, SNVMix_probability > 0.97), summarize, n = length(SNVMix_probability), meanPr=mean(SNVMix_probability), meanBQ=rowMeans(cbind(Average_base_quality_ref, Average_base_quality_alt)), meanCR=mean(CR, na.rm=TRUE), meanMAF=mean(MAF, na.rm=TRUE), meanHWEP = mean(HWEP, na.rm=TRUE))
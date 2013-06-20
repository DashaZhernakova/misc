
setEPS()
postscript("/Users/dashazhernakova/Documents/UMCG/GCcontent_all.eps")
par(mfrow=c(2,2))

f<-read.table("/Users/dashazhernakova/Documents/UMCG/pickrell_data/GCcontent_yale.txt", header=TRUE,sep="\t")
plot(f$GC,1-f$Comp1,, xlab="GC percentage", ylab="PC1 eigenvector coefficients", main="Pickrell et al. (Yale) dataset", pch=19)
abline(fit<-lm(1-f$Comp1~f$GC), col = 'blue')
#text(48, 0.1, paste("R2 = ",format(summary(fit)$adj.r.squared, digits=2)), pos = 4, col = 'blue')
#legend("topleft", paste("p = ",format(rcorr(f$Comp1,f$GC)$P[1,2], digits=2)), text.col='blue',bty='n')
cor(f$GC,1-f$Comp1,method="pearson")
f<-read.table("/Users/dashazhernakova/Documents/UMCG/pickrell_data/GCcontent_argonne.txt", header=TRUE,sep="\t")
plot(f$GC,f$Comp1,, xlab="GC percentage", ylab="PC1 eigenvector coefficients", main="Pickrell et al. (Argonne) dataset", pch=19)
abline(fit<-lm(f$Comp1~f$GC), col = 'blue')
#text(65, 0, paste("R2 = ",format(summary(fit)$adj.r.squared, digits=2)), pos = 4, col = 'blue')
#legend("topleft", paste("p = ",format(rcorr(f$Comp1,f$GC)$P[1,2], digits=2)), text.col='blue',bty='n')
cor(f$GC,1-f$Comp1,method="pearson")
f<-read.table("/Users/dashazhernakova/Documents/UMCG/hapmapData/GCcontent.out", header=TRUE,sep="\t")
plot(f$GC,1-f$Comp1,, xlab="GC percentage", ylab="PC1 eigenvector coefficients", main="Montgomery et al. dataset", pch=19)
abline(fit<-lm(1-f$Comp1~f$GC), col = 'blue')
#text(50,0.18, paste("R2 = ",format(summary(fit)$adj.r.squared, digits=2)), pos = 4, col = 'blue')
#legend("topleft", paste("p = ",format(rcorr(f$Comp1,f$GC)$P[1,2], digits=2)), text.col='blue',bty='n')
cor(f$GC,1-f$Comp1,method="pearson")
eigen.tr <- read.table("/Users/dashazhernakova/Documents/UMCG/ForLude_tagwise_hg19/PCtranscriptwise/transcriptwise_expression_table_SNP_in_recognition_sequence_tags_excluded_txt_PCAOverSamplesEigenvectors.txt" , sep="\t", header=T , row.names=1)
metadata <-  read.table("/Users/dashazhernakova/Documents/UMCG/ForLude_tagwise_hg19/PCtranscriptwise/all_metadata.txt" , sep="\t", header=T)
metadata2 <-  metadata[as.character(metadata$ID)%in% rownames(eigen.tr),]
#check whether IDs in same order
identical(rownames(eigen.tr), as.character(metadata2$ID))

#select numeric values from metadata
metadata.num <- metadata2[,c(8, 12, 13, 17, 18, 25:45)]
cor.tr <- array(NA, dim=c(15, ncol(metadata.num)))
for (i in 1:15)
{
 for (j in 1:ncol(metadata.num))
 {
  cor.tr[i,j] <- cor(eigen.tr[,i], metadata.num[,j], use="complete.obs")
 }
}
colnames(cor.tr) <- colnames(metadata.num)
rownames(cor.tr) <- colnames(eigen.tr)[1:15]


#analyse also correlation with dinucleotide counts for
dinucl <- read.table("/Users/dashazhernakova/Documents/UMCG/ForLude_tagwise_hg19/PCtranscriptwise/dinuc_mean_freq_sample" , sep="\t", header=T)
dinucl2 <-  dinucl[rownames(dinucl)%in% as.character(metadata2$Lane),]
#check whether IDs in same order
identical(rownames(dinucl2), as.character(metadata2$Lane))  #TRUE

cor2.tr <- array(NA, dim=c(15, ncol(dinucl2)))
for (i in 1:15)
{
 for (j in 1:ncol(dinucl2))
 {
  cor2.tr[i,j] <- cor(eigen.tr[,i], dinucl2[,j], use="complete.obs")
 }
}
colnames(cor2.tr) <- colnames(dinucl2)
rownames(cor2.tr) <- colnames(eigen.tr)[1:15]
#For GC:
colnames(dinucl2)
# [1] "AA" "AT" "AC" "AG" "TA" "TT" "TC" "TG" "CA" "CT" "CC" "CG" "GA" "GT" "GC"
#[16] "GG"
GCcontent <- c(0,0,0.5,0.5,0,0,0.5,0.5,0.5,0.5,1,1,0.5,0.5,1,1)
GC <-   c()
for(i in 1:nrow(dinucl2))
{
 GC[i] <- sum(GCcontent*dinucl2[i,])
}

plot(GC, 1-eigen.tr[,1], xlab="GC percentage", ylab="PC1 eigenvector coefficients", main="NTR-NESDA dataset", pch=19)
abline(fit<-lm(1-eigen.tr[,1]~GC), col = 'blue')
#text(48, -0.06, paste("R2 = ",format(summary(fit)$adj.r.squared, digits=2)), pos = 4, col = 'blue')
#legend("topleft", paste("p = ",format(rcorr(f$Comp1,f$GC)$P[1,2], digits=2)), text.col='blue',bty='n')
dev.off()
cor(f$GC,1-f$Comp1,method="pearson")
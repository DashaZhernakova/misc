function(data){
  res <- matrix(0, ncol = length(data[1,]), nrow = length(data[1,]))
  row.names(res) <- names(data)
  colnames(res) <- names(data)
  dir <- matrix(0, ncol = length(data[1,]), nrow = length(data[1,]))
  row.names(dir) <- names(data)
  colnames(dir) <- names(data)
  for (i in 1:length(data[1,])){
    for (j in 1:length(data[1,])){
        ttest<-t.test(data[,i], data[,j])
        #ttest<-wilcox.test(data[,i], data[,j])
        res[i,j]=ttest$p.value
       dir[i,j]=sign(ttest$statistic)
    }
  }
  #print (dir)
  return (list(res=res,dir=dir))
}
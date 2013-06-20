function(data){
  res <- matrix(0, 1, nrow = length(data[1,]))
  row.names(res) <- names(data)
  
  for (i in 1:length(data[1,])){
      avg<-rowMeans(subset(data, select=-i))
      
      ttest<-t.test(data[,i], avg)
      res[i,j]=ttest$p.value
  }
  return (res)
}
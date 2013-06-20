function(data){
  res <- vector("numeric", nrow(data))
  
  for (i in 1:nrow(data)){
    res=2*pnorm(-abs(data[,4] - rowMeans(data))/apply(data,1,sd,na.rm=TRUE))
  }
  return (res)
}
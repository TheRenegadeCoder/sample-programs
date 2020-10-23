args<-commandArgs(TRUE)
if(length(args) > 0){
  a1 = args[1]
  # as.integer or as.numeric both..
  a = as.numeric(a1)
  if(!(is.na(a))){
    if(a %% 2 == 0){
      cat("Even")
    }else{
      cat("Odd")
    }
  }else{
  cat("Usage: please input a number")
}
} else{
  cat("Usage: please input a number")
}

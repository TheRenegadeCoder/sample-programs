# Accept input from Commandline, Check & Print If it's Odd or Even
# Using is.na instead of is.null, to avoid NA Coercion Warning
args<-commandArgs(TRUE)
if(length(args) > 0){
  a1 = args[1]
  # as.integer or as.numeric both..
  a = as.numeric(a1)
  # Suppress Warnings can't be put inside 
  if (is.na(a) == 0){
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

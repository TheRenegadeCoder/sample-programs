  args<-commandArgs(TRUE)
  if(length(args) > 0){
    a1 = args[1]
    a = as.integer(a1)
    if((is.na(a) != TRUE)) {
      if ( a == 0){
        cat("")
      } else{
        first = 0
        second = 1
        result = 0
        for (i in 1:a){
          result = first + second
          first = second
          second = result
          cat(i, ": ", result,"\n")
        }
      }
    }else{
    cat("Usage: please input the count of fibonacci numbers to output")
  }
  } else{
    cat("Usage: please input the count of fibonacci numbers to output")
  }

args<-commandArgs(TRUE)
if(length(args) > 0){
  if (args[1] != ""){
    len = length(args)
    array_string <- strsplit(args[1], "")[[1]]
    for (i in 1:len){
        if (i == 1){
          array_string[i] <- toupper(substr(array_string[i], 1, 1))
        }
        #Convert to Character Vector.... else prints with spaces in between 
        a = as.character(array_string)
        cat(a,fill = FALSE, sep = "")
    }
  }else{
    cat("Usage: please provide a string")
  }
}else{
    cat("Usage: please provide a string")
}

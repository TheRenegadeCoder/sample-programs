args<- commandArgs(TRUE)
if(length(args) > 0 ){
  if (args[1] != ""){
    splits <- strsplit(args, "")[[1]]
    reversed <- rev(splits)
    reversed <-as.character(rev(splits))
    j <- paste(reversed, collapse = '')
    cat(noquote(j))
  }
}

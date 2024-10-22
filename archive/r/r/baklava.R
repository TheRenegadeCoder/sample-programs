for (i in -10:10) {
  numSpaces = abs(i)
  s <- strrep(" ", numSpaces)
  s = paste0(s, strrep("*", 21 - 2 * numSpaces))
  cat(s, "\n", sep="")
}

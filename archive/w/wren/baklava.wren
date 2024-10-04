for (i in (-10..10)) {
  var numSpaces = (i >= 0) ? i : -i
  System.print(" " * numSpaces + "*" * (21 - 2 *numSpaces))
}

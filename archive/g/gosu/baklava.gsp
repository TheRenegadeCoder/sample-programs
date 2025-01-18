for ( n in -10..10) {
  var numSpaces = Math.abs(n)
  var numStars = 21 - 2 * numSpaces
  print(" ".repeat(numSpaces) + "*".repeat(numStars))
}

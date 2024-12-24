import strutils

for n in -10..10:
    var numSpaces: int = abs(n)
    var numStars: int = 21 - 2 * numSpaces
    echo repeat(" ", numSpaces), repeat("*", numStars)

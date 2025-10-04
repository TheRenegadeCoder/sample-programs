for i = -10 to 10
    numSpaces = fabs(i)
    see copy(" ", numSpaces) + copy("*", 21 - 2 * numSpaces) + nl
next

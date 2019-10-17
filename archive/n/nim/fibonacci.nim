# Fibonacci Sample Program in Nim
# Input the number of iterations as a command-line parameter
import os
import strutils

var n: BiggestUInt
try:
    n = paramStr(1).parseBiggestUInt
except IndexError, ValueError:
    echo "Usage: please input the count of fibonacci numbers to output"
    quit(1)

var previouspreviousInt: BiggestUInt
var previousInt: BiggestUInt = 0
var currentInt: BiggestUInt = 1

if n == 0:
    echo ""
    quit(0)

for i in 1..n:
    echo i, ": ", currentInt
    previouspreviousInt = previousInt
    previousInt = currentInt
    currentInt = previouspreviousInt + previousInt


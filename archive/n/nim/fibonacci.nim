# Fibonacci Sample Program in Nim
import strutils

echo "Input the number of iterations (n): "
var n = parseInt(readline(stdin))
echo "------------------------------`"

var previouspreviousInt: int
var previousInt: int = 0
var currentInt: int = 1

for i in 1..n:
    previouspreviousInt = previousInt
    previousInt = currentInt
    currentInt = previouspreviousInt + previousInt
    echo currentInt

echo "------------Done!-------------`"


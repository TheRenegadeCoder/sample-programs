# Fibonacci Sample Program in Nim
import strutils

echo "Input the number of iterations (n): "
let n = stdin.readline.parseBiggestUInt
echo "------------------------------`"

var previouspreviousInt: BiggestUInt
var previousInt: BiggestUInt = 0
var currentInt: BiggestUInt = 1

for i in 1..n:
    previouspreviousInt = previousInt
    previousInt = currentInt
    currentInt = previouspreviousInt + previousInt
    echo currentInt

echo "------------Done!-------------`"


#[ 
    Factorial in Nim
    This program calculates the factorial of a non-negative integer.
]#

import os
import strutils

const UsageMessage = "Usage: please input a non-negative integer"

proc factorial(n: int): int =
  # Calculates the factorial of n (n!).
  if n == 0:
    return 1
  
  var result = 1
  for i in 1..n:
    result *= i
  
  return result

# The main execution block:
block:
  # Check 1: No input argument provided.
  if paramCount() == 0:
    quit(UsageMessage, 1)

  let inputStr = paramStr(1)

  # Check 2: Invalid Input (Empty String or Not a Number)
  var n: int
  try:
    n = parseInt(inputStr)
  except:
    quit(UsageMessage, 1)

  # Check 3: Invalid Input (Negative Number)
  if n < 0:
    quit(UsageMessage, 1)

  # Print the calculated result.
  echo factorial(n)

# For reversing a string passed in as a parameter
import os
import strutils

var text: string
try:
    text = paramStr(1)
except IndexError:
    echo "Usage: please input a string to reverse"
    quit(1)

var reversed_text: string
for i in countdown(len(text)-1, 0):
  reversed_text = reversed_text & text[i]

echo reversed_text


# For reversing a string passed in as a parameter
import os
import strutils

var text: string
try:
    text = paramStr(1)
except IndexError:
    quit(0)

var reversed_text: string
for i in countdown(len(text)-1, 0):
  reversed_text = reversed_text & text[i]

echo reversed_text


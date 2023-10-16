fun print-row(n :: Number):
  spaces = string-repeat(" ", 10 - n)
  stars = string-repeat("*", (n * 2) + 1)
  print(spaces + stars + "\n")
end
  
range-by(0, 11, 1).each(print-row) 
range-by(9, -1, -1).each(print-row)
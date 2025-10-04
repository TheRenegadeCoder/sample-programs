function diamondStarPattern(height)
  for i = 1, height do -- loop for printing the upper half of the baklava
    for j = i, height - 1 do io.write(" ") end --to print the leading spaces
    for j = 1, (2*i-1) do io.write("*") end -- to print the * for the upper half
    io.write("\n") -- to move pointer to next line
  end
  for i = height - 1,1,-1 do -- loop for printing the lower half of the baklava
    for j = i, height - 1 do io.write(" ") end -- to print the spaces
    for j = 1, (2*i-1) do io.write("*") end --  to print the * for the lower half
    io.write("\n") -- to move pointer to next line
  end  
end

diamondStarPattern(11)

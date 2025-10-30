return (function()
  local i = 1
  
  while (i <= 100) do
    repeat
    local o = ""
    
    if ((i % 3) == 0) then
      o = (o .. "Fizz")
    end
    
    if ((i % 5) == 0) then
      o = (o .. "Buzz")
    end
    
    if (((i % 3) ~= 0) and ((i % 5) ~= 0)) then
      o = (o .. i)
    end
    
    print(o)
    i = (i + 1)
    until true
  end
  
  return {
    i = i,
  }
end)()
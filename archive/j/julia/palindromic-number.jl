#!/usr/bin/julia
function err() 
  println("Usage: please input a number")
end 

function palindrome_check(n)
  new_num = 0
  original = n
  while (n > 0)
    digit = n % 10
    new_num = new_num * 10 + digit 
    n ÷= 10
  end

  if(new_num == original)
      return "true"
  else
      return "false"
  end
end

try
   println(palindrome_check(parse(Int, ARGS[1])))
catch e
   err()
end

function err() 
  println("Usage: please input a non-negative integer")
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
   n = parse(Int, ARGS[1])
   if (n >= 0)
     println(palindrome_check(n))
   else
     err()
   end
catch e
   err()
end

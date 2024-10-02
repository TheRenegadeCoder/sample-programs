# return factorial of a non-negative number
if ARGV.empty?
  puts "Usage: please input a non-negative integer"
  exit
else
  begin
    string1 = ARGV[0]
    num = Integer(string1)
    rescue ArgumentError
    puts "Usage: please input a non-negative integer"
    exit
  end
  if num < 0
    puts "Usage: please input a non-negative integer"
    exit    
  end
  i = 1
  factorial = 1
  while i <= num
    factorial = factorial * i
    i += 1
  end
  print(factorial)
end  

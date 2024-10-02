# check if input is a valid prime number or a valid composite number
# if number is 0, 1 or even, print composite
#
# begin validations for empty input, non-number and negative number
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
# end validations for empty input, non-number and negative number
# Begin Edge cases
  if num == 0 || num == 1
    print("composite")
  elsif num == 2
    print("prime")
  elsif num % 2 == 0
    print("composite")
# End Edge cases
  else
  # Logic
  
  i = 3
  is_prime = true
  while i <= Math.sqrt(num)
    if num % i == 0
      is_prime = false
    end
    i += 2
  end
  if is_prime ==true
    print("prime")
  else
    print("composite")
  end
  end
end

# print true, if input is a non-negative palindrome number
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
  reverse_no = 0
  save = num 
  while (save > 0)

      last_digit = save % 10 
      reverse_no = (reverse_no *10) + last_digit
      save /=10     
  end
  if num == reverse_no
      print("true")
  else
      print("false")
  end

end

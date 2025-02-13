def josephus_problem(array, k, index)
    
end

def error()
  puts "Usage: please input the total number of people and number of people to skip."
end

if ARGV.length != 2
  error()
end

ARGV.each do |arg|
  if arg.match(/[a-zA-Z]/) || arg.empty? || 
    error()
  else
    num1 = ARGV[0].to_i
    num2 = ARGV[1].to_i

    array = [*1..num1]

    josephus_problem(array, num2, 0)
  end
end


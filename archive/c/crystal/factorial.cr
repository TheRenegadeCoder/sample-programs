begin
  if ARGV.empty?
    raise "Usage: please input a non-negative integer"
  end

  input = ARGV[0].to_i?

  if input.nil?
    raise "Usage: please input a non-negative integer"
  end

  input = input.not_nil!

  if input >= 0 && input <= 12
    puts factorial(input)
  elsif input > 12
    raise "#{input} is out of the reasonable bounds for calculation."
  else
    raise "Usage: please input a non-negative integer"
  end

rescue e
  puts e.message
end

def factorial(n)
  return 1 if n == 0
  n * factorial(n - 1)
end
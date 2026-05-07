def usage!
  abort("Usage: please input the count of fibonacci numbers to output")
end

def fibonacci(n)
  a, b = 1, 1

  n.times do |i|
    puts "#{i + 1}: #{a}"
    a, b = b, a + b
  end
end

input = ARGV.first
usage! if input.nil? || input.strip.empty?

begin
  num = Integer(input)
rescue ArgumentError
  usage!
end

usage! if num.negative?

fibonacci(num)

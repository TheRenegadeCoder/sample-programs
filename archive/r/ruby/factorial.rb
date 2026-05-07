def usage!
  abort("Usage: please input a non-negative integer")
end

input = ARGV.first

usage! if input.nil? || input.strip.empty?

begin
  num = Integer(input)
rescue ArgumentError
  usage!
end

usage! if num.negative?

puts (1..num).reduce(1, :*)

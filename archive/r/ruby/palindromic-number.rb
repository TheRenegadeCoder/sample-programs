def usage!
  abort("Usage: please input a non-negative integer")
end

number = Integer(ARGV.first, exception: false)

usage! if number.nil? || number.negative?

puts number.digits == number.digits.reverse

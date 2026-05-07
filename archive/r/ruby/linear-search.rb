def usage!
  abort('Usage: please provide a list of integers ("1, 4, 5, 11, 12") and the integer to find ("11")')
end

list_str, target_str = ARGV

usage! if [list_str, target_str].any? { it.to_s.strip.empty? }

numbers = list_str.split(",").map { Integer(it.strip) }
target = Integer(target_str)

puts numbers.include?(target)

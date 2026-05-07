input = ARGV.first.to_s

abort("Usage: please provide a string") if input.empty?

puts input.delete(" \t\r\n")

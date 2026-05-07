input = ARGV.join(" ").strip

abort("Usage: please provide a string") if input.empty?

puts input.split.map(&:length).max

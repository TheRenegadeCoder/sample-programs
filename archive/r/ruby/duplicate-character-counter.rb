input = ARGV.first.to_s

abort("Usage: please provide a string") if input.empty?

duplicates = input.each_char.tally.select { _2 > 1 }

if duplicates.empty?
  puts "No duplicate characters"
  return
end

duplicates.each { |char, count| puts "#{char}: #{count}" }

number = ARGV.first?.try(&.to_i64?)

if number.nil?
  puts "Usage: please input a number"
  exit 1
end

puts number.even? ? "Even" : "Odd"

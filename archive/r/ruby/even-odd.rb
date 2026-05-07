input = ARGV.first

abort("Usage: please input a number") if input.nil? || input.strip.empty?

begin
  num = Integer(input)
  puts num.even? ? "Even" : "Odd"
rescue ArgumentError
  warn "Usage: please input a number"
end

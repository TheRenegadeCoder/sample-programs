def capitalize_str(str)
  return str if str.empty?

  str[0].upcase + str[1..]
end

input = ARGV.first.to_s

if input.strip.empty?
  warn "Usage: please provide a string"
else
  puts capitalize_str(input)
end

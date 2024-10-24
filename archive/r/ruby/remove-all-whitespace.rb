if ARGV.length == 0 || ARGV[0] == ''
  puts 'Usage: please provide a string'
else
  a = ARGV[0].gsub(/ /, '').gsub! '\t', ''
  puts a
end

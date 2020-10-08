def capitalize_str(str)
    str.capitalize
end

if ARGV.length == 0 || ARGV[0] == ''
    puts 'Usage: Please provide a string'
else
    puts capitalize_str(ARGV[0])
end

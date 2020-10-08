def capitalize_str(str)
    s = str.split(' ')
    s[0][0] = s[0][0].upcase
    s.join(' ')
end

if ARGV.length == 0 || ARGV[0] == ''
    puts 'Usage: please provide a string'
else
    puts capitalize_str(ARGV[0])
end

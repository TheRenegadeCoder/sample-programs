if ARGV.length < 1
    puts "Usage: ruby reverse-string.rb [string]"
else
    string = ARGV[0]

    puts string.reverse
end
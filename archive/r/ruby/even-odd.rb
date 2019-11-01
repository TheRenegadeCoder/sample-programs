# Requirement https://sample-programs.therenegadecoder.com/projects/even-odd/
# Issue 1839

if ARGV.length < 1
    puts "Usage: please input a number"
else
    string1 = ARGV[0]
    num = Integer(string1)

    if num % 2 == 0
    	puts "Even"
    else
    	puts "Odd"
    end
end


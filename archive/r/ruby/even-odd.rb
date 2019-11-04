# Requirement https://sample-programs.therenegadecoder.com/projects/even-odd/
# Issue 1839
# Test Case 1: Send a String
# $ruby odd_even_1.rb nikhil
# Usage: please input a number
# Test Case 2: Empty Value
# $ ruby odd_even_1.rb
#Usage: please input a number

if ARGV.length < 1
    puts "Usage: please input a number"
else
    if ARGV.empty?
        puts "Usage: please input a number"
    end
    string1 = ARGV[0]
    num = Integer(string1)

    if num % 2 == 0
    	puts "Even"
    else
    	puts "Odd"
    end
end


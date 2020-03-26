# Requirement https://sample-programs.therenegadecoder.com/projects/even-odd/
# Issue 1839

if ARGV.empty?
# if ARGV.length < 1
    puts "Usage: please input a number"
    exit
else
    # if ARGV.empty?
    #     puts "Usage: please input a number"
    # end
    begin
    string1 = ARGV[0]
    num = Integer(string1)
    rescue ArgumentError
    puts "Usage: please input a number"
    exit
    end

    if num % 2 == 0
    	puts "Even"
    else
    	puts "Odd"
    end
end

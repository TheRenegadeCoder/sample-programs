USAGE = 'Usage: please provide a list of integers ("1, 4, 5, 11, 12") and the integer to find ("11")'


    if ARGV.length < 2
        puts USAGE
        return
    end
    
    # the first input (list of numbers)
    list_input = ARGV[0]
    #second input (number to find)
    target_input = ARGV[1]

    #check if the input is empty
    if list_input.strip.empty? || target_input.strip.empty?
        puts USAGE
        return
    end

    begin
        #split list by the commas, trim the spaces, then turn into intgers
        numbers = list_input.split(',').map { |s| s.strip.to_i }

        #convert second number to integer
        target = Integer(target_input)
    rescue ArgumentError
        # if conversion fails we show the usage message
        puts USAGE
        return
    end

    #track if we find the number
    found = false

    # go through each number in the list
    numbers.each do |n|
        if n == target
            found = true
            # stop searching once we find it
            break
        end
    end

    # print result as true or false
    if found
        puts "true"
    else
        puts "false"
    end





def longest_word_length(input)

    # Split the input by spaces
    words = input.split(" ")  

    # Start with 0 as the longest length
    max_length = 0        

    # Go through each word
    words.each do |word|       
      if word.length > max_length
        max_length = word.length
      end
    end
    
    # Return the length of the longest word
    max_length                 
  end

  # Check if the program has received input from the command line
  if ARGV.length > 0
    input_string = ARGV.join(" ")
    puts longest_word_length(input_string)
  else
    puts "Please provide an input string."
  end
  
  
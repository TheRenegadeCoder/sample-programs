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
  
  
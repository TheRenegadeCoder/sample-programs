def longest_word(sentence)
    # Converts string into an array of words
    words = sentence.split(" ")

    # Stores the longest word
    longest_word = ""

    # Iterate over each word
    words.each do |word|
        if word.length > longest_word.length
            # Update the longest word
            longest_word = word
        end
    end
    return longest_word
end

# Test and Output
sentence = "Swiftly running foxes"
output = longest_word(sentence)
puts "Longest word: #{output}" 
def longest_word(sentence)
    # Converts string into an array of words
    words = sentence.split(" ")
    # Will find the word the has the most length
    words.max_by { |word| word.length }
end

# Test and Output
sentence = ("Swiftly running foxes")
puts longest_word(sentence)
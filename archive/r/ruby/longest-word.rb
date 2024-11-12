# Source on Block Arguments: https://ruby-for-beginners.rubymonstas.org/blocks/arguments.html

def longest_word_length(sentence)
    # Converts string into an array of words
    words = sentence.split(" ")

    # Stores the word that has the longest length
    longest_length = 0

    # Iterate over each word
    words.each do |word|
        if word.length > longest_length
            # Update the longest word length
            longest_length = word.length
        end
    end
    return longest_length
end

# Test and Output
sentence = "Swiftly running foxes"
output = longest_word_length(sentence)
puts "Longest word length: #{output}" 

# Test 2
sentence2 = "Intricately interwoven \nphilosophical contemplations"
output2 = longest_word_length(sentence2)
puts "Longest word length: #{output2}"
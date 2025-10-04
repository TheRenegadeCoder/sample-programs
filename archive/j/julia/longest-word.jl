function longest_word_length(text::String)
    # Split on exactly the specified whitespace characters: space, tab, newline, carriage return
    words = split(text, r"[ \t\n\r]+")
    
    # Find the maximum length of the words array
    return maximum(length.(words))
end

# Command-line argument handling
if length(ARGS) == 0 || strip(ARGS[1]) == ""
    println("Usage: please provide a string")
    exit(1)
end

input_string = ARGS[1]
println(longest_word_length(input_string))

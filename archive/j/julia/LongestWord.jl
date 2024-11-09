const error_msg = "Usage: please provide a string"

if length(ARGS) != 1
    println(error_msg)
    exit(1)
end

input_string = replace(ARGS[1], r"[\n\t\r]" => " ")

if isempty(strip(input_string))
    println(error_msg)
    exit(1)
end

words = split(strip(input_string), " ")

longest_word_length = 0
for word in words
    if length(word) > longest_word_length
        longest_word_length = length(word)
    end
end

println(longest_word_length)

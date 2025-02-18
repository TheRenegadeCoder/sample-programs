if #arg < 1 then
    print("Usage: please provide a string")
    os.exit(1)
end

local input = arg[1]

function longest_word_length(str)
    local max_length = 0
    local found_word = false

    for word in string.gmatch(str, "%S+") do
        found_word = true
        local length = #word  
        if length > max_length then
            max_length = length  
        end
    end

    if not found_word then
        print("Usage: please provide a string")
        os.exit(1)
    end

    return max_length  
end


print(longest_word_length(input))
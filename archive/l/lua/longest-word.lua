if #arg < 1 then
    print("Usage: please provide a string")
    os.exit(1)
end

local input = arg[1]

function longest_word_length(str)
    local max_length = 0

    for word in string.gmatch(str, "%S+") do
        local length = #word  
        if length > max_length then
            max_length = length  
        end
    end

    return max_length  
end


print(longest_word_length(input))
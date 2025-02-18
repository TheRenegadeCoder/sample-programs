if #arg < 1 then
    print("Usage: please provide a string")
    os.exit(1)
end

local input = arg[1]

function longest_word_length(str)
    local max_length = 0
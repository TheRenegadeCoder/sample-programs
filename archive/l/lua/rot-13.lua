function mod(a, b)
    return a - (math.floor(a/b)*b)
end

if (#arg < 1)
then
    print('Usage: provide a string')
else
    str = arg[1]
    for k = 1, #str do
        local c = str:sub(k,k)
        if (c ~= " ")
        then
            io.write(string.char(mod(string.byte(c) - 97 + 13, 26) + 97))
        else
            io.write(" ")
        end
    end
end

io.write("\n")

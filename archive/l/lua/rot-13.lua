-- See: https://stackoverflow.com/questions/9695697/lua-replacement-for-the-operator/20858039#20858039
function mod(a, b)
    return a - (math.floor(a/b)*b)
end

if (#arg < 1)
then
    print('Usage: please provide a string to encrypt')
else
    str = {...}
    for i,v in pairs(str) do
        for k = 1, #v do
            local c = v:sub(k,k)
            io.write(string.char(mod(string.byte(c) - 97 + 13, 26) + 97))
        end
        io.write(" ")
    end
end

io.write("\n")

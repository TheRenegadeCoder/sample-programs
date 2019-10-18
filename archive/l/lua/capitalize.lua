if (#arg < 1)
then
    print('Usage: provide a string')
else
    str = {...}
    s = ""
    for i,v in pairs(str) do
        s = s .. v .. " "
    end
    print(s:gsub("^%l", string.upper))  
end

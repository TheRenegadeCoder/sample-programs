if (#arg < 1)
then
    print('Usage: provide a string')
else
    str = {...}
    s = ""
    for i,v in pairs(str) do
        s = s .. v .. " "
    end
    s, _ = s:gsub("^%l", string.upper)
    print(s)  
end

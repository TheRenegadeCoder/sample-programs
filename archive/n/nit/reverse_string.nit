var word = gets

if word == "" then

else 
    var reversed = ""
    var i = word.length - 1
    while i >= 0 do
        reversed += word.chars[i].to_s
        i -= 1
    end 
    printn reversed
end

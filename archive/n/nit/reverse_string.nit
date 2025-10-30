if args.length > 0 then
    var word = args[0]
    var reversed = ""
    var i = word.length - 1
    while i >= 0 do 
        reversed += word.chars[i].to_s
        i -= 1
    end
    printn reversed
end
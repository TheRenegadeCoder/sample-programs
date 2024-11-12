reverse_string = (str) ->
    if not str or str == '""' then
        return ''
    result = ""
    for i = #str, 1, -1
        result ..= str\sub(i, i)
    print result





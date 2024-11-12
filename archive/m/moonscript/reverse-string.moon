reverse_string = (str) ->
    if str == '' then
        return ''
    result = ''
    for i = #str, 1, -1
        result ..= str\sub(i, i)
    print result

print reverse_string('Hello, World')





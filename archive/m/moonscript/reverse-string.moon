-- Function to reverse a string
reverse_string = (str) ->
    if str == '' then return ''
    
    result = ''

    for i = #str, 1, -1
        result = result .. str\sub(i, i)

    return result

-- Main executable section

if not arg or #arg == 0
    print ''
else
    input_str = arg[1]  
    reversed_str = reverse_string(input_str)
    print reversed_str
    

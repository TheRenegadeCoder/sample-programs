function [result] = strRepeat(n, s)
    result = ''
    for i = 1:n
        result = result + s
    end
endfunction

for i = -10:10
    numSpaces = abs(i)
    mprintf('%s%s\n', strRepeat(numSpaces, ' '), strRepeat(21 - 2 * numSpaces, '*'))
end

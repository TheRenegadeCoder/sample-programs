C = terralib.includecstring[[
    #include <stdio.h>
]]

terra baklava()
    for i = -10, 11 do
        var numSpaces : int = i
        if i < 0 then
            numSpaces = -numSpaces
        end

        outputStrRepeat(numSpaces, " ")
        outputStrRepeat(21 - 2 * numSpaces, "*")
        C.printf("\n")
    end
end

terra outputStrRepeat(n : int, s : &int8)
    for i = 0, n do
        C.printf("%s", s)
    end
end

baklava()

class 
    baklava

create
    make

feature

    make
        local
            num_spaces: INTEGER
            num_stars: INTEGER
        do 
            across
                -10 |..| 10 as n
            loop
                num_spaces := n.item.abs
                num_stars := 21 - 2 * num_spaces
                print (repeat_string(" ", num_spaces) + repeat_string("*", num_stars) + "%N")
            end
        end

    repeat_string(s: STRING; n: INTEGER): STRING
        do
            Result := ""
            across
                1 |..| n as x
            loop
                Result := Result + s
            end
        end
end

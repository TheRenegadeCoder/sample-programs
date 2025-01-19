class
    fizz_buzz

create
    make

feature
    make
        do
            across 1 |..| 100 as i
            loop
                if i.item \\ 15 = 0 then io.put_string("FizzBuzz")
                elseif i.item \\ 5 = 0 then io.put_string("Buzz")
                elseif i.item \\ 3 = 0 then io.put_string("Fizz")
                else io.put_integer(i.item)
                end
                
                io.put_new_line
            end
        end
    end

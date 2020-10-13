program a1;

var
{ local variable declaration }
 buf: String;
(* number, factorial, check:Cardinal;*)
number, check: integer;
factorial: Cardinal;
begin    

    readln(buf);
    Val(buf, number, check) ;
    if check <> 0
    then
    writeln('Usage: please input a number')

    else
            if number < 0
            then
            writeln('Usage: please input a non-negative integer')

            else

            if number > 33
                        then
            writeln(number, ' is out of the reasonable bounds for calculation.')

            else
            begin
                    factorial :=1;
                    for check:= 1 to number do
                    factorial:= factorial * check;
                                writeln(factorial);


            end

end.

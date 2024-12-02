with Text_IO; use Text_IO;

procedure Fizz_Buzz is
    Counter : Integer := 1;
begin
    while Counter < 101
        loop
            if Counter mod 3 = 0 and Counter mod 5 = 0 then
                Put_Line("FizzBuzz");
            elsif Counter mod 3 = 0 then
                Put_Line("Fizz");
            elsif Counter mod 5 = 0 then
                Put_Line("Buzz");
            else
                Put_Line(Integer'Image(Counter));
            end if;
            Counter := Counter + 1;
        end loop;
end Fizz_Buzz;
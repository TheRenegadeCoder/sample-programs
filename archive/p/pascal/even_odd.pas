program even_odd;
(*
Accept number, If not number, Empty, character or no input, Display Usage: please input a number
if number is % divide by 2 Print Even 
If number is not % by 2, print Odd
*)
var
{ local variable declaration }
 buf: String;
 a, check:integer;
begin    
    readln(buf);
    Val(buf, a, check) ;
    if check <> 0
    then
    writeln('Usage: please input a number')
    else
    begin
        if( (a mod 2) = 0) then
            begin
            write('Even'); 
            end         
        else
            begin
            write('Odd'); 
            end
    end
end.

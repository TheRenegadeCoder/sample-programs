program even_odd;

(*
Accept number, If not number, Empty, character or no input, Display Usage: please input a numberif number, % divide by 2 Print either Even or Odd
Learnings 9:21 PM Oct 10
equals to Operator is =
Strings inside write must be in single quotes
last line of the program must be end.*)
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
            writeln('Even'); 
            end         
        else
            begin
            writeln('Odd'); 
            end
    end

end.

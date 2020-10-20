program a1(input, output, stdErr);
(* Read Number from commandline, print  Even or Odd *)
var
 buf: String;
 a, check:integer;
begin    
  buf:= paramStr(1);
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

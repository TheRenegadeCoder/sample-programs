program Fibonacci(input, output, stdErr);
(*Read count of fibonnaci numbers into a string

*)
var
  buf: String;
  count, check, first,second,result, i : integer;

begin
  (*Variable initialisation must be inside begin-end block*)
  first := 0;
  second := 1;
  result := 0;

  begin   
   buf:= paramStr(1);
   Val(buf, count, check);  
   (*If input is valid integer, check will be 0, else will be 1*)
   if (check <> 0)
   then
   begin
    writeln('Usage: please input the count of fibonacci numbers to output');
   end
   else
    for i := 1 to count do
    begin
    
    result := first + second;
    first := second;
    second := result;
    writeln(i, ': ', first);
    end;
   end;
end.

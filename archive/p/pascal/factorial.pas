(* Accept number from command line, print it's Factorial*)
program factorial_compute(input, output, stdErr);
var
  buf: String;
  i, number, check_error: integer;
  factorial: Cardinal;
begin    
  buf:= paramStr(1);
  Val(buf, number, check_error);  
  if check_error <> 0 (* Non Integer*)
  then
    writeln('Usage: please input a non-negative integer')
  else
  if number < 0 (* Negative Number*) then
    writeln('Usage: please input a non-negative integer')
  else
  begin
    if number > 33 (*exceeds unsigned integer limit in Pascal*)
  then
    writeln(number, ' is out of the reasonable bounds for calculation.')
  else
  begin
    factorial :=1;
    for i:= 1 to number do
    factorial:= factorial * i;
    writeln(factorial);
  end;
  end;
end.

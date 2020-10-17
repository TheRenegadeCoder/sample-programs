program prime_check(input, output, stdErr);
(* Read a number from Commandline, Check  if it is Prime or Composite*)
var
 buf: String;
(* prime, factorial, check:Cardinal;*)
i, max_divisor, check, flag: integer;
prime: Cardinal;
begin    
  buf:= paramStr(1);
  Val(buf, prime, check);  
  if check <> 0
  then
    writeln('Usage: please input a non-negative integer')
  else
    if prime < 0
      then
        writeln('Usage: please input a non-negative integer')
      else
      begin
        if (prime = 2) then 
          writeln('Prime')
          else
        if ((prime = 0) or (prime = 1) )
        then
          writeln('Composite')
          else
          if (prime mod 2 = 0)
          then
            writeln('Composite')
          else
          begin
            flag := 0;
            max_divisor := round(prime / 2);
            for i := 3 to max_divisor do 
              begin
              if ( prime mod i = 0 ) 
              then
              flag := 1;
              break;
            end;
              if (flag = 0)
              then
                writeln('Prime')
              else
                writeln('Composite')
          end;
        end
end.

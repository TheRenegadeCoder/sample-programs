(*
Count the no. of digits
compare the left most with rightmost no & keep moving nearer to midpoint
If any one comparison fails, type false
If all comparison succeeds, type true
*)

program Palindromic_number_check(input, output, stdErr);
(*Read count of fibonnacnoofdigits numbers into a string *)
var
   buf: String;
   loop_counter, noofdigits, flag, fromright, i : integer;
   check, number : Cardinal;
   quotient : real;
   num_array : array [1..25] of integer;
begin
   (*Variable initialisation must be inside begin-end block*)
  (*Accept Number, check no. of digits in it, ...*)
    buf:= paramStr(1);
    Val(buf, number, check);  
    (*If input is valid integer, check will be 0, else will be 1*)
    if (check <> 0)
    then
    begin
      writeln('Usage: please input a number with at least two digits');
    end
    else
    begin
   //  writeln('number = ', number);
    check := number;
    noofdigits := 0;
    flag := 1;
    repeat
    begin

       (*round(quotient) will round off to next number, trunc will give only the number
              // writeln('Quotient = ', quotient, 'Number =', number, 'check1 = ', check) *)
       noofdigits := noofdigits + 1;
       quotient := check / 10;
       num_array[noofdigits] := check mod 10;
       check := trunc(quotient);
       end;
    until check = 0;

    (* Run the loop till the no. of digits / 2*)
    if ( (noofdigits mod 2) = 1 ) then
       loop_counter := trunc((noofdigits +1 )/ 2)
   else
   loop_counter := trunc(noofdigits / 2);
      fromright := noofdigits    ;
   for i := 1 to loop_counter do
    begin
      fromright := noofdigits - (i -1 ); 
      if (num_array[i] <> num_array[fromright]) then
      begin
         flag := 0;
         break;  
      end;
         
    end;
   if flag = 0 then
      writeln('false')
   else
      writeln('true');
      
    end (* Begin Reading NUmber*)
end.  (* Begin Program Block*)

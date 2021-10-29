(*
Description 	Input 	Output
no input 	None 	Usage: please input a number
empty input 	”” 	Usage: please input a number
invalid input: not a number 	a 	Usage: please input a number
sample input: palindrome 	232 	true
sample input: not palindrome 	521 	false

Count the no. of digits
compare the left most with rightmost no & keep moving nearer to midpoint
If any one comparison fails, type false
If all comparison succeeds, type true
*)

program Palindromic_number_check(input, output, stdErr);
(*Read count of fibonnacnoofdigits numbers into a string

*)
var
   buf: String;
   noofdigits : integer;
   check, number, reversed_number : Cardinal;

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
    reversed_number := 0;
    repeat
    begin
    (* Count no. of digits, build the number backwards *)
       noofdigits := noofdigits + 1;
       (*quotient := check mod 10 ;*)
       reversed_number := (reversed_number * 10) + (check mod 10);
       check := trunc(check div 10);
       end;
    until check = 0;

    if noofdigits >= 2 then
      if (reversed_number = number) then
         writeln('true')
      else
      
         writeln('false')
   
    else
      writeln('Usage: please input a number with at least two digits')
    end; (* Begin Reading NUmber*)
end.  (* Begin Program Block*)

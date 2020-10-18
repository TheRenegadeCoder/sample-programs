program Capitalise(input, output, stdErr);
(* Accept a String from commandline, convert first character to upper case
   Pascal Strings begins with 1, not 0
*)
var
buf: string;
begin
  buf := paramStr(1);
  if buf = ''  then
    writeln('Usage: please provide a string')
  else
    buf[1] := UpCase(buf[1]);
    writeln(buf);
end.

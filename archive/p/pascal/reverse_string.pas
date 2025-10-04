program reversestring(input, output, stdErr);
(*Accept a String from Command Line, Reverse it & Print it*)
var
  i, j: Integer;
   buf, result: String;
begin
  buf := paramStr(1);
  setlength(result,length(buf));
  i:=1; 
  j:=length(buf);
  while (i<=j) do
    begin
      result[i]:=buf[j-i+1];
      inc(i);
    end;
    writeln(result);
end.

program reversestring;


var
  i, j: Integer;
   buf, result: String;
begin

readln(buf);
    if buf = ''    then
    writeln('Usage: please provide a string');

    else;
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

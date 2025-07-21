program RemoveAllWhitespace;

{$mode objfpc}{$H+}

uses
   SysUtils;

procedure ShowUsage;
begin
   Writeln('Usage: please provide a string');
   Halt(1);
end;

function RemoveWhitespace(const S: string): string;
var
   builder: TStringBuilder;
   ch: char;
begin
   builder := TStringBuilder.Create;
   try
      for ch in S do
         case ch of
            ' ', #9, #10, #13: Continue;
            else
               builder.Append(ch);
         end;

      Result := builder.ToString;
   finally
      builder.Free;
   end;
end;

var
   Input: string;
   Output: string;
begin
   if ParamCount <> 1 then
      ShowUsage;

   Input := ParamStr(1);
   if Input = '' then
      ShowUsage;

   Output := RemoveWhitespace(Input);
   Writeln(Output);
end.

program RomanNumeral;

{$mode objfpc}{$H+}

uses
   SysUtils;

procedure ShowUsage;
begin
   Writeln('Usage: please provide a string of roman numerals');
   Halt(1);
end;

function RomanToInt(const S: string): int64;
const
   RomanChars: array[0..6] of char = ('I', 'V', 'X', 'L', 'C', 'D', 'M');
   RomanValues: array[0..6] of integer = (1, 5, 10, 50, 100, 500, 1000);
var
   Value: array[char] of integer;
   i, len: integer;
   ch: char;
   Answer, PreviousValue, CurrentValue: int64;
begin
   FillChar(Value, SizeOf(Value), 0);

   for i := Low(RomanChars) to High(RomanChars) do
      Value[RomanChars[i]] := RomanValues[i];

   Answer := 0;
   PreviousValue := 0;
   len := Length(S);

   if len = 0 then
      Exit(0);

   for i := len downto 1 do
   begin
      ch := S[i];
      CurrentValue := Value[ch];
      if CurrentValue = 0 then
         raise Exception.Create('Error: invalid string of roman numerals');

      if CurrentValue < PreviousValue then
         Dec(Answer, CurrentValue)
      else
      begin
         Inc(Answer, CurrentValue);
         PreviousValue := CurrentValue;
      end;
   end;

   Result := Answer;
end;

var
   Input: string;
   Number: int64;
begin
   if ParamCount <> 1 then
      ShowUsage;

   Input := AnsiUpperCase(Trim(ParamStr(1)));

   try
      Number := RomanToInt(Input);
      Writeln(Number);
   except
      on E: Exception do
      begin
         Writeln(E.Message);
         Halt(1);
      end;
   end;
end.

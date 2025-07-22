program LongestWord;

{$mode objfpc}{$H+}

uses
   SysUtils;

procedure ShowUsage;
begin
   Writeln('Usage: please provide a string');
   Halt(1);
end;

function FindLongestWordLength(const input: string): integer;
var
   i, currentLength, longestLength: integer;
begin
   currentLength := 0;
   longestLength := 0;

   for i := 1 to Length(input) do
      if input[i] in [' ', #9, #10, #13] then
      begin
         // Update longestLength if we encountered the end of a word
         if currentLength > longestLength then
            longestLength := currentLength;

         // Reset for the next word
         currentLength := 0;
      end
      else
         // Increase the length of the current word
         Inc(currentLength);

   // Final check for the last word in the string (if no trailing space)
   if currentLength > longestLength then
      longestLength := currentLength;

   Result := longestLength;
end;

var
   input: string;
   Result: integer;
begin
   if ParamCount <> 1 then
      ShowUsage;

   input := ParamStr(1);

   if Trim(input) = '' then
      ShowUsage;

   Result := FindLongestWordLength(input);
   Writeln(Result);
end.

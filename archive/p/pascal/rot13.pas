program Rot13;

{$mode objfpc}{$H+}

uses
   SysUtils;

procedure ShowUsage;
begin
   Writeln('Usage: please provide a string to encrypt');
   Halt(1);
end;

function Rot13(const S: string): string;
var
   ch: char;
begin
   Result := '';
   for ch in S do
      case ch of
         'A'..'Z':
            Result += Chr(((Ord(ch) - Ord('A') + 13) mod 26) + Ord('A'));
         'a'..'z':
            Result += Chr(((Ord(ch) - Ord('a') + 13) mod 26) + Ord('a'));
         else
            Result += ch;
      end;
end;

var
   Input: string;
begin
   if ParamCount <> 1 then
      ShowUsage;

   Input := ParamStr(1);
   if Input = '' then
      ShowUsage;

   Writeln(Rot13(Input));
end.

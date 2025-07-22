program JosephusProblem;

{$mode objfpc}{$H+}

uses
   Classes,
   SysUtils;

procedure ShowUsage;
begin
   Writeln('Usage: please input the total number of people and number of people to skip.');
   Halt(1);
end;

function ParseInteger(const S: string; out Value: integer): boolean;
begin
   Result := TryStrToInt(Trim(S), Value);
end;

function Josephus(TotalPeople, SkipCount: integer): integer;
var
   CurrentCount, HighestPowerOf2: integer;
begin
   if (SkipCount < 1) or (TotalPeople < 1) then ShowUsage;

   // If skip = 1, that means that survivor is the last person
   if SkipCount = 1 then
   begin
      Result := TotalPeople;
      Exit;
   end;

   if SkipCount = 2 then
   begin
      HighestPowerOf2 := 1;
      while (HighestPowerOf2 shl 1) <= TotalPeople do
         HighestPowerOf2 := HighestPowerOf2 shl 1;

      Result := 2 * (TotalPeople - HighestPowerOf2) + 1;
      Exit;
   end;

   Result := 0;

   for CurrentCount := 2 to TotalPeople do
      Result := (Result + SkipCount) mod CurrentCount;

   Result := Result + 1;
end;

var
   TotalPeople, SkipCount: integer;
begin
   if ParamCount <> 2 then
      ShowUsage;

   if not ParseInteger(ParamStr(1), TotalPeople) then
      ShowUsage;
   if not ParseInteger(ParamStr(2), SkipCount) then
      ShowUsage;

   Writeln(Josephus(TotalPeople, SkipCount));
end.

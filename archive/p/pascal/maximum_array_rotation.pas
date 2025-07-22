program MaximumArrayRotation;

{$mode objfpc}{$H+}

uses
   Classes,
   Generics.Collections,
   SysUtils;

procedure ShowUsage;
begin
   Writeln('Usage: please provide a list of integers (e.g. "8, 3, 1, 2")');
   Halt(1);
end;

type
   TIntegerList = specialize TList<integer>;

function ParseIntegerList(const S: string): TIntegerList;
var
   Tokens: TStringArray;
   Token: string;
   Value: integer;
begin
   if S.Trim = '' then
      ShowUsage;

   Tokens := S.Split([',']);
   if Length(Tokens) = 0 then
      ShowUsage;

   Result := TIntegerList.Create;
   for Token in Tokens do
   begin
      if not TryStrToInt(Trim(Token), Value) then
      begin
         Result.Free;
         ShowUsage;
      end;
      Result.Add(Value);
   end;
end;

function MaximumRotationSum(const Numbers: TIntegerList): integer;
var
   N, i, TotalSum, CurrentWeightedSum, MaxWeightedSum: integer;
begin
   N := Numbers.Count;
   if N = 0 then
      ShowUsage;

   TotalSum := 0;
   CurrentWeightedSum := 0;
   for i := 0 to N - 1 do
   begin
      TotalSum += Numbers[i];
      CurrentWeightedSum += Numbers[i] * i;
   end;

   MaxWeightedSum := CurrentWeightedSum;

   for i := 1 to N - 1 do
   begin
      CurrentWeightedSum := CurrentWeightedSum + TotalSum - N * Numbers[N - i];
      if MaxWeightedSum < CurrentWeightedSum then
         MaxWeightedSum := CurrentWeightedSum;
   end;

   Result := MaxWeightedSum;
end;

var
   InputList: TIntegerList;
begin
   if ParamCount <> 1 then
      ShowUsage;

   InputList := ParseIntegerList(ParamStr(1));
   try
      Writeln(MaximumRotationSum(InputList));
   finally
      InputList.Free;
   end;
end.

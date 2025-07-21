program TransposeMatrix;

{$mode objfpc}{$H+}

uses
   Classes,
   Generics.Collections,
   StrUtils,
   SysUtils;

type
   TIntegerList = specialize TList<integer>;

procedure ShowUsage;
begin
   Writeln('Usage: please enter the dimension of the matrix and the serialized matrix');
   Halt(1);
end;

function ParseIntegerList(const S: string): TIntegerList;
var
   Tokens: TStringArray;
   Token: string;
   Value: integer;
begin
   if S.Trim = '' then
      ShowUsage;

   Tokens := S.Split([',']);
   if Length(Tokens) < 2 then
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

function FormatIntegerList(const List: TIntegerList): string;
var
   i: integer;
begin
   Result := '';
   for i := 0 to List.Count - 1 do
   begin
      if i > 0 then
         Result += ', ';
      Result += IntToStr(List[i]);
   end;
end;

function TransposeMatrix(const Cols, Rows: integer;
const Input: TIntegerList): TIntegerList;
var
   i, j, index: integer;
begin
   Result := TIntegerList.Create;
   Result.Count := Rows * Cols;

   for i := 0 to Pred(Rows) do
      for j := 0 to Pred(Cols) do
      begin
         index := j * Rows + i;
         Result[index] := Input[i * Cols + j];
      end;
end;

var
   Cols, Rows: integer;
   Numbers, Transposed: TIntegerList;
begin
   if ParamCount <> 3 then
      ShowUsage;

   if (not TryStrToInt(ParamStr(1), Cols)) or (not TryStrToInt(ParamStr(2), Rows)) then
      ShowUsage;

   Numbers := ParseIntegerList(ParamStr(3));
   if Numbers.Count <> (Cols * Rows) then
   begin
      Numbers.Free;
      ShowUsage;
   end;

   Transposed := TransposeMatrix(Cols, Rows, Numbers);
   try
      Writeln(FormatIntegerList(Transposed));
   finally
      Numbers.Free;
      Transposed.Free;
   end;
end.

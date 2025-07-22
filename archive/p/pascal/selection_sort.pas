program SelectionSort;

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
   Writeln('Usage: please provide a list of at least two integers to sort in the format "1, 2, 3, 4, 5"');
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

procedure SelectionSort(List: TIntegerList);
var
   startIdx, endIdx, i, minIdx, maxIdx: integer;

   procedure SwapElements(Index1, Index2: integer);
   var
      Temp: integer;
   begin
      Temp := List[Index1];
      List[Index1] := List[Index2];
      List[Index2] := Temp;
   end;

begin
   startIdx := 0;
   endIdx := List.Count - 1;

   while startIdx < endIdx do
   begin
      minIdx := startIdx;
      maxIdx := startIdx;

      for i := startIdx to endIdx do
      begin
         if List[i] < List[minIdx] then
            minIdx := i;
         if List[i] > List[maxIdx] then
            maxIdx := i;
      end;

      // Swap min to start
      if minIdx <> startIdx then
      begin
         SwapElements(startIdx, minIdx);

         // Adjust maxIdx if it was swapped
         if maxIdx = startIdx then
            maxIdx := minIdx;
      end;

      // Swap max to end
      if maxIdx <> endIdx then
         SwapElements(endIdx, maxIdx);

      Inc(startIdx);
      Dec(endIdx);
   end;
end;

var
   rawArg: string;
   numbers: TIntegerList;
begin
   if ParamCount <> 1 then
      ShowUsage;

   rawArg := ParamStr(1);
   numbers := ParseIntegerList(rawArg);
   try
      SelectionSort(numbers);
      Writeln(FormatIntegerList(numbers));
   finally
      numbers.Free;
   end;
end.

program BubbleSort;

{$mode objfpc}{$H+}

uses
   Classes, Generics.Collections, SysUtils;

type
   TIntegerList = specialize TList<Integer>;

procedure ShowUsage;
begin
   Writeln('Usage: please provide a list of at least two integers to sort in the format "1, 2, 3, 4, 5"');
   Halt(1);
end;

function ParseIntegerList(const S: string): TIntegerList;
var
   Tokens: TStringArray;
   Token: string;
   Value: Integer;
begin
   if S.Trim.IsEmpty then
      ShowUsage;

   Tokens := S.Split([',']);
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

   if Result.Count < 2 then
   begin
      Result.Free;
      ShowUsage;
   end;
end;

function IsSorted(const A: TIntegerList): Boolean;
var
   i: Integer;
begin
   for i := 1 to A.Count - 1 do
      if A[i] < A[i - 1] then
         Exit(False);
   Result := True;
end;

procedure BubbleSort(List: TIntegerList);
var
   i, j: Integer;
   Swapped: Boolean;

   procedure SwapElements(Index1, Index2: Integer);
   var
      Temp: Integer;
   begin
      Temp := List[Index1];
      List[Index1] := List[Index2];
      List[Index2] := Temp;
   end;
begin
   for i := List.Count - 1 downto 1 do
   begin
      Swapped := False;
      for j := 0 to i - 1 do
         if List[j] > List[j + 1] then
         begin
            SwapElements(j, j + 1);
            Swapped := True;
         end;

      if not Swapped then
         Break;
   end;
end;

function FormatIntegerList(List: TIntegerList): string;
var
   i: Integer;
begin
   Result := '';
   for i := 0 to List.Count - 1 do
   begin
      if i > 0 then
         Result += ', ';
      Result += IntToStr(List[i]);
   end;
end;

var
   RawInput: string;
   Numbers: TIntegerList;
begin
   if ParamCount <> 1 then
      ShowUsage;

   RawInput := ParamStr(1);
   Numbers := ParseIntegerList(RawInput);
   try
      if not IsSorted(Numbers) then
         BubbleSort(Numbers);

      Writeln(FormatIntegerList(Numbers));
   finally
      Numbers.Free;
   end;
end.


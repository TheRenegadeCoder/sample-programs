program QuickSort;

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

procedure InsertionSort(var A: TIntegerList; Left, Right: integer);
var
   i, j, key: integer;
begin
   for i := Left + 1 to Right do
   begin
      key := A[i];
      j := i - 1;
      while (j >= Left) and (A[j] > key) do
      begin
         A[j + 1] := A[j];
         Dec(j);
      end;
      A[j + 1] := key;
   end;
end;

function MedianOfThree(var List: TIntegerList; Left, Mid, Right: integer): integer;
var
   a, b, c: integer;
begin
   a := List[Left];
   b := List[Mid];
   c := List[Right];

   if (a <= b) then
   begin
      if (b <= c) then
         Result := B
      else if (a <= c) then
         Result := C
      else
         Result := A;
   end

   else
   if (a <= c) then
      Result := A
   else if (b <= c) then
      Result := C
   else
      Result := B;
end;

function MedianOfNine(var List: TIntegerList; Left, Right: integer): integer;
var
   step, mid: integer;
   m1, m2, m3: integer;
begin
   if (Right - Left) < 8 then
      Exit(MedianOfThree(List, Left, Left + (Right - Left) div 2, Right));

   step := (Right - Left) div 8;
   mid := Left + (Right - Left) div 2;

   m1 := MedianOfThree(List, Left, Left + step, Left + 2 * step);
   m2 := MedianOfThree(List, mid - step, mid, mid + step);
   m3 := MedianOfThree(List, Right - 2 * step, Right - step, Right);

   Result := MedianOfThree(List, m1, m2, m3);
end;

procedure QuickSort(var List: TIntegerList; Left, Right: integer);
const
   INSERTION_SORT_THRESHOLD = 16;
var
   i, j, pivotIndex, pivotValue: integer;

   procedure SwapElements(Index1, Index2: integer);
   var
      Temp: integer;
   begin
      Temp := List[Index1];
      List[Index1] := List[Index2];
      List[Index2] := Temp;
   end;

   // Three-way partitioning (AKA Dutch National Flag partitioning)
   procedure Partition(out LeftEnd, RightStart: integer);
   var
      LeftIndex, RightIndex, CurrentIndex: integer;
   begin
      LeftIndex := Left;
      RightIndex := Right;
      CurrentIndex := Left;

      while CurrentIndex <= RightIndex do
         if List[CurrentIndex] < pivotValue then
         begin
            SwapElements(CurrentIndex, LeftIndex);
            Inc(LeftIndex);
            Inc(CurrentIndex);
         end
         else if List[CurrentIndex] > pivotValue then
         begin
            SwapElements(CurrentIndex, RightIndex);
            Dec(RightIndex);
         end
         else
            Inc(CurrentIndex);

      LeftEnd := LeftIndex - 1;
      RightStart := RightIndex + 1;
   end;

begin
   while Left < Right do
   begin
      if Right - Left + 1 <= INSERTION_SORT_THRESHOLD then
      begin
         InsertionSort(List, Left, Right);
         Exit;
      end;

      // Median-of-nine pivot selection
      pivotIndex := MedianOfNine(List, Left, Right);
      pivotValue := List[pivotIndex];
      // Move pivot to the end
      SwapElements(pivotIndex, Right);

      Partition(i, j);

      // Recurse on smaller side first
      if (i - Left) < (Right - j) then
      begin
         QuickSort(List, Left, i);
         Left := j;
      end
      else
      begin
         QuickSort(List, j, Right);
         Right := i;
      end;
   end;
end;

var
   numbers: TIntegerList;
begin
   if ParamCount <> 1 then
      ShowUsage;

   numbers := ParseIntegerList(ParamStr(1));
   try
      QuickSort(numbers, 0, numbers.Count - 1);
      Writeln(FormatIntegerList(numbers));
   finally
      numbers.Free;
   end;
end.

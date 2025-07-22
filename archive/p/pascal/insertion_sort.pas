program InsertionSort;

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

procedure InsertionSort(List: TIntegerList);
var
   i, j, key, insertPos: integer;
   AlreadySorted: boolean;

// This is an optional optimization on insertion sort, reducing the number of
// comparisons needed. Essentially, we're using binary search to find the
// appropiate position. Binary search is O(log n), so the number of
// comparisons will be O(n log n) as opposed to O(n²). The time complexity
// is still O(n²).
   function FindInsertPosition(const Key: integer; HighBound: integer): integer;
   var
      Low, High, Mid: integer;
   begin
      Low := 0;
      High := HighBound - 1; // search only within sorted portion (0..i-1)

      while Low <= High do
      begin
         Mid := Low + (High - Low) shr 1;
         if List[Mid] < Key then
            Low := Mid + 1
         else
            High := Mid - 1;
      end;

      Result := Low;
   end;

begin
   if List.Count <= 1 then
      Exit;

   for i := 1 to List.Count - 1 do
   begin
      key := List[i];

      // Optimization: skip if key is already greater or equal to previous element
      if key >= List[i - 1] then
         Continue;

      // Find insertion position in sorted subarray [0..i-1]
      insertPos := FindInsertPosition(key, i);

      // Shift elements to the right to make room for key
      j := i;
      while j > insertPos do
      begin
         List[j] := List[j - 1];
         Dec(j);
      end;

      List[insertPos] := key;
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
      InsertionSort(numbers);
      Writeln(FormatIntegerList(numbers));
   finally
      numbers.Free;
   end;
end.

program BinarySearch;

{$mode objfpc}{$H+}

uses
   Classes,
   Generics.Collections,
   StrUtils,
   SysUtils;

procedure ShowUsage;
begin
   Writeln('Usage: please provide a list of sorted integers ("1, 4, 5, 11, 12") and the integer to find ("11")');
   Halt(1);
end;

type
   TIntegerList = specialize TList<integer>;

function ParseIntegerList(const S: string): TIntegerList;
var
   tokens: TStringArray;
   token: string;
   val: integer;
begin
   if S.Trim.IsEmpty then
      ShowUsage;

   tokens := S.Split([',']);
   Result := TIntegerList.Create;
   for token in tokens do
   begin
      if not TryStrToInt(Trim(token), val) then
      begin
         Result.Free;
         ShowUsage;
      end;
      Result.Add(val);
   end;

   if Result.Count = 0 then
   begin
      Result.Free;
      ShowUsage;
   end;
end;

function IsSorted(const A: TIntegerList): boolean;
var
   i, Length: integer;
begin
   Length := A.Count;
   if Length <= 1 then
      Exit(True);

   for i := 1 to Length - 1 do
      if A[i] < A[i - 1] then
         Exit(False);

   Result := True;
end;

// This is the textbook binary search, with a couple of early exits to not spend
// time on degenerate cases.
function BinarySearch(const List: TIntegerList; Value: integer): boolean;
var
   Left, Right, Pivot: integer;
   Length: integer;
begin
   Length := List.Count;

   // Handle empty list
   if Length = 0 then
      Exit(False);

   // Handle single-element list
   if Length = 1 then
      Exit(List.First = Value);

   // If the value isn't within the range of values inside the array, there's no
   // reason to even start the algorithm.
   if (Value < List.First) or (Value > List.Last) then
      Exit(False);

   Left := 0;
   Right := Length - 1;
   Result := False;
   while Left <= Right do
   begin
      Pivot := Left + ((Right - Left) shr 1);
      if List[Pivot] = Value then
         Exit(True)
      else if List[Pivot] < Value then
         Left := Pivot + 1
      else
         Right := Pivot - 1;
   end;

   Result := False;
end;

var
   ListArg, ValueArg: string;
   Numbers: TIntegerList;
   Value: integer;
begin
   if ParamCount <> 2 then
      ShowUsage;

   ListArg := Trim(ParamStr(1));
   ValueArg := Trim(ParamStr(2));

   if ListArg.IsEmpty or ValueArg.IsEmpty then
      ShowUsage;

   Numbers := ParseIntegerList(ListArg);
   try
      if not IsSorted(Numbers) then
         ShowUsage;

      if not TryStrToInt(ValueArg, Value) then
         ShowUsage;

      Writeln(BoolToStr(BinarySearch(Numbers, Value), 'true', 'false'));
   finally
      Numbers.Free;
   end;
end.

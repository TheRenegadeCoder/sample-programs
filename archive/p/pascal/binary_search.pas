program BinarySearch;

{$mode objfpc}{$H+}

uses
   Classes,
   SysUtils;

procedure ShowUsage;
begin
   Writeln('Usage: please provide a list of sorted integers ("1, 4, 5, 11, 12") and the integer to find ("11")');
   Halt(1);
end;

type
   TIntArray = array of integer;

function ParseIntegerList(const s: string): TIntArray;
var
   parts: TStringList;
   i: integer;
begin
   parts := TStringList.Create;
   try
      parts.Delimiter := ',';
      parts.StrictDelimiter := True;
      parts.DelimitedText := s;
      SetLength(Result, parts.Count);
      for i := 0 to parts.Count - 1 do
         Result[i] := StrToInt(Trim(parts[i]));
   finally
      parts.Free;
   end;
end;

function IsSorted(const a: TIntArray): boolean;
var
   i: integer;
begin
   for i := Low(a) + 1 to High(a) do
      if a[i] < a[i - 1] then
         Exit(False);
   Result := True;
end;


function BinarySearch(const arr: TIntArray; key: integer): boolean;
var
   left, right, mid: integer;
begin
   left := 0;
   right := High(arr);
   Result := False;
   while left <= right do
   begin
      mid := (left + right) shr 1;
      if arr[mid] = key then
      begin
         Result := True;
         Exit;
      end
      else if arr[mid] < key then
         left := mid + 1
      else
         right := mid - 1;
   end;
end;

var
   listArg, keyArg: string;
   nums: TIntArray;
   key: integer;
begin
   if ParamCount <> 2 then
      ShowUsage;

   listArg := ParamStr(1);
   keyArg := ParamStr(2);

   if (listArg = '') or (keyArg = '') then
      ShowUsage;

   try
      nums := ParseIntegerList(listArg);
      key := StrToInt(keyArg);
   except
      on E: Exception do
         ShowUsage;
   end;

   if not IsSorted(nums) then
      ShowUsage;

   if BinarySearch(nums, key) then
      Writeln('true')
   else
      Writeln('false');
end.

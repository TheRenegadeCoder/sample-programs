program LinearSearch;

{$mode objfpc}{$H+}

uses
   Generics.Collections,
   SysUtils;

type
   TIntegerList = specialize TList<integer>;

procedure ShowUsage;
begin
   Writeln('Usage: please provide a list of integers ("1, 4, 5, 11, 12") and the integer to find ("11")');
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

function LinearSearch(const Haystack: TIntegerList; const Needle: integer): boolean;
var
   i: integer;
begin
   if Haystack.Count = 1 then
      Exit(Haystack[0] = Needle);

   Result := False;

   for i := 0 to Haystack.Count - 1 do
      if Haystack[i] = Needle then
         Exit(True);
end;

var
   List: TIntegerList;
   Value: integer;
begin
   if ParamCount <> 2 then
      ShowUsage;

   try
      if Trim(ParamStr(1)) = '' then
         ShowUsage;

      List := ParseIntegerList(ParamStr(1));

      if not TryStrToInt(ParamStr(2), Value) then
      begin
         List.Free;
         ShowUsage;
      end;

      Writeln(BoolToStr(LinearSearch(List, Value), 'true', 'false'));
   finally
      List.Free;
   end;
end.

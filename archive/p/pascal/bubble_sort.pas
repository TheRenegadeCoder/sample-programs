program BubbleSort;

{$mode objfpc}{$H+}

uses
   Classes,
   SysUtils;

procedure ShowUsage;
begin
   Writeln('Usage: please provide a list of at least two integers to sort in the format "1, 2, 3, 4, 5"');
   Halt(1);
end;

type
   TIntArray = array of integer;

procedure SplitAndTrim(const S: string; out Tokens: TStringList);
var
   p: integer;
   token: string;
begin
   Tokens := TStringList.Create;
   try
      p := 1;
      while p <= Length(S) do
      begin
         token := '';
         while (p <= Length(S)) and (S[p] <> ',') do
         begin
            token := token + S[p];
            Inc(p);
         end;
         Tokens.Add(Trim(token));
         Inc(p);
      end;
      Exit;
   except
      Tokens.Free;
      raise;
   end;
end;

function ParseIntegerList(const S: string): TIntArray;
var
   parts: TStringList;
   i: integer;
   val: integer;
begin
   if S = '' then
      ShowUsage;

   SplitAndTrim(S, parts);
   try
      if parts.Count < 2 then
         ShowUsage;

      SetLength(Result, parts.Count);
      for i := 0 to parts.Count - 1 do
      begin
         if not TryStrToInt(parts[i], val) then
            ShowUsage;
         Result[i] := val;
      end;
   finally
      parts.Free;
   end;
end;

procedure BubbleSort(var A: TIntArray);
var
   i, j, tmp: integer;
   swapped: boolean;
begin
   for i := High(A) downto 1 do
   begin
      swapped := False;
      for j := 0 to i - 1 do
         if A[j] > A[j + 1] then
         begin
            tmp := A[j];
            A[j] := A[j + 1];
            A[j + 1] := tmp;
            swapped := True;
         end;

      if not swapped then
         Exit;
   end;
end;

function FormatIntegerList(const a: TIntArray): string;
var
   i: integer;
begin
   Result := '';
   for i := 0 to High(a) do
   begin
      if i > 0 then
         Result += ', ';
      Result += IntToStr(a[i]);
   end;
end;

var
   rawArg: string;
   nums: TIntArray;
begin
   if ParamCount <> 1 then
      ShowUsage;

   rawArg := ParamStr(1);
   nums := ParseIntegerList(rawArg);

   BubbleSort(nums);
   Writeln(FormatIntegerList(nums));
end.

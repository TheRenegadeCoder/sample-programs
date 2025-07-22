program LongestPalindromicSubstring;

{$mode objfpc}{$H+}

uses
   SysUtils;

procedure ShowUsage;
begin
   Writeln('Usage: please provide a string that contains at least one palindrome');
   Halt(1);
end;

function PreprocessString(const s: string): string;
var
   builder: TStringBuilder;
   ch: char;
begin
   builder := TStringBuilder.Create;
   builder.Append('#');
   for ch in s do
   begin
      builder.Append(ch);
      builder.Append('#');
   end;
   Result := builder.ToString;
end;

function LongestPalindromicSubstring(const s: string): string;
var
   Processed: string;
   PalindromeRadii: array of integer;
   Center, RightBoundary, i, Mirror, LeftExpand, RightExpand, ProcessedLength: integer;
   MaxPalindromeLength, MaxCenterIndex, OriginalStartIndex: integer;

   function Min(A, B: integer): integer; inline;
   begin
      Result := B;
      if A < B then
         Result := A;
   end;

begin
   if s = '' then
      Exit('');

   Processed := PreprocessString(s);
   ProcessedLength := Length(Processed);
   SetLength(PalindromeRadii, ProcessedLength);

   Center := 0;
   RightBoundary := 0;
   MaxPalindromeLength := 0;
   MaxCenterIndex := 0;

   for i := 0 to ProcessedLength - 1 do
   begin
      Mirror := 2 * Center - i;
      if i < RightBoundary then
         PalindromeRadii[i] := Min(RightBoundary - i, PalindromeRadii[Mirror]);

      LeftExpand := i + (1 + PalindromeRadii[i]);
      RightExpand := i - (1 + PalindromeRadii[i]);

      while (LeftExpand < ProcessedLength) and (RightExpand >= 0) and
         (Processed[LeftExpand + 1] = Processed[RightExpand + 1]) do
      begin
         Inc(PalindromeRadii[i]);
         Inc(LeftExpand);
         Dec(RightExpand);
      end;

      if i + PalindromeRadii[i] > RightBoundary then
      begin
         Center := i;
         RightBoundary := i + PalindromeRadii[i];
      end;

      if PalindromeRadii[i] > MaxPalindromeLength then
      begin
         MaxPalindromeLength := PalindromeRadii[i];
         MaxCenterIndex := i;
      end;
   end;

   OriginalStartIndex := ((MaxCenterIndex - MaxPalindromeLength) div 2) + 1;
   Result := Copy(s, OriginalStartIndex, MaxPalindromeLength);
end;

var
   Input: string;
   LongestPalindrome: string;
begin
   if ParamCount <> 1 then
      ShowUsage;

   Input := ParamStr(1);

   if Trim(Input) = '' then
      ShowUsage;

   LongestPalindrome := LongestPalindromicSubstring(Input);

   if LongestPalindrome.Length = 1 then
      ShowUsage;

   Writeln(LongestPalindrome);
end.

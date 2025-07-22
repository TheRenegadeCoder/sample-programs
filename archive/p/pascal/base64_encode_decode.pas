program Base64EncodeDecode;

{$mode objfpc}{$H+}

uses
   base64,
   Classes,
   SysUtils;

procedure Usage;
begin
   Writeln('Usage: please provide a mode and a string to encode/decode');
   Halt(1);
end;

function IsBase64Char(c: char): boolean;
begin
   Result := (c in ['A'..'Z', 'a'..'z', '0'..'9', '+', '/', '=']);
end;

function IsValidBase64(const s: string): boolean;
var
   i, L, padCount, firstPadPos: integer;
begin
   L := Length(s);

   if (L = 0) or (L mod 4 <> 0) then
      Exit(False);

   for i := 1 to L do
      if not IsBase64Char(s[i]) then
         Exit(False);

   padCount := 0;
   for i := L downto 1 do
      if s[i] = '=' then
         Inc(padCount)
      else
         Break;

   if padCount > 2 then
      Exit(False);

   firstPadPos := Pos('=', s);
   if (firstPadPos > 0) and (firstPadPos <= L - padCount) then
      Exit(False);

   Result := True;
end;

var
   mode, textarg, outstr: string;
begin
   if ParamCount <> 2 then
      Usage;

   mode := LowerCase(ParamStr(1));
   textarg := ParamStr(2);

   if textarg = '' then
      Usage;

   if mode = 'encode' then
   begin
      outstr := EncodeStringBase64(textarg);
      Writeln(outstr);
   end
   else if (mode = 'decode') then
   begin
      if not IsValidBase64(textarg) then
         Usage;

      outstr := DecodeStringBase64(textarg);
      if outstr = '' then
         Usage;

      Writeln(outstr);
   end
   else
      Usage;
end.

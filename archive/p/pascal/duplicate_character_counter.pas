program DuplicateCharacterCounter;

{$mode objfpc}{$H+}

uses
   Classes,
   Generics.Collections,
   SysUtils;

type
   TSeenList = specialize TList<char>;
   TCountDictionary = specialize TDictionary<char, integer>;

procedure ShowUsage;
begin
   Writeln('Usage: please provide a string');
   Halt(1);
end;

function IsAlphanumeric(c: char): boolean;
begin
   Result := (c in ['0'..'9']) or (c in ['A'..'Z']) or (c in ['a'..'z']);
end;

procedure CountDuplicates(const Str: string);
var
   Counts: TCountDictionary;
   SeenCharacters: TSeenList;
   i: integer;
   Character: char;
   CurrentCount: integer;
   OutputtedAny: boolean;

   procedure OutputDuplicate(ch: char; cnt: integer);
   begin
      Writeln(ch, ': ', cnt);
   end;

begin
   Counts := TCountDictionary.Create;
   SeenCharacters := TSeenList.Create;
   try
      // Iterate over each char in the input string
      for Character in Str do
         if IsAlphanumeric(Character) then
            if not Counts.TryGetValue(Character, CurrentCount) then
            begin
               Counts.Add(Character, 1);
               SeenCharacters.Add(Character);
            end
            else
               Counts[Character] := CurrentCount + 1;

      // Output all characters with counts greater than 1 in the order they appeared
      OutputtedAny := False;
      for Character in SeenCharacters do
         if Counts[Character] > 1 then
         begin
            OutputDuplicate(Character, Counts[Character]);
            OutputtedAny := True;
         end;

      if not OutputtedAny then
         Writeln('No duplicate characters');
   finally
      Counts.Free;
      SeenCharacters.Free;
   end;
end;

var
   InputStr: string;
begin
   // Check for exactly one command-line argument, otherwise show usage
   if ParamCount <> 1 then
      ShowUsage;

   InputStr := Trim(ParamStr(1));
   if InputStr = '' then
      ShowUsage;

   CountDuplicates(InputStr);
end.

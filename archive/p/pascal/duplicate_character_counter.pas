program DuplicateCharacterCounter;

{$mode objfpc}{$H+}

uses
   Classes,
   Generics.Collections,
   SysUtils;

type
   TCountDictionary = specialize TDictionary<char, integer>;

procedure ShowUsage;
begin
   Writeln('Usage: please provide a string');
   Halt(1);
end;

function IsAlphanumeric(c: char): boolean;
begin
  Result := CharInSet(c, ['0'..'9', 'A'..'Z', 'a'..'z']);
end;

procedure CountDuplicates(const Str: string);
var
  Counts: TCountDictionary;
  Outputted: TCountDictionary;
  Character: char;
  CurrentCount: integer;
  HasDuplicates: boolean;
begin
  Counts := TCountDictionary.Create;
  Outputted := TCountDictionary.Create;
  try
    // Count all alphanumeric characters
    for Character in Str do
      if IsAlphanumeric(Character) then
      begin
        if not Counts.TryGetValue(Character, CurrentCount) then
          Counts.Add(Character, 1)
        else
          Counts[Character] := CurrentCount + 1;
      end;

    HasDuplicates := False;

    // Output duplicates in order of first appearance
    for Character in Str do
      if Counts.TryGetValue(Character, CurrentCount) and (CurrentCount > 1) and
         not Outputted.ContainsKey(Character) then
      begin
        Writeln(Character, ': ', CurrentCount);
        Outputted.Add(Character, 1);
        HasDuplicates := True;
      end;

    if not HasDuplicates then
      Writeln('No duplicate characters');
  finally
    Counts.Free;
    Outputted.Free;
  end;
end;

var
  InputStr: string;
begin
  if ParamCount <> 1 then
    ShowUsage;

  InputStr := Trim(ParamStr(1));
  if InputStr = '' then
    ShowUsage;

  CountDuplicates(InputStr);
end.



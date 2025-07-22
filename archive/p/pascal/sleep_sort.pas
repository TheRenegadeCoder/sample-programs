program SleepSort;

{$mode objfpc}{$H+}

uses
  {$ifdef unix}
  cthreads,
  {$endif}
  Classes,
  Generics.Collections,
  SysUtils,
  syncobjs;

type
  TIntegerList = specialize TList<integer>;

var
  Results: TIntegerList;
  Lock: TCriticalSection;

type
  TSleepSortThread = class(TThread)
  private
    FValue: integer;
  protected
    procedure Execute; override;
  public
    constructor Create(AValue: integer);
  end;

constructor TSleepSortThread.Create(AValue: integer);
begin
  inherited Create(False);
  FreeOnTerminate := False;
  FValue := AValue;
end;

procedure TSleepSortThread.Execute;
begin
  Sleep(FValue * 10);
  Lock.Acquire;
  try
    Results.Add(FValue);
  finally
    Lock.Release;
  end;
end;

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

var
  Numbers: TIntegerList;
  Threads: array of TSleepSortThread;
  i: integer;
begin
  if ParamCount <> 1 then
    ShowUsage;

  Numbers := ParseIntegerList(ParamStr(1));
  Results := TIntegerList.Create;
  Lock := TCriticalSection.Create;

  try
    SetLength(Threads, Numbers.Count);

    for i := 0 to Numbers.Count - 1 do
      Threads[i] := TSleepSortThread.Create(Numbers[i]);

    for i := 0 to High(Threads) do
    begin
      Threads[i].WaitFor;
      Threads[i].Free;
    end;

    Writeln(FormatIntegerList(Results));
  finally
    Numbers.Free;
    Results.Free;
    Lock.Free;
  end;
end.


program JobSequencing;

{$mode objfpc}{$H+}

uses
   Classes,
   Generics.Collections,
   Generics.Defaults,
   Math,
   StrUtils,
   SysUtils;

type
   TJobInfo = record
      JobId: integer;
      Profit: integer;
      Deadline: integer;
   end;
   TJobInfoList = specialize TList<TJobInfo>;
   TIntegerList = specialize TList<integer>;

procedure ShowUsage;
begin
   Writeln('Usage: please provide a list of profits and a list of deadlines');
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

function CompareJobs(const Left, Right: TJobInfo): integer;
begin
   // Compare profit descending
   if Left.Profit > Right.Profit then
      Exit(-1) // Left should come before Right
   else if Left.Profit < Right.Profit then
      Exit(1);

   // If profit equal, compare deadline descending
   if Left.Deadline > Right.Deadline then
      Exit(-1)
   else if Left.Deadline < Right.Deadline then
      Exit(1);

   Exit(0);
end;


function JobSequencing(const Profits, Deadlines: TIntegerList): integer;
type
   TJobComparer = specialize TComparer<TJobInfo>;
   TBooleanArray = specialize TArray<boolean>;
var
   Jobs: TJobInfoList;
   Job: TJobInfo;

   Slots: TBooleanArray;

   i, MaxDeadline: integer;
   TotalProfit, SlotIndex: integer;
begin
   Jobs := TJobInfoList.Create;
   try
      // Build job list
      Jobs.Capacity := Profits.Count;
      for i := 0 to Profits.Count - 1 do
      begin
         Job.JobID := i + 1;
         Job.Profit := Profits[i];
         Job.Deadline := Deadlines[i];
         Jobs.Add(Job);
      end;

      // Sort jobs by profit desc, deadline desc using a comparer
      Jobs.Sort(TJobComparer.Construct(@CompareJobs));

      // Find maximum deadline
      MaxDeadline := MaxValue(Deadlines.ToArray);

      // Initialize slots list with False (free)
      SetLength(Slots, MaxDeadline);
      for i := 0 to MaxDeadline - 1 do
         Slots[i] := False;

      TotalProfit := 0;
      for Job in Jobs do
      begin
         // Find free slot at or before deadline
         SlotIndex := Job.Deadline - 1;
         while (SlotIndex >= 0) and Slots[SlotIndex] do
            Dec(SlotIndex);

         if SlotIndex >= 0 then
         begin
            Slots[SlotIndex] := True;
            Inc(TotalProfit, Job.Profit);
         end;
      end;

      Result := TotalProfit;

   finally
      Jobs.Free;
   end;
end;

var
   Profits, Deadlines: TIntegerList;

begin
   if ParamCount <> 2 then
      ShowUsage;

   Profits := nil;
   Deadlines := nil;
   try
      Profits := ParseIntegerList(ParamStr(1));
      Deadlines := ParseIntegerList(ParamStr(2));

      if Profits.Count <> Deadlines.Count then
         ShowUsage;

      Writeln(JobSequencing(Profits, Deadlines));
   finally
      Profits.Free;
      Deadlines.Free;
   end;
end.

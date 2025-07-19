program ConvexHull;

{$mode objfpc}{$H+}

uses
   Classes,
   Generics.Collections,
   Sysutils;

type
   TPoint = record
      X, Y: integer;
   end;

   TPointList = specialize TList<TPoint>;
   TIntegerList = specialize TList<integer>;

procedure ShowUsage;
begin
   Writeln('Usage: please provide at least 3 x and y coordinates as separate lists (e.g. "100, 440, 210")');
   Halt(1);
end;

function ParseIntegerList(const S: string): TIntegerList;
var
   Tokens: TStringArray;
   Token: string;
   Value: integer;
begin
   if S.Trim.IsEmpty then
      ShowUsage;

   Tokens := S.Split([',']);
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

   if Result.Count < 3 then
   begin
      Result.Free;
      ShowUsage;
   end;
end;

function CheckListLengths(const Xs, Ys: TIntegerList): boolean;
begin
   if Xs.Count <> Ys.Count then
      Exit(False);

   if Xs.Count < 3 then
      Exit(false);

   Result := True;
end;

procedure QuickSortPoints(List: TPointList; Lo, Hi: integer);
var
   i, j: integer;
   Pivot, Temp: TPoint;

   procedure SwapElements(Index1, Index2: integer);
   var
      Temp: TPoint;
   begin
      Temp := List[Index1];
      List[Index1] := List[Index2];
      List[Index2] := Temp;
   end;

begin
   while Lo < Hi do
   begin
      i := Lo;
      j := Hi;
      Pivot := List[Lo + (Hi - Lo) div 2];

      repeat
         while (List[i].X < Pivot.X) or ((List[i].X = Pivot.X) and
               (List[i].Y < Pivot.Y)) do
            Inc(i);
         while (List[j].X > Pivot.X) or ((List[j].X = Pivot.X) and
               (List[j].Y > Pivot.Y)) do
            Dec(j);

         if i <= j then
         begin
            SwapElements(i, j);
            Inc(i);
            Dec(j);
         end;
      until i > j;

      if (j - Lo) < (Hi - i) then
      begin
         if Lo < j then QuickSortPoints(List, Lo, j);
         Lo := i;
      end
      else
      begin
         if i < Hi then QuickSortPoints(List, i, Hi);
         Hi := j;
      end;
   end;
end;

function Cross(const O, A, B: TPoint): int64;
begin
   Result := int64(A.X - O.X) * (B.Y - O.Y) - int64(A.Y - O.Y) * (B.X - O.X);
end;

procedure BuildHull(const Points: TPointList; Hull: TPointList);
var
   PointCount, i: integer;
   CurrentIndex, NextIndex, LeftmostIndex: integer;
begin
   PointCount := Points.Count;
   if PointCount < 3 then
   begin
      Hull.AddRange(Points);
      Exit;
   end;

   // Find the leftmost point (with lowest X; if tie, highest Y)
   LeftmostIndex := 0;
   for i := 1 to PointCount - 1 do
      if (Points[i].X < Points[LeftmostIndex].X) or
         ((Points[i].X = Points[LeftmostIndex].X) and
         (Points[i].Y > Points[LeftmostIndex].Y)) then
         LeftmostIndex := i;

   CurrentIndex := LeftmostIndex;
   repeat
      Hull.Add(Points[CurrentIndex]);

      NextIndex := (CurrentIndex + 1) mod PointCount;
      for i := 0 to PointCount - 1 do
         if Cross(Points[CurrentIndex], Points[i], Points[NextIndex]) < 0 then
            NextIndex := i;

      CurrentIndex := NextIndex;
   until CurrentIndex = LeftmostIndex;
end;

var
   Xs, Ys: TIntegerList;
   Points, Hull: TPointList;
   i: integer;
   Pt: TPoint;
begin
   if ParamCount <> 2 then
      ShowUsage;

   Xs := ParseIntegerList(ParamStr(1));
   Ys := ParseIntegerList(ParamStr(2));

   if not CheckListLengths(Xs, Ys) then
   begin
      Xs.Free;
      Ys.Free;
      ShowUsage;
   end;

   Points := TPointList.Create;
   Hull := TPointList.Create;
   try
      for i := 0 to Xs.Count - 1 do
      begin
         Pt.X := Xs[i];
         Pt.Y := Ys[i];
         Points.Add(Pt);
      end;

      QuickSortPoints(Points, 0, Points.Count - 1);
      BuildHull(Points, Hull);

      for i := 0 to Hull.Count - 1 do
         Writeln('(', Hull[i].X, ', ', Hull[i].Y, ')');

   finally
      Xs.Free;
      Ys.Free;
      Points.Free;
      Hull.Free;
   end;
end.

program ConvexHull;

{$mode objfpc}{$H+}

uses
   Classes,
   Sysutils;

type
   TIntPoint = record
      X, Y: integer;
   end;

   TIntPointArray = array of TIntPoint;
   TIntArray = array of integer;

procedure ShowUsage;
begin
   Writeln('Usage: please provide at least 3 x and y coordinates as separate lists (e.g. "100, 440, 210")');
   Halt(1);
end;

function ParseList(const S: string): TIntArray;
var
   parts: TStringList;
   i, code: integer;
   trimmed: string;
begin
   parts := TStringList.Create;
   try
      parts.StrictDelimiter := True;
      parts.Delimiter := ',';
      parts.DelimitedText := S;
      if parts.Count = 0 then
         ShowUsage;

      SetLength(Result, parts.Count);
      for i := 0 to parts.Count - 1 do
      begin
         trimmed := Trim(parts[i]);
         Val(trimmed, Result[i], code);
         if code <> 0 then
            ShowUsage;
      end;
   finally
      parts.Free;
   end;
end;

procedure QuickSortPoints(var A: array of TIntPoint; iLo, iHi: integer);
var
   i, j: integer;
   Pivot: TIntPoint;
   tmp: TIntPoint;
begin
   while iLo < iHi do
   begin
      Pivot := A[(iLo + iHi) shr 1];
      i := iLo;
      j := iHi;

      repeat
         while (A[i].X < Pivot.X) or ((A[i].X = Pivot.X) and
               (A[i].Y < Pivot.Y)) do
            Inc(i);
         while (A[j].X > Pivot.X) or ((A[j].X = Pivot.X) and
               (A[j].Y > Pivot.Y)) do
            Dec(j);

         if i <= j then
         begin
            tmp := A[i];
            A[i] := A[j];
            A[j] := tmp;
            Inc(i);
            Dec(j);
         end;
      until i > j;

      if (j - iLo) < (iHi - i) then
      begin
         if iLo < j then
            QuickSortPoints(A, iLo, j);
         iLo := i;
      end
      else
      begin
         if i < iHi then
            QuickSortPoints(A, i, iHi);
         iHi := j;
      end;
   end;
end;

function Cross(const O, A, B: TIntPoint): int64;
begin
   Result := int64(A.X - O.X) * (B.Y - O.Y) - int64(A.Y - O.Y) * (B.X - O.X);
end;

procedure BuildHull(const pts: TIntPointArray; out hull: TIntPointArray);
var
   n, l, p, q, i, hSize: integer;
begin
   n := Length(pts);
   if n < 3 then
   begin
      hull := Copy(pts, 0, n);
      Exit;
   end;

   l := 0;
   for i := 1 to n - 1 do
      if (pts[i].X < pts[l].X) or ((pts[i].X = pts[l].X) and
         (pts[i].Y > pts[l].Y)) then
         l := i;

   SetLength(hull, 0);
   p := l;
   repeat
      Inc(hSize);
      SetLength(hull, hSize);
      hull[hSize - 1] := pts[p];

      q := (p + 1) mod n;

      for i := 0 to n - 1 do
         if Cross(pts[p], pts[i], pts[q]) < 0 then
            q := i;

      p := q;
   until p = l;
end;

var
   xs, ys: TIntArray;
   pts, hull: TIntPointArray;
   n, i: integer;
begin
   if ParamCount <> 2 then
      ShowUsage;

   xs := ParseList(ParamStr(1));
   ys := ParseList(ParamStr(2));

   n := Length(xs);
   if (n < 3) or (Length(ys) <> n) then
      ShowUsage;

   SetLength(pts, n);
   for i := 0 to n - 1 do
   begin
      pts[i].X := xs[i];
      pts[i].Y := ys[i];
   end;

   QuickSortPoints(pts, 0, n - 1);

   BuildHull(pts, hull);

   for i := 0 to High(hull) do
      Writeln('(', hull[i].X, ', ', hull[i].Y, ')');
end.

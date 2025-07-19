program Dijkstra;

{$mode objfpc}{$H+}

uses
   Classes,
   Generics.Collections,
   SysUtils;

type
   TIntegerList = specialize TList<integer>;

procedure ShowUsage;
begin
   Writeln('Usage: please provide three inputs: a serialized matrix, a source node and a destination node');
   Halt(1);
end;

function ParseIntList(const S: string): TIntegerList;
var
   Parts: TStringArray;
   Part, TrimmedPart: string;
   Value: integer;
begin
   Result := TIntegerList.Create;
   if S = '' then
      Exit;

   Parts := S.Split([',']);
   for Part in Parts do
   begin
      TrimmedPart := Trim(Part);
      if TrimmedPart = '' then
      begin
         Result.Free;
         ShowUsage;
      end;
      if not TryStrToInt(TrimmedPart, Value) then
      begin
         Result.Free;
         ShowUsage;
      end;
      if Value < 0 then
      begin
         Result.Free;
         ShowUsage;
      end;
      Result.Add(Value);
   end;
end;

// Checks if the matrix is square, returns dimension or -1 if invalid
function MatrixDimension(const M: TIntegerList): integer;
var
   Len: integer;
   D: integer;
begin
   Len := M.Count;
   D := Trunc(Sqrt(Len));
   if (D * D = Len) and (D > 0) then
      Result := D
   else
      Result := -1;
end;

// Returns distance from src to dst or -1 if unreachable
function Dijkstra(const M: TIntegerList; Dim, Src, Dst: integer): integer;
const
   INF = MaxInt div 2;
var
   Dist: array of integer;
   Visited: array of boolean;
   I, J, MinDist, MinIndex, Weight: integer;
begin
   SetLength(Dist, Dim);
   SetLength(Visited, Dim);

   for I := 0 to Dim - 1 do
   begin
      Dist[I] := INF;
      Visited[I] := False;
   end;

   Dist[Src] := 0;

   for I := 0 to Dim - 1 do
   begin
      MinDist := INF;
      MinIndex := -1;

      // Find unvisited vertex with smallest dist
      for J := 0 to Dim - 1 do
         if (not Visited[J]) and (Dist[J] < MinDist) then
         begin
            MinDist := Dist[J];
            MinIndex := J;
         end;

      if MinIndex = -1 then
         Break; // No reachable vertex left

      Visited[MinIndex] := True;

      if MinIndex = Dst then
      begin
         // Early exit if destination reached
         Result := Dist[Dst];
         Exit;
      end;

      // Update neighbors
      for J := 0 to Dim - 1 do
      begin
         Weight := M[MinIndex * Dim + J];

         if (not Visited[J]) and (Weight > 0) and (Dist[MinIndex] +
            Weight < Dist[J]) then
            Dist[J] := Dist[MinIndex] + Weight;
      end;
   end;

   if Dist[Dst] = INF then
      Result := -1
   else
      Result := Dist[Dst];
end;

var
   MatrixStr, SrcStr, DstStr: string;
   MatrixList: TIntegerList;
   Dim, Src, Dst, Distance: integer;
begin
   if ParamCount <> 3 then
      ShowUsage;

   MatrixStr := Trim(ParamStr(1));
   SrcStr := Trim(ParamStr(2));
   DstStr := Trim(ParamStr(3));

   if (MatrixStr = '') or (SrcStr = '') or (DstStr = '') then
      ShowUsage;

   MatrixList := nil;
   try
      MatrixList := ParseIntList(MatrixStr);

      Dim := MatrixDimension(MatrixList);
      if Dim = -1 then
         ShowUsage;

      if (not TryStrToInt(SrcStr, Src)) or (not TryStrToInt(DstStr, Dst)) then
         ShowUsage;

      if (Src < 0) or (Src >= Dim) then
         ShowUsage;

      if (Dst < 0) or (Dst >= Dim) then
         ShowUsage;

      Distance := Dijkstra(MatrixList, Dim, Src, Dst);

      if Distance = -1 then
         ShowUsage
      else
         Writeln(distance);

   finally
      MatrixList.Free;
   end;
end.

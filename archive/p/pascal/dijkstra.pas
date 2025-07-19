program Dijkstra;

{$mode objfpc}{$H+}

uses
   Classes,
   Generics.Collections,
   Math,
   SysUtils;

type
   TIntegerList = specialize TList<integer>;
   TBooleanList = specialize TList<boolean>;

procedure ShowUsage;
begin
   Writeln('Usage: please provide three inputs: a serialized matrix, a source node and a destination node');
   Halt(1);
end;

function ParseIntegerList(const S: string): TIntegerList;
var
   Part: string;
   Value: integer;
begin
   if S.Trim.IsEmpty then ShowUsage;
   Result := TIntegerList.Create;
   for Part in S.Split([',']) do
   begin
      if not TryStrToInt(Trim(Part), Value) or (Value < 0) then
      begin
         Result.Free;
         ShowUsage;
      end;
      Result.Add(Value);
   end;
   if Result.Count = 0 then
   begin
      Result.Free;
      ShowUsage;
   end;
end;

// Checks if the matrix is square, returns dimension or -1 if invalid
function MatrixDimension(const Matrix: TIntegerList): integer; inline;
var
   Len: integer;
   D: integer;
begin
   Len := Matrix.Count;
   D := Floor(Sqrt(Len));
   if (D * D = Len) and (D > 0) then
      Result := D
   else
      Result := -1;
end;

// Returns distance from src to dst or -1 if unreachable
function Dijkstra(const Matrix: TIntegerList;
   Dimension, Source, Destination: integer): integer;
const
   INF = $3F3F3F3F;
var
   Dist: TIntegerList;
   Visited: TBooleanList;
   I, J, MinDist, MinIndex, Weight, CurrentDist: integer;
begin
   Dist := TIntegerList.Create;
   Visited := TBooleanList.Create;
   try
      Dist.Capacity := Dimension;
      Visited.Capacity := Dimension;

      for I := 0 to Dimension - 1 do
      begin
         Dist.Add(INF);
         Visited.Add(False);
      end;

      Dist[Source] := 0;

      for I := 0 to Dimension - 1 do
      begin
         MinDist := INF;
         MinIndex := -1;

         // Find closest unvisited node
         for J := 0 to Dimension - 1 do
            if (not Visited[J]) and (Dist[J] < MinDist) then
            begin
               MinDist := Dist[J];
               MinIndex := J;
            end;

         if MinIndex = -1 then
            Break;

         Visited[MinIndex] := True;
         CurrentDist := Dist[MinIndex];

         if MinIndex = Destination then
         begin
            Result := CurrentDist;
            Exit;
         end;

         for J := 0 to Dimension - 1 do
         begin
            Weight := Matrix[MinIndex * Dimension + J];
            if (not Visited[J]) and (Weight > 0) and
               (CurrentDist + Weight < Dist[J]) then
               Dist[J] := CurrentDist + Weight;
         end;
      end;

      if Dist[Destination] = INF then
         Result := -1
      else
         Result := Dist[Destination];

   finally
      Dist.Free;
      Visited.Free;
   end;
end;


var
   MatrixStr, SourceStr, DestinationStr: string;
   Matrix: TIntegerList;
   Dimension, Source, Destination, ShortestDistance: integer;
begin
   if ParamCount <> 3 then
      ShowUsage;

   MatrixStr := Trim(ParamStr(1));
   SourceStr := Trim(ParamStr(2));
   DestinationStr := Trim(ParamStr(3));

   if (MatrixStr = '') or (SourceStr = '') or (DestinationStr = '') then
      ShowUsage;

   Matrix := nil;
   try
      Matrix := ParseIntegerList(MatrixStr);

      Dimension := MatrixDimension(Matrix);

      // Check if:
      // - the matrix represents a valid square adjacency matrix (dimension <> 1)
      // - the source and destination nodes are valid integers
      // - the nodes are within valid index range [0, Dimension - 1]
      if (Dimension = -1) or (not TryStrToInt(SourceStr, Source)) or
         (not TryStrToInt(DestinationStr, Destination)) or (Source < 0) or
         (Source >= Dimension) or (Destination < 0) or (Destination >= Dimension) then

         ShowUsage;

      ShortestDistance := Dijkstra(Matrix, Dimension, Source, Destination);

      if ShortestDistance = -1 then
         ShowUsage
      else
         Writeln(ShortestDistance);

   finally
      Matrix.Free;
   end;
end.

program MinimumSpanningTree;

{$mode objfpc}{$H+}

uses
   Classes,
   Generics.Collections,
   Math,
   StrUtils,
   SysUtils;

type
   TIntegerList = specialize TList<integer>;

procedure ShowUsage;
begin
   Writeln('Usage: please provide a comma-separated list of integers');
   Halt(1);
end;

function ParseIntegerList(const S: string): TIntegerList;
var
   Tokens: TStringArray;
   Token: string;
   Value, Len, Dim: integer;
begin
   if S.Trim = '' then
      ShowUsage;

   Tokens := S.Split([',']);
   Len := Length(Tokens);
   // Minimum size should be a 2x2 matrix
   if Len < 4 then
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

   Dim := Trunc(Sqrt(Result.Count));
   if Dim * Dim <> Result.Count then
   begin
      Result.Free;
      ShowUsage;
   end;
end;

function CalculateMSTWeight(const AdjacencyMatrix: TIntegerList;
   Dimension: integer): integer;
var
   IncludedInMST: array of boolean;
   MinEdgeWeight: array of integer;
   i, NodeCount, CurrentNode, AdjacentNode, CurrentMinWeight: integer;
   TotalWeight, EdgeWeight: integer;
begin
   SetLength(IncludedInMST, Dimension);
   SetLength(MinEdgeWeight, Dimension);

   for i := 0 to Dimension - 1 do
   begin
      MinEdgeWeight[i] := High(integer);
      IncludedInMST[i] := False;
   end;

   MinEdgeWeight[0] := 0;
   TotalWeight := 0;

   for NodeCount := 0 to Pred(Dimension) do
   begin
      CurrentMinWeight := High(integer);
      CurrentNode := -1;

      // Find vertex with minimum key not yet included in MST
      for i := 0 to Dimension - 1 do
         if (not IncludedInMST[i]) and (MinEdgeWeight[i] < CurrentMinWeight) then
         begin
            CurrentMinWeight := MinEdgeWeight[i];
            CurrentNode := i;
         end;

      if CurrentNode = -1 then
      begin
         Writeln('Graph is not connected!');
         Exit(-1);
      end;

      IncludedInMST[CurrentNode] := True;
      Inc(TotalWeight, CurrentMinWeight);

      // Update edge weights for adjacent vertices
      for AdjacentNode := 0 to Dimension - 1 do
         if (not IncludedInMST[AdjacentNode]) then
         begin
            EdgeWeight := AdjacencyMatrix[CurrentNode * Dimension + AdjacentNode];
            if (EdgeWeight <> 0) and
               (EdgeWeight < MinEdgeWeight[AdjacentNode]) then
               MinEdgeWeight[AdjacentNode] := EdgeWeight;
         end;
   end;

   Result := TotalWeight;
end;

var
   Numbers: TIntegerList;
   MatrixDimension: integer;
begin
   if ParamCount <> 1 then
      ShowUsage;

   Numbers := ParseIntegerList(ParamStr(1));
   try
      MatrixDimension := Trunc(Sqrt(Numbers.Count));
      Writeln(CalculateMSTWeight(Numbers, MatrixDimension));
   finally
      Numbers.Free;
   end;
end.

program DepthFirstSearch;

{$mode objfpc}{$H+}

uses
   Classes,
   Generics.Collections,
   Sysutils;

type
   TIntegerList = specialize TList<integer>;
   TIntegerSet = specialize THashSet<integer>;
   TIntegerStack = specialize TStack<integer>;

   TNode = class
   private
      FChildSet: TIntegerSet;
   public
      Id: integer;
      Children: TIntegerList;
      constructor Create(AId: integer);
      destructor Destroy; override;
      procedure AddChild(ChildId: integer);
   end;

   TNodeDictionary = specialize TDictionary<integer, TNode>;

   { TTree }

   TTree = class
   private
      function ContainsNode(NodeId: integer): boolean;
   public
      RootId: integer;
      Nodes: TNodeDictionary;
      constructor Create(ARootId: integer);
      destructor Destroy; override;
      procedure AddNode(Node: TNode);
      function GetNode(NodeId: integer): TNode;
   end;

procedure ShowUsage;
begin
   Writeln('Usage: please provide a tree in an adjacency matrix form ("0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0") together with a list of vertex values ("1, 3, 5, 2, 4") and the integer to find ("4")');
   Halt(1);
end;

{ TNode }

constructor TNode.Create(AId: integer);
begin
   Id := AId;
   Children := TIntegerList.Create;
   FChildSet := TIntegerSet.Create;
end;

destructor TNode.Destroy;
begin
   Children.Free;
   FChildSet.Free;
   inherited;
end;

procedure TNode.AddChild(ChildId: integer); inline;
begin
   if FChildSet.Add(ChildId) then
      Children.Add(ChildId);
end;

{ TTree }

constructor TTree.Create(ARootId: integer);
begin
   RootId := ARootId;
   Nodes := TNodeDictionary.Create;
end;

destructor TTree.Destroy;
var
   Node: TNode;
begin
   for Node in Nodes.Values do
      Node.Free;
   Nodes.Free;
   inherited;
end;

procedure TTree.AddNode(Node: TNode); inline;
begin
   Nodes.AddOrSetValue(Node.Id, Node);
end;

// Retrieves a node by ID, or returns nil if not found
function TTree.GetNode(NodeId: integer): TNode; inline;
begin
   if not Nodes.TryGetValue(NodeId, Result) then
      Result := nil;
end;

function TTree.ContainsNode(NodeId: integer): boolean; inline;
begin
   Result := Nodes.ContainsKey(NodeId);
end;

function ParseIntegerList(const S: string): TIntegerList;
var
   Parts: TStringArray;
   Part: string;
   Value: integer;
begin
   if S.Trim.IsEmpty then
      ShowUsage;

   Parts := S.Split([',']);
   Result := TIntegerList.Create;
   try
      for Part in Parts do
      begin
         if not TryStrToInt(Trim(Part), Value) then
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
   except
      on E: Exception do
      begin
         Result.Free;
         ShowUsage;
      end;
   end;
end;

// Build tree from adjacency matrix and vertices
function CreateTree(const AdjMatrix, Vertices: TIntegerList): TTree;
var
   N, Row, Col, MatrixIndex: integer;
   Node: TNode;
   Vertex, AdjacentVertex: integer;
begin
   N := Vertices.Count;
   if (N = 0) or (AdjMatrix.Count <> N * N) then
      ShowUsage;

   // Create all nodes and add to tree
   Result := TTree.Create(Vertices.First);
   for Row in Vertices do
      Result.AddNode(TNode.Create(Row));

   // Populate children based on adjacency matrix
   MatrixIndex := 0;
   for Row := 0 to N - 1 do
   begin
      Node := Result.GetNode(Vertices[Row]);
      for Col := 0 to N - 1 do
      begin
         if AdjMatrix[MatrixIndex] <> 0 then
         begin
            AdjacentVertex := Vertices[Col];
            if not Result.ContainsNode(AdjacentVertex) then
            begin
               Result.Free;
               ShowUsage;
            end;
            Node.AddChild(AdjacentVertex);
         end;
         Inc(MatrixIndex);
      end;
   end;
end;

// Performs depth-first search for the target value.
// This uses the iterative version with a TStack for performance.
function DepthFirstSearch(Tree: TTree; Target: integer): boolean;
var
   Stack: TIntegerStack;
   Visited: TIntegerSet;
   CurrentId: integer;
   CurrentNode: TNode;
   ChildId: integer;
begin
   Result := False;
   if Tree = nil then Exit;

   Stack := TIntegerStack.Create;
   Visited := TIntegerSet.Create;
   try
      Stack.Capacity := Tree.Nodes.Count;
      Visited.Capacity := Tree.Nodes.Count;

      Stack.Push(Tree.RootId);

      while Stack.Count > 0 do
      begin
         CurrentId := Stack.Pop;

         if not Visited.Add(CurrentId) then
            Continue;

         if CurrentId = Target then
            Exit(True);

         CurrentNode := Tree.GetNode(CurrentId);
         if CurrentNode <> nil then
            for ChildId in CurrentNode.Children do
               Stack.Push(ChildId);
      end;
   finally
      Stack.Free;
      Visited.Free;
   end;
end;

var
   AdjMatrix, Vertices: TIntegerList;
   Target: integer;
   Tree: TTree;
begin
   if ParamCount <> 3 then
      ShowUsage;

   AdjMatrix := ParseIntegerList(ParamStr(1));
   Vertices := ParseIntegerList(ParamStr(2));
   if not TryStrToInt(ParamStr(3), Target) then
      ShowUsage;

   Tree := CreateTree(AdjMatrix, Vertices);
   try
      Writeln(BoolToStr(DepthFirstSearch(Tree, Target), 'true', 'false'));
   finally
      AdjMatrix.Free;
      Vertices.Free;
      Tree.Free;
   end;
end.

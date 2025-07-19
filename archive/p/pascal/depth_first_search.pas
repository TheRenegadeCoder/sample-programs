program DepthFirstSearch;

{$mode objfpc}{$H+}

uses
   Classes,
   Generics.Collections,
   Sysutils;

type
   TIntegerList = specialize TList<integer>;
   TIntegerSet = specialize THashSet<integer>;

   TNode = class
      Id: integer;
      Children: TIntegerList;
      ChildSet: TIntegerSet;
      constructor Create(AId: integer);
      destructor Destroy; override;
      procedure AddChild(ChildId: integer);
   end;

   TNodeDictionary = specialize TDictionary<integer, TNode>;

   { TTree }

   TTree = class
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
   ChildSet := TIntegerSet.Create;
end;

destructor TNode.Destroy;
begin
   Children.Free;
   ChildSet.Free;
   inherited;
end;

procedure TNode.AddChild(ChildId: integer);
begin
   if ChildSet.Add(ChildId) then
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

procedure TTree.AddNode(Node: TNode);
begin
   Nodes.AddOrSetValue(Node.Id, Node);
end;

// Retrieves a node by ID, or returns nil if not found
function TTree.GetNode(NodeId: integer): TNode;
begin
   if not Nodes.TryGetValue(NodeId, Result) then
      Result := nil;
end;

function ParseIntList(const S: string): TIntegerList;
var
   Parts: TStringArray;
   Part: string;
   Value: integer;
begin
   Result := TIntegerList.Create;

   if S = '' then
      Exit;

   Parts := S.Split([',']);
   for Part in Parts do
   try
      Value := StrToInt(Trim(Part));
      Result.Add(Value);
   except
      on E: EConvertError do
      begin
         Result.Free;
         ShowUsage;
      end;
   end;
end;

// Build tree from adjacency matrix and vertices
function CreateTree(AdjMatrix, Vertices: TIntegerList): TTree;
var
   Tree: TTree;
   Nodes: array of TNode;
   N, I, J, Index: integer;
begin
   N := Vertices.Count;
   Tree := TTree.Create(Vertices[0]);
   SetLength(Nodes, N);

   // Create all nodes
   for I := 0 to N - 1 do
   begin
      Nodes[I] := TNode.Create(Vertices[I]);
      Tree.AddNode(Nodes[I]);
   end;

   // Populate children according to adjacency matrix
   Index := 0;
   for I := 0 to N - 1 do
      for J := 0 to N - 1 do
      begin
         if (Index < AdjMatrix.Count) and (AdjMatrix[Index] <> 0) then
            Nodes[I].AddChild(Vertices[J]);
         Inc(Index);
      end;

   Result := Tree;
end;

// Performs depth-first search for the target value
function DFS(Tree: TTree; Target: integer): boolean;
var
   Visited: TIntegerSet;

   function DFSRec(Node: TNode): boolean;
   var
      ChildId: integer;
      ChildNode: TNode;
   begin
      if (Node = nil) or Visited.Contains(Node.Id) then
         Exit(False);
      if Node.Id = Target then
         Exit(True);

      Visited.Add(Node.Id);

      for ChildId in Node.Children do
      begin
         ChildNode := Tree.GetNode(ChildId);
         if DFSRec(ChildNode) then
            Exit(True);
      end;

      Result := False;
   end;

begin
   Visited := TIntegerSet.Create;
   try
      Result := DFSRec(Tree.GetNode(Tree.RootId));
   finally
      Visited.Free;
   end;
end;

var
   AdjMatrix, Vertices: TIntegerList;
   Target: integer;
   Tree: TTree;
begin
   AdjMatrix := nil;
   Vertices := nil;
   Tree := nil;

   // Validate argument count and that none of the parameters are empty
   if (ParamCount <> 3) or Trim(ParamStr(1)).IsEmpty or
      Trim(ParamStr(2)).IsEmpty or Trim(ParamStr(3)).IsEmpty then
      ShowUsage;

   try
      // Parse the adjacency matrix and vertices, or fail early
      AdjMatrix := ParseIntList(ParamStr(1));
      Vertices := ParseIntList(ParamStr(2));
      if not TryStrToInt(ParamStr(3), Target) then
         ShowUsage;

      // Build the tree
      Tree := CreateTree(AdjMatrix, Vertices);

      // Perform DFS and output result
      if DFS(Tree, Target) then
         WriteLn('true')
      else
         WriteLn('false');

   finally
      AdjMatrix.Free;
      Vertices.Free;
      Tree.Free;
   end;
end.


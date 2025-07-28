using System;
using System.Collections.Generic;
using System.Linq;

public record Node(int Id)
{
    private readonly HashSet<int> _childrenSet = new();
    private readonly List<int> _children = new();

    public IReadOnlyList<int> Children => _children;

    public void AddChild(int childId)
    {
        if (_childrenSet.Add(childId))
            _children.Add(childId);
    }
}

public class Tree
{
    private readonly Dictionary<int, Node> _nodes = new();

    public int RootId { get; }

    public Tree(int rootId) => RootId = rootId;

    public void AddNode(Node node) => _nodes[node.Id] = node;

    public Node? GetNode(int id) => _nodes.TryGetValue(id, out var node) ? node : null;

    public bool ContainsNode(int id) => _nodes.ContainsKey(id);

    public IReadOnlyCollection<Node> Nodes => _nodes.Values;
}

public static class DepthFirstSearch
{
    private static void ShowUsage()
    {
        Console.Error.WriteLine("Usage: please provide a tree in an adjacency matrix form (\"0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0\") together with a list of vertex values (\"1, 3, 5, 2, 4\") and the integer to find (\"4\")");
    }

    public static List<int> ParseIntegerList(string input)
    {
        if (string.IsNullOrWhiteSpace(input))
            throw new ArgumentException("Input string is null or whitespace");

        var parts = input.Split(',', StringSplitOptions.RemoveEmptyEntries | StringSplitOptions.TrimEntries);
        var list = new List<int>(parts.Length);

        foreach (var part in parts)
        {
            if (!int.TryParse(part, out var val))
                throw new ArgumentException($"Invalid integer value: '{part}'");
            list.Add(val);
        }

        if (list.Count < 1)
            throw new ArgumentException("List must contain at least one integer");

        return list;
    }

    public static Tree CreateTree(List<int> adjacencyMatrix, List<int> vertices)
    {
        int n = vertices.Count;

        if (adjacencyMatrix.Count != n * n)
            throw new ArgumentException("Adjacency matrix size does not match vertex count squared");

        var tree = new Tree(vertices[0]);

        foreach (var v in vertices)
            tree.AddNode(new Node(v));

        for (int row = 0; row < n; row++)
        {
            var currentNode = tree.GetNode(vertices[row])!;
            for (int col = 0; col < n; col++)
            {
                int matrixValue = adjacencyMatrix[row * n + col];
                if (matrixValue != 0)
                {
                    int childId = vertices[col];
                    if (!tree.ContainsNode(childId))
                        throw new ArgumentException("Adjacency matrix references unknown vertex");
                    currentNode.AddChild(childId);
                }
            }
        }

        return tree;
    }

    public static bool DFS(Tree tree, int target)
    {
        var visited = new HashSet<int>();
        var stack = new Stack<int>();
        stack.Push(tree.RootId);

        while (stack.Count > 0)
        {
            var current = stack.Pop();
            if (!visited.Add(current))
                continue;

            if (current == target)
                return true;

            var node = tree.GetNode(current);
            if (node is not null)
            {
                foreach (var child in node.Children)
                    stack.Push(child);
            }
        }

        return false;
    }

    public static int Main(string[] args)
    {
        if (args.Length != 3)
        {
            ShowUsage();
            return 1;
        }

        try
        {
            var adjacencyMatrix = ParseIntegerList(args[0]);
            var vertices = ParseIntegerList(args[1]);

            if (!int.TryParse(args[2], out var target))
            {
                ShowUsage();
                return 1;
            }

            var tree = CreateTree(adjacencyMatrix, vertices);
            bool found = DFS(tree, target);

            Console.WriteLine(found.ToString().ToLowerInvariant());
            return 0;
        }
        catch (ArgumentException ex)
        {
            Console.Error.WriteLine($"Error: {ex.Message}");
            ShowUsage();
            return 1;
        }
        catch (Exception ex)
        {
            Console.Error.WriteLine($"Unexpected error: {ex.Message}");
            return 1;
        }
    }
}
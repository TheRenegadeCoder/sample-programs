using System;
using System.Collections;

namespace DepthFirstSearch;

class Node<T>
{
    public T mId;
    public List<Node<T> *> mChildren = new .() ~ delete _;

    public this(T id)
    {
        mId = id;
    }

    public void AddChild(Node<T> *node)
    {
        mChildren.Add(node);
    }
}

class Graph<T>
{
    public List<Node<T>> mVertices = new .() ~ DeleteContainerAndItems!(_);

    public void AddNode(T id)
    {
        Node<T> node = new .(id);
        mVertices.Add(node);
    }
}

class Program
{
    public static void Usage()
    {
        Console.WriteLine(
            scope String("Usage: please provide a tree in an adjacency matrix form")
            .. AppendF(
                " {}",
                """
                ("0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0")
                """
            )
            .. AppendF(
                " {}",
                """
                together with a list of vertex values ("1, 3, 5, 2, 4") and the integer to find ("4")
                """
            )
        );
        Environment.Exit(0);
    }

    public static Result<T> ParseInt<T>(StringView str)
    where T : IParseable<T>
    {
        StringView trimmedStr = scope String(str);
        trimmedStr.Trim();

        // T.Parse ignores single quotes since they are treat as digit separators -- e.g. 1'000
        if (trimmedStr.Contains('\''))
        {
            return .Err;
        }

        return T.Parse(trimmedStr);
    }

    public static Result<void> ParseIntList<T>(StringView str, List<T> arr)
    where T: IParseable<T>
    {
        arr.Clear();
        for (StringView item in str.Split(','))
        {
            switch (ParseInt<T>(item))
            {
                case .Ok(let val):
                    arr.Add(val);

                case .Err:
                    return .Err;
            }
        }

        return .Ok;
    }

    public static Graph<T> CreateGraph<T>(List<int> connectionMatrix, List<T> vertices)
    where T : IHashable
    where int : operator T <=> T
    {
        // Create graph
        Graph<T> graph = new .();

        // Add vertices
        for (T id in vertices)
        {
            graph.AddNode(id);
        }

        // Add edges
        int row = 0;
        int col = 0;
        int numVertices = vertices.Count;
        for (int connection in connectionMatrix)
        {
            col++;
            if (col >= numVertices)
            {
                row++;
                col = 0;
            }

            if (connection != 0)
            {
                graph.mVertices[row].AddChild(&graph.mVertices[col]);
            }
        }

        return graph;
    }

    public static Node<T> *DepthFirstSearch<T>(Graph<T> graph, T target)
    where T : IHashable
    where int : operator T <=> T
    {
        HashSet<T> visited = scope .();
        return DepthFirstSearchRec<T>(&graph.mVertices[0], target, visited);
    }

    public static Node<T> *DepthFirstSearchRec<T>(Node<T> *node, T target, HashSet<T> visited)
    where T : IHashable
    where int : operator T <=> T
    {
        Node<T> *found = null;

        // If no node or target value found, return current node
        if (node == null || (*node).mId == target)
        {
            return node;
        }

        // Indicate node is visited
        visited.Add((*node).mId);

        // Perform depth first search on unvisited child node until found
        for (Node<T> *childNode in (*node).mChildren)
        {
            if (!visited.Contains((*childNode).mId))
            {
                found = DepthFirstSearchRec<T>(childNode, target, visited);
                if (found != null)
                {
                    break;
                }
            }
        }

        return found;
    }

    public static int Main(String[] args)
    {
        if (args.Count < 3)
        {
            Usage();
        }

        List<int> connectionMatrix = scope .();
        if (ParseIntList<int>(args[0], connectionMatrix) case .Err)
        {
            Usage();
        }

        List<int32> vertices = scope .();
        if (ParseIntList<int32>(args[1], vertices) case .Err)
        {
            Usage();
        }

        int32 target = ?;
        switch (ParseInt<int32>(args[2]))
        {
            case .Ok(out target):
            case .Err:
                Usage();
        }

        Graph<int32> graph = CreateGraph<int32>(connectionMatrix, vertices);
        Node<int32> *result = DepthFirstSearch<int32>(graph, target);
        Console.WriteLine((result != null) ? "true" : "false");
        delete graph;

        return 0;
    }
}

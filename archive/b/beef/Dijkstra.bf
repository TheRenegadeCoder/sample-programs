using System;
using System.Collections;

namespace System.Collections
{
    extension List<T>
    where T : IMinMaxValue<T>
    where int : operator T <=> T
    {
        public T Max()
        {
            T max = T.MinValue;
            for (T val in this)
            {
                if (val > max)
                {
                    max = val;
                }
            }

            return max;
        }
    }
}

namespace Dijkstra;

struct NodeItem<T>
{
    public int mIndex;
    public T mWeight;

    public this(int index, T weight)
    {
        mIndex = index;
        mWeight = weight;
    }
}

class Node<T>
{
    public int mIndex;
    public List<NodeItem<T>> mChildren = new .() ~ delete _;

    public this(int index)
    {
        mIndex = index;
    }

    public void AddChild(int index, T weight)
    {
        mChildren.Add(.(index, weight));
    }
}

class Tree<T>
where int : operator T <=> T
{
    public List<Node<T>> mVertices = new .() ~ DeleteContainerAndItems!(_);

    public this(List<T> weights, int numVertices)
    {
        // Create nodes
        for (int index < numVertices)
        {
            mVertices.Add(new .(index));
        }

        int index = 0;
        for (int row < numVertices)
        {
            for (int col < numVertices)
            {
                if (weights[index] > default(T))
                {
                    mVertices[row].AddChild(col, weights[index]);
                }

                index++;
            }
        }
    }
}

struct DijkstraResult<T>
{
    public int mPrev;
    public T mDist;

    public this(int prev, T dist)
    {
        mPrev = prev;
        mDist = dist;
    }
}

class Program
{
    public static void Usage()
    {
        Console.WriteLine(
            "Usage: please provide three inputs: a serialized matrix, a source node and a destination node"
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

    public static bool ValidateInputs<T>(List<T> weights, int numVertices, int src, int dest)
    where T : IMinMaxValue<T>
    where int : operator T <=> T
    {
        // Verify the following:
        // - Number of weights is a square
        // - Any non-zero weights
        // - Source and destination are in range
        int numWeights = weights.Count;
        return numWeights == numVertices * numVertices &&
            weights.Max() > default(T) &&
            src >= 0 && src < numWeights &&
            dest >= 0 && dest < numWeights;
    }

    // Source: https://en.wikipedia.org/wiki/Dijkstra%27s_algorithm#Pseudocode
    public static void Dijkstra<T>(Tree<T> tree, int src, List<DijkstraResult<T>> results)
    where T : IMinMaxValue<T>, operator T + T
    where int : operator T <=> T
    {
        // Initialize distances to infinite and previous vertices to undefined
        // Set source vertex distance to 0
        // Indicate all nodes unvisited
        int numVertices = tree.mVertices.Count;
        results.Clear();
        for (int index < numVertices)
        {
            results.Add(.(0, T.MaxValue));
        }

        results[src].mDist = default(T);
        HashSet<int> visited = scope . ();

        // While any unvisited nodes
        while (visited.Count < numVertices)
        {
            // Pick a vertex u with minimum distance from unvisited nodes
            int u = -1;
            T minDist = T.MaxValue;
            for (int index < numVertices)
            {
                T dist = results[index].mDist;
                if (!visited.Contains(index) && dist < minDist)
                {
                    u = index;
                    minDist = dist;
                }
            }

            // Indicate vertex u visited
            visited.Add(u);

            // For each unvisited neighbor v of vertex u
            for (NodeItem<T> item in tree.mVertices[u].mChildren)
            {
                int v = item.mIndex;
                T w = item.mWeight;
                if (!visited.Contains(v))
                {
                    // Get trial distance
                    T alt = results[u].mDist + w;

                    // If trial distance is smaller than distance v, update distance to v
                    // and update previous vertex
                    if (alt < results[v].mDist)
                    {
                        results[v] = .(u, alt);
                    }
                }
            }
        }
    }

    public static int Main(String[] args)
    {
        if (args.Count < 3)
        {
            Usage();
        }

        List<uint32> weights = scope .();
        int numVertices = ?;
        switch (ParseIntList<uint32>(args[0], weights))
        {
            case .Ok:
                numVertices = (int)Math.Round(Math.Sqrt(weights.Count));

            case .Err:
                Usage();
        }

        int src = ?;
        switch (ParseInt<int>(args[1]))
        {
            case .Ok(out src):
            case .Err:
                Usage();
        }

        int dest = ?;
        switch (ParseInt<int>(args[2]))
        {
            case .Ok(out dest):
            case .Err:
                Usage();
        }

        if (!ValidateInputs<uint32>(weights, numVertices, src, dest))
        {
            Usage();
        }

        Tree<uint32> tree = scope .(weights, numVertices);
        List<DijkstraResult<uint32>> results = scope .();
        Dijkstra<uint32>(tree, src, results);
        Console.WriteLine(results[dest].mDist);

        return 0;
    }
}

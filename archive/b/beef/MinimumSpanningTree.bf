using System;
using System.Collections;

namespace MinimumSpanningTree;

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

struct MstResult<T>
{
    public int mSrcIndex;
    public int mDestIndex;
    public T mWeight;

    public this(int srcIndex, int destIndex, T weight)
    {
        mSrcIndex = srcIndex;
        mDestIndex = destIndex;
        mWeight = weight;
    }
}

class MstResults<T>: List<MstResult<T>>
where T : operator T + T
{
    public T GetTotalMstWeight()
    {
        T total = default(T);
        for (MstResult<T> mstResult in this)
        {
            total += mstResult.mWeight;
        }

        return total;
    }
}

class Program
{
    public static void Usage()
    {
        Console.WriteLine("Usage: please provide a comma-separated list of integers");
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

    // Prim's Minimum Spanning Tree (MST) Algorithm based on C implementation of
    // https://www.geeksforgeeks.org/prims-minimum-spanning-tree-mst-greedy-algo-5/
    public static void PrimMst<T>(Tree<T> tree, MstResults<T> mstResults)
    where T : operator T + T, IMinMaxValue<T>
    where int : operator T <=> T
    {
        int numVertices = tree.mVertices.Count;

        // Indicate no parents yet, and initialize minimum weights to infinity
        List<int> parents = scope .();
        List<T> keys = scope .();
        for (int i < numVertices)
        {
            parents.Add(0);
            keys.Add(T.MaxValue);
        }

        // Indicate nothing in MST
        HashSet<int> mstSet = scope .();

        // Include first vertex in MST
        keys[0] = default(T);

        // While all nodes not in MST
        while (mstSet.Count < numVertices)
        {
            // Pick vertex of the minimum key value not already in MST
            int u = -1;
            T minWeight = T.MaxValue;
            for (int index < numVertices)
            {
                if (!mstSet.Contains(index) && keys[index] < minWeight)
                {
                    u = index;
                    minWeight = keys[index];
                }
            }

            // Add selected vertex
            mstSet.Add(u);

            // Update key values and parent indices of picked adjacent vertices,
            // only considering vertices not in MST
            for (NodeItem<T> item in tree.mVertices[u].mChildren)
            {
                int v = item.mIndex;
                T w = item.mWeight;
                if (!mstSet.Contains(v) && w < keys[v])
                {
                    parents[v] = u;
                    keys[v] = w;
                }
            }
        }

        // Construct MST results, skipping over root
        mstResults.Clear();
        for (int v in 1..<numVertices)
        {
            mstResults.Add(.(parents[v], v, keys[v]));
        }
    }

    public static int Main(String[] args)
    {
        if (args.Count < 1)
        {
            Usage();
        }

        List<int32> weights = scope .();
        int numWeights = ?;
        int numVertices = ?;
        switch (ParseIntList<int32>(args[0], weights))
        {
            case .Ok:
                numWeights = weights.Count;
                numVertices = (int)Math.Round(Math.Sqrt(numWeights));
                if (numWeights != numVertices * numVertices)
                {
                    Usage();
                }

            case .Err:
                Usage();
        }

        Tree<int32> tree = scope .(weights, numVertices);
        MstResults<int32> mstResults = scope .();
        PrimMst<int32>(tree, mstResults);
        Console.WriteLine(mstResults.GetTotalMstWeight());

        return 0;
    }
}

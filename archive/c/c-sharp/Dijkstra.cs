using System.Collections.Generic;

if (
    args is not [var matrixRaw, var sourceRaw, var destRaw]
    || !int.TryParse(sourceRaw, out int source)
    || !int.TryParse(destRaw, out int dest)
    || !TryParseList(matrixRaw.AsSpan(), out var matrix)
)
    return ExitWithUsage();

int n = (int)Math.Sqrt(matrix.Count);
if (n * n != matrix.Count)
    return ExitWithUsage();

if (source < 0 || dest < 0 || source >= n || dest >= n)
    return ExitWithUsage();

var graph = new List<(int to, uint w)>[n];
for (int i = 0; i < n; i++)
    graph[i] = new();

for (int u = 0; u < n; u++)
{
    int baseIndex = u * n;

    for (int v = 0; v < n; v++)
    {
        uint w = (uint)matrix[baseIndex + v];
        if (w != 0)
            graph[u].Add((v, w));
    }
}

uint result = Dijkstra(graph, source, dest);

if (result == uint.MaxValue)
    return ExitWithUsage();

Console.WriteLine(result);
return 0;

static uint Dijkstra(List<(int to, uint w)>[] graph, int source, int target)
{
    int n = graph.Length;

    uint[] dist = new uint[n];
    Array.Fill(dist, uint.MaxValue);

    var pq = new PriorityQueue<int, uint>();

    dist[source] = 0;
    pq.Enqueue(source, 0);

    while (pq.TryDequeue(out int u, out uint d))
    {
        if (d != dist[u])
            continue;

        if (u == target)
            return d;

        foreach (var (v, w) in graph[u])
        {
            uint nd = d + w;

            if (nd < dist[v])
            {
                dist[v] = nd;
                pq.Enqueue(v, nd);
            }
        }
    }

    return uint.MaxValue;
}

static bool TryParseList(ReadOnlySpan<char> view, out List<int> numbers)
{
    numbers = null!;
    if (view.IsWhiteSpace())
        return false;

    int expectedCount = view.Count(',') + 1;
    var list = new List<int>(expectedCount);

    while (!view.IsEmpty)
    {
        if (!TryParseNext(ref view, out int val) || val < 0)
            return false;

        list.Add(val);
    }

    numbers = list;
    return true;

    static bool TryParseNext(ref ReadOnlySpan<char> span, out int value)
    {
        int comma = span.IndexOf(',');

        ReadOnlySpan<char> token;
        if (comma >= 0)
        {
            token = span[..comma];
            span = span[(comma + 1)..];
        }
        else
        {
            token = span;
            span = default;
        }

        return int.TryParse(token, out value);
    }
}

static int ExitWithUsage()
{
    Console.Error.WriteLine(
        "Usage: please provide three inputs: a serialized matrix, a source node and a destination node"
    );
    return 1;
}

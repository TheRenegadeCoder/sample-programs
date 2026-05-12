using System.Collections.Generic;

if (
    args is not [var matrixRaw, var sourceRaw, var destRaw]
    || !uint.TryParse(sourceRaw, out uint source)
    || !uint.TryParse(destRaw, out uint dest)
)
{
    return ExitWithUsage();
}

if (!TryParseList(matrixRaw.AsSpan(), out var matrix))
    return ExitWithUsage();

uint n = (uint)Math.Sqrt(matrix.Count);
if (n * n != (uint)matrix.Count)
    return ExitWithUsage();

if (source >= n || dest >= n)
    return ExitWithUsage();

uint result = Dijkstra(matrix, n, source, dest);

if (result == uint.MaxValue)
    return ExitWithUsage();

Console.WriteLine(result);
return 0;

static uint Dijkstra(List<uint> matrix, uint n, uint source, uint target)
{
    uint[] dist = new uint[n];
    Array.Fill(dist, uint.MaxValue);

    PriorityQueue<uint, uint> pq = new();

    dist[source] = 0;
    pq.Enqueue(source, 0);

    while (pq.TryDequeue(out uint u, out uint d))
    {
        if (d > dist[u])
            continue;

        if (u == target)
            return d;

        uint baseIndex = u * n;

        for (uint v = 0; v < n; v++)
        {
            uint weight = matrix[(int)(baseIndex + v)];
            if (weight == 0)
                continue;

            uint newDist = d + weight;
            if (newDist < dist[v])
            {
                dist[v] = newDist;
                pq.Enqueue(v, newDist);
            }
        }
    }

    return dist[target];
}

static bool TryParseList(ReadOnlySpan<char> view, out List<uint> numbers)
{
    numbers = [];
    while (!view.IsEmpty)
    {
        if (!TryParseNextToken(ref view, out uint val))
            return false;

        numbers.Add(val);
    }
    return numbers.Count > 0;

    static bool TryParseNextToken(ref ReadOnlySpan<char> span, out uint value)
    {
        int comma = span.IndexOf(',');
        ReadOnlySpan<char> segment = comma == -1 ? span : span[..comma];
        bool success = uint.TryParse(segment.Trim(), out value);
        span = comma == -1 ? default : span[(comma + 1)..];
        return success;
    }
}

static int ExitWithUsage()
{
    Console.Error.WriteLine(
        "Usage: please provide three inputs: a serialized matrix, a source node and a destination node"
    );
    return 1;
}

using System.Collections.Generic;

if (
    args is not [var matrixRaw, var verticesRaw, var targetRaw]
    || !int.TryParse(targetRaw, out int target)
)
    return ExitWithUsage();

if (
    !TryParseList(verticesRaw.AsSpan(), out var vertices)
    || !TryParseList(matrixRaw.AsSpan(), out var matrix)
)
    return ExitWithUsage();

int n = vertices.Count;
if (matrix.Count != n * n)
    return ExitWithUsage();

var adj = new List<int>[n];
for (int i = 0; i < n; i++)
    adj[i] = new List<int>();

for (int row = 0; row < n; row++)
{
    int baseIndex = row * n;

    for (int col = 0; col < n; col++)
    {
        if (matrix[baseIndex + col] != 0)
            adj[row].Add(col);
    }
}

Console.WriteLine(DFS(adj, vertices, target).ToString().ToLowerInvariant());
return 0;

static bool DFS(List<int>[] adj, List<int> vertices, int target)
{
    int n = vertices.Count;
    if (n == 0)
        return false;

    var visited = new bool[n];
    var stack = new Stack<int>();

    stack.Push(0);

    while (stack.Count > 0)
    {
        int current = stack.Pop();

        if (visited[current])
            continue;

        visited[current] = true;

        if (vertices[current] == target)
            return true;

        var neighbors = adj[current];
        for (int i = 0; i < neighbors.Count; i++)
        {
            int next = neighbors[i];
            if (!visited[next])
                stack.Push(next);
        }
    }

    return false;
}

static bool TryParseList(ReadOnlySpan<char> view, out List<int> numbers)
{
    numbers = [];
    while (!view.IsEmpty)
    {
        if (!TryParseNextToken(ref view, out int val))
            return false;

        numbers.Add(val);
    }
    return numbers.Count > 0;

    static bool TryParseNextToken(ref ReadOnlySpan<char> span, out int value)
    {
        int comma = span.IndexOf(',');
        ReadOnlySpan<char> segment = comma == -1 ? span : span[..comma];
        bool success = int.TryParse(segment.Trim(), out value);
        span = comma == -1 ? default : span[(comma + 1)..];
        return success;
    }
}

static int ExitWithUsage()
{
    Console.Error.WriteLine(
        "Usage: please provide a tree in an adjacency matrix form (\"0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0\") together with a list of vertex values (\"1, 3, 5, 2, 4\") and the integer to find (\"4\")"
    );
    return 1;
}

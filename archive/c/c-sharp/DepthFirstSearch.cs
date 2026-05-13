if (args is not [var matrixRaw, var verticesRaw, var targetRaw] ||
    !int.TryParse(targetRaw, out int target) ||
    !TryParseList(verticesRaw.AsSpan(), out var vertices) ||
    !TryParseList(matrixRaw.AsSpan(), out var matrix))
{
    return Usage();
}

int n = vertices.Count;
if (matrix.Count != n * n)
    return Usage();

List<int>[] graph = new List<int>[n];
for (int i = 0; i < n; i++)
    graph[i] = [];

for (int r = 0; r < n; r++)
{
    int baseIdx = r * n;

    for (int c = 0; c < n; c++)
        if (matrix[baseIdx + c] != 0)
            graph[r].Add(c);
}

Console.WriteLine(
    DFS(graph, vertices, target).ToString().ToLowerInvariant()
);

return 0;

static bool DFS(List<int>[] graph, List<int> values, int target)
{
    int n = values.Count;
    var visited = new bool[n];
    var stack = new int[n];
    int sp = 0;

    stack[sp++] = 0;

    while (sp > 0)
    {
        int v = stack[--sp];
        if (visited[v]) continue;

        visited[v] = true;
        if (values[v] == target) return true;

        foreach (int next in graph[v])
            if (!visited[next])
                stack[sp++] = next;
    }

    return false;
}

static bool TryParseList(ReadOnlySpan<char> span, out List<int> numbers)
{
    numbers = new(span.Count(',') + 1);

    while (!span.IsEmpty)
    {
        int comma = span.IndexOf(',');
        var token = comma >= 0 ? span[..comma] : span;

        span = comma >= 0 ? span[(comma + 1)..] : [];

        if (!int.TryParse(token, out int n))
            return false;

        numbers.Add(n);
    }

    return true;
}

static int Usage()
{
    Console.Error.WriteLine(
        """Usage: please provide a tree in an adjacency matrix form ("0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0") together with a list of vertex values ("1, 3, 5, 2, 4") and the integer to find ("4")"""
    );
    return 1;
}

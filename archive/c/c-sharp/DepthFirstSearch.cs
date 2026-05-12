using System.Collections.Generic;

if (
    args is not [var matrixRaw, var verticesRaw, var targetRaw] ||
    !int.TryParse(targetRaw, out int target) ||
    !TryParseList(verticesRaw.AsSpan(), out var vertices) ||
    !TryParseList(matrixRaw.AsSpan(), out var matrix)
)
    return ExitWithUsage();

int n = vertices.Count;
if (matrix.Count != n * n)
    return ExitWithUsage();

// Compressed sparse row (CSR) format
// See: https://en.wikipedia.org/wiki/Sparse_matrix#Compressed_sparse_row_(CSR,_CRS_or_Yale_format)
int[] offsets = new int[n + 1];

// Count how many outgoing edges each node has
for (int i = 0; i < matrix.Count; i++)
{
    if (matrix[i] != 0)
        offsets[i / n + 1]++;
}

// Convert counts to starting indices
for (int i = 0; i < n; i++)
    offsets[i + 1] += offsets[i];

// Total number of edges is stored in offsets[n], and cursor tracks the next
// write position for each node's edges
int[] edges = new int[offsets[n]];
int[] cursor = (int[])offsets.Clone();

for (int row = 0; row < n; row++)
{
    int baseIndex = row * n;

    for (int col = 0; col < n; col++)
    {
        if (matrix[baseIndex + col] == 0)
            continue;

        // cursor[row] points to the next free slot for this row
        edges[cursor[row]++] = col;
    }
}

Console.WriteLine(
    DFS(edges, offsets, vertices, target).ToString().ToLowerInvariant()
);

return 0;

static bool DFS(int[] edges, int[] offsets, List<int> vertices, int target)
{
    int n = vertices.Count;
    if (n == 0)
        return false;

    var visited = new bool[n];
    var stack = new int[n];
    int sp = 0;

    stack[sp++] = 0;

    while (sp > 0)
    {
        int current = stack[--sp];

        if (visited[current])
            continue;

        visited[current] = true;

        if (vertices[current] == target)
            return true;

        int start = offsets[current];
        int end = offsets[current + 1];

        for (int i = start; i < end; i++)
        {
            int next = edges[i];
            if (!visited[next])
                stack[sp++] = next;
        }
    }

    return false;
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
        if (!TryParseNext(ref view, out int val))
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
        """Usage: please provide a tree in an adjacency matrix form ("0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0") together with a list of vertex values ("1, 3, 5, 2, 4") and the integer to find ("4")"""
    );
    return 1;
}

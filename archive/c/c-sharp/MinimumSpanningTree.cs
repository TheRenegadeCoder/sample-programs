if (args is not [var input] || !TryParseMatrix(input.AsSpan(), out var matrix, out int n))
    return ExitWithUsage();

int weight = MinimumSpanningTreeWeight(matrix, n);
if (weight < 0)
    return ExitWithUsage();

Console.WriteLine(weight);
return 0;

static int MinimumSpanningTreeWeight(List<int> matrix, int n)
{
    var inMst = new bool[n];
    var minEdge = new int[n];

    Array.Fill(minEdge, int.MaxValue);

    minEdge[0] = 0;

    int total = 0;

    for (int added = 0; added < n; added++)
    {
        int bestWeight = int.MaxValue;
        int u = -1;

        for (int i = 0; i < n; i++)
        {
            if (!inMst[i] && minEdge[i] < bestWeight)
            {
                bestWeight = minEdge[i];
                u = i;
            }
        }

        if (u < 0)
            return -1;

        inMst[u] = true;
        total += bestWeight;

        int row = u * n;

        for (int v = 0; v < n; v++)
        {
            int w = matrix[row + v];

            if (w != 0 && !inMst[v] && w < minEdge[v])
                minEdge[v] = w;
        }
    }

    return total;
}

static bool TryParseMatrix(ReadOnlySpan<char> view, out List<int> numbers, out int dimension)
{
    numbers = null!;
    dimension = 0;

    if (view.IsWhiteSpace())
        return false;

    int expected = view.Count(',') + 1;

    if (expected < 4)
        return false;

    var list = new List<int>(expected);

    while (!view.IsEmpty)
    {
        if (!TryParseNext(ref view, out int value))
            return false;

        list.Add(value);
    }

    dimension = (int)Math.Sqrt(list.Count);

    if (dimension * dimension != list.Count)
        return false;

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
    Console.Error.WriteLine("""Usage: please provide a comma-separated list of integers""");
    return 1;
}

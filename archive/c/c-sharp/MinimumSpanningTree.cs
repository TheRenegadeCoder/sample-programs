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
    if (expected < 4) return false;

    var list = new List<int>(expected);

    while (!view.IsEmpty)
    {
        int i = view.IndexOf(',');
        var token = i >= 0 ? view[..i] : view;

        view = i >= 0 ? view[(i + 1)..] : [];

        if (!int.TryParse(token, out int v))
            return false;

        list.Add(v);
    }

    int d = (int)Math.Sqrt(list.Count);
    if (d * d != list.Count)
        return false;

    numbers = list;
    dimension = d;
    return true;
}

static int ExitWithUsage()
{
    Console.Error.WriteLine("""Usage: please provide a comma-separated list of integers""");
    return 1;
}

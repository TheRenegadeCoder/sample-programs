using System.Runtime.InteropServices;

if (args is not [var colsRaw, var rowsRaw, var matrixRaw]
    || !int.TryParse(colsRaw, out int cols)
    || !int.TryParse(rowsRaw, out int rows)
    || cols <= 0 || rows <= 0
    || !TryParseMatrix(matrixRaw.AsSpan(), out var matrix)
    || matrix.Count != cols * rows)
{
    return ExitWithUsage();
}

Console.WriteLine(string.Join(", ", Transpose(matrix, cols, rows)));
return 0;

static List<int> Transpose(List<int> m, int cols, int rows)
{
    var o = new List<int>(m.Count);
    for (int i = 0; i < m.Count; i++) o.Add(0);

    var src = CollectionsMarshal.AsSpan(m);
    var dst = CollectionsMarshal.AsSpan(o);

    for (int r = 0; r < rows; r++)
    for (int c = 0; c < cols; c++)
        dst[c * rows + r] = src[r * cols + c];

    return o;
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
    Console.Error.WriteLine(
        """Usage: please enter the dimension of the matrix and the serialized matrix"""
    );
    return 1;
}

using System.Collections.Generic;
using System.Runtime.InteropServices;

if (
    args is not [var colsRaw, var rowsRaw, var matrixRaw]
    || !int.TryParse(colsRaw, out int cols)
    || !int.TryParse(rowsRaw, out int rows)
    || cols <= 0
    || rows <= 0
    || !TryParseMatrix(matrixRaw.AsSpan(), out var matrix)
    || matrix.Count != cols * rows
)
{
    return ExitWithUsage();
}

var result = Transpose(matrix, cols, rows);
Console.WriteLine(string.Join(", ", result));
return 0;

static List<int> Transpose(List<int> matrix, int cols, int rows)
{
    var output = new List<int>(matrix.Count);
    for (int i = 0; i < matrix.Count; i++)
        output.Add(0);

    Span<int> src = CollectionsMarshal.AsSpan(matrix);
    Span<int> dst = CollectionsMarshal.AsSpan(output);

    for (int r = 0; r < rows; r++)
    {
        int rowBase = r * cols;

        for (int c = 0; c < cols; c++)
        {
            int oldIndex = rowBase + c;
            int newIndex = c * rows + r;

            dst[newIndex] = src[oldIndex];
        }
    }

    return output;
}

static bool TryParseMatrix(ReadOnlySpan<char> view, out List<int> numbers)
{
    numbers = null!;
    if (view.IsEmpty)
        return false;

    int expected = view.Count(',') + 1;
    var list = new List<int>(expected);

    while (!view.IsEmpty)
    {
        if (!TryParseNext(ref view, out int value))
            return false;

        list.Add(value);
    }

    return list.Count > 0 && (numbers = list) != null;

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
        """Usage: please enter the dimension of the matrix and the serialized matrix"""
    );
    return 1;
}

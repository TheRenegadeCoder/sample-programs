using System.Collections.Generic;

if (args is not [var raw1, var raw2] ||
    !TryParseList(raw1.AsSpan(), out var a) ||
    !TryParseList(raw2.AsSpan(), out var b))
{
    Console.WriteLine("""
Usage: please provide two lists in the format "1, 2, 3, 4, 5"
""");
    return;
}

var lcs = BuildLCS(a, b);

Console.WriteLine(string.Join(", ", lcs));

static List<int> BuildLCS(List<int> a, List<int> b)
{
    int n = a.Count;
    int m = b.Count;

    if (n == 0 || m == 0)
        return [];

    int[][] dp = new int[n + 1][];
    for (int i = 0; i <= n; i++)
        dp[i] = new int[m + 1];

    // Build DP
    for (int i = 1; i <= n; i++)
    {
        int ai = a[i - 1];
        var prevRow = dp[i - 1];
        var currRow = dp[i];

        for (int j = 1; j <= m; j++)
        {
            if (ai == b[j - 1])
                currRow[j] = prevRow[j - 1] + 1;
            else
                currRow[j] = Math.Max(prevRow[j], currRow[j - 1]);
        }
    }

    var result = new List<int>(dp[n][m]);

    int x = n, y = m;

    while (x > 0 && y > 0)
    {
        if (a[x - 1] == b[y - 1])
        {
            result.Add(a[x - 1]);
            x--;
            y--;
        }
        else if (dp[x - 1][y] >= dp[x][y - 1])
        {
            x--;
        }
        else
        {
            y--;
        }
    }

    result.Reverse();
    return result;
}

static bool TryParseList(ReadOnlySpan<char> view, out List<int> numbers)
{
    numbers = null!;

    if (view.IsWhiteSpace())
        return false;

    int expected = view.Count(',') + 1;
    var list = new List<int>(expected);

    while (!view.IsEmpty)
    {
        if (!TryParseNext(ref view, out int val))
            return false;

        list.Add(val);
    }

    numbers = list;
    return list.Count > 0;

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
using System.Collections.Generic;

if (
    args is not [var raw1, var raw2]
    || !TryParseList(raw1.AsSpan(), out var a)
    || !TryParseList(raw2.AsSpan(), out var b)
)
{
    Console.WriteLine(
        """
Usage: please provide two lists in the format "1, 2, 3, 4, 5"
"""
    );
    return;
}

Console.WriteLine(string.Join(", ", LCS(a, b)));

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

static List<int> LCS(List<int> a, List<int> b)
{
    int n = a.Count, m = b.Count;
    if (n == 0 || m == 0) return [];

    int[,] dp = new int[n + 1, m + 1];

    for (int i = 1; i <= n; i++)
    for (int j = 1; j <= m; j++)
        dp[i, j] = a[i - 1] == b[j - 1]
            ? dp[i - 1, j - 1] + 1
            : Math.Max(dp[i - 1, j], dp[i, j - 1]);

    var result = new List<int>(dp[n, m]);

    int i2 = n, j2 = m;

    while (i2 > 0 && j2 > 0)
    {
        if (a[i2 - 1] == b[j2 - 1])
        {
            result.Add(a[i2 - 1]);
            i2--;
            j2--;
        }
        else if (dp[i2 - 1, j2] >= dp[i2, j2 - 1])
        {
            i2--;
        }
        else
        {
            j2--;
        }
    }

    result.Reverse();
    return result;
}

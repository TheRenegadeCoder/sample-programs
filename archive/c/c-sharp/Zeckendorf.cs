using System.Globalization;

public static class Zeckendorf
{
    private static readonly long[] Fibs = GenerateFibs();

    private static long[] GenerateFibs()
    {
        var fs = new List<long> { 1, 2 };
        while (long.MaxValue - fs[^1] >= fs[^2])
        {
            fs.Add(fs[^1] + fs[^2]);
        }
        return [.. fs];
    }

    public static void Main(string[] args)
    {
        if (args.Length == 0 || !long.TryParse(args[0], NumberStyles.None, CultureInfo.InvariantCulture, out var n) || n < 0)
        {
            Console.WriteLine("Usage: please input a non-negative integer");
            return;
        }

        if (n == 0) return;

        Span<long> terms = stackalloc long[Fibs.Length];
        int count = Decompose(n, terms);

        PrintResults(terms[..count]);
    }

    private static int Decompose(long n, Span<long> terms)
    {
        int count = 0;
        int i = Array.BinarySearch(Fibs, n);
        if (i < 0) i = ~i - 1;

        for (; i >= 0 && n > 0; i--)
        {
            if (Fibs[i] <= n)
            {
                terms[count++] = Fibs[i];
                n -= Fibs[i];
            }
        }
        return count;
    }

    private static void PrintResults(ReadOnlySpan<long> terms) =>
        Console.WriteLine(string.Join(", ", terms.ToArray()));
}
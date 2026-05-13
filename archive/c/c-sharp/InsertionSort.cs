using System.Runtime.InteropServices;

if (args is not [var input] || !TryParseList(input.AsSpan(), out var numbers))
    return Usage();

InsertionSort(CollectionsMarshal.AsSpan(numbers));

Console.WriteLine(string.Join(", ", numbers));
return 0;

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

    return numbers.Count > 1;
}

static void InsertionSort(Span<int> xs)
{
    for (int i = 1; i < xs.Length; i++)
    {
        int x = xs[i];
        if (x >= xs[i - 1])
            continue;

        int lo = 0,
            hi = i;

        while (lo < hi)
        {
            int mid = (lo + hi) >> 1;

            if (x >= xs[mid])
                lo = mid + 1;
            else
                hi = mid;
        }

        xs[lo..i].CopyTo(xs[(lo + 1)..]);
        xs[lo] = x;
    }
}

static int Usage()
{
    Console.Error.WriteLine(
        """
Usage: please provide a list of at least two integers to sort in the format "1, 2, 3, 4, 5"
"""
    );
    return 1;
}

using System.Collections.Generic;
using System.Runtime.InteropServices;
using System.Buffers;

if (args is not [var input] || !TryParseList(input.AsSpan(), out var numbers))
    return ExitWithUsage();

Span<int> span = CollectionsMarshal.AsSpan(numbers);
QuickSort(span);

Console.WriteLine(string.Join(", ", numbers));
return 0;

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

    if (list.Count < 2)
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

static void QuickSort(Span<int> span)
{
    if (span.Length <= 1)
        return;

    int lo = 0;
    int hi = span.Length - 1;

    Sort(span, lo, hi);

    static void Sort(Span<int> s, int lo, int hi)
    {
        while (lo < hi)
        {
            int p = Partition(s, lo, hi);

            // Tail recursion elimination: sort smaller side first
            if (p - lo < hi - p)
            {
                Sort(s, lo, p - 1);
                lo = p + 1;
            }
            else
            {
                Sort(s, p + 1, hi);
                hi = p - 1;
            }
        }
    }

    static int Partition(Span<int> s, int lo, int hi)
    {
        int pivot = s[hi];
        int i = lo;

        for (int j = lo; j < hi; j++)
        {
            if (s[j] <= pivot)
            {
                (s[i], s[j]) = (s[j], s[i]);
                i++;
            }
        }

        (s[i], s[hi]) = (s[hi], s[i]);
        return i;
    }
}

static int ExitWithUsage()
{
    Console.WriteLine(
        "Usage: please provide a list of at least two integers to sort in the format \"1, 2, 3, 4, 5\""
    );
    return 1;
}

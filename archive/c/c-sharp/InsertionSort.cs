using System.Collections.Generic;
using System.Runtime.InteropServices;

if (args is not [var input])
    return ExitWithUsage();

if (!TryParseList(input.AsSpan(), out var numbers))
    return ExitWithUsage();

InsertionSort(numbers);

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

static void InsertionSort(List<int> xs)
{
    int n = xs.Count;
    if (n < 2)
        return;

    Span<int> span = CollectionsMarshal.AsSpan(xs);

    for (int i = 1; i < n; i++)
    {
        int key = span[i];

        if (key >= span[i - 1])
            continue;

        int low = 0;
        int high = i;
        while (low < high)
        {
            int mid = low + ((high - low) >> 1);
            if (key >= span[mid])
                low = mid + 1;
            else
                high = mid;
        }

        // SIMD-optimized block shift
        span.Slice(low, i - low).CopyTo(span.Slice(low + 1));
        span[low] = key;
    }
}

static int ExitWithUsage()
{
    Console.WriteLine(
        "Usage: please provide a list of at least two integers to sort in the format \"1, 2, 3, 4, 5\""
    );
    return 1;
}

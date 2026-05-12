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
    numbers = [];

    while (!view.IsEmpty)
    {
        if (!TryParseNextToken(ref view, out int val))
            return false;

        numbers.Add(val);
    }

    return numbers.Count >= 2;

    static bool TryParseNextToken(ref ReadOnlySpan<char> span, out int value)
    {
        int comma = span.IndexOf(',');
        ReadOnlySpan<char> segment = comma == -1 ? span : span[..comma];

        bool success = int.TryParse(segment.Trim(), out value);

        // Advance the span: if no more commas, we're done (set to Empty)
        span = comma == -1 ? default : span[(comma + 1)..];

        return success;
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

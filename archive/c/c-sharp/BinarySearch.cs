using System;
using System.Collections.Generic;

if (args is not [var input, var targetRaw] || !int.TryParse(targetRaw, out int target))
    return ExitWithUsage();

if (!TryParseSortedList(input.AsSpan(), out var numbers))
    return ExitWithUsage();

Console.WriteLine(BinarySearch(numbers, target));
return 0;

static bool TryParseSortedList(ReadOnlySpan<char> view, out List<int> numbers)
{
    numbers = new List<int>();

    while (!view.IsEmpty)
    {
        if (!TryParseNextToken(ref view, out int val))
            return false;

        // Check if array is sorted increasing
        if (numbers is [.., var last] && val < last)
            return false;

        numbers.Add(val);
    }

    return numbers.Count > 0;

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

static bool BinarySearch(List<int> list, int target)
{
    int lo = 0;
    int hi = list.Count - 1;

    while (lo <= hi)
    {
        int mid = lo + ((hi - lo) / 2);
        int midValue = list[mid];

        if (midValue == target)
            return true;
        if (midValue < target)
            lo = mid + 1;
        else
            hi = mid - 1;
    }
    return false;
}

static int ExitWithUsage()
{
    Console.WriteLine(
        "Usage: please provide a list of sorted integers (\"1, 4, 5, 11, 12\") and the integer to find (\"11\")"
    );
    return 1;
}

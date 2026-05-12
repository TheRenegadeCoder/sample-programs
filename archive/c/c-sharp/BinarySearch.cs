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
    int? previous = null;

    while (!view.IsEmpty)
    {
        int comma = view.IndexOf(',');

        ReadOnlySpan<char> segment = comma == -1
            ? view
            : view[..comma];

        segment = segment.Trim();

        if (!int.TryParse(segment, out int val))
            return false;

        if (previous.HasValue && val < previous.Value)
            return false;

        previous = val;
        numbers.Add(val);

        if (comma < 0)
            break;

        view = view[(comma + 1)..];
    }

    return numbers.Count > 0;
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

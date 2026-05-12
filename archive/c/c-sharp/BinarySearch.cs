using System;
using System.Collections.Generic;

if (args is not [var input, var targetRaw] || !int.TryParse(targetRaw, out int target))
    return ExitWithUsage();

var numbers = TryParseSortedList(input.AsSpan());

if (numbers is null)
    return ExitWithUsage();

Console.WriteLine(BinarySearch(numbers, target).ToString().ToLower());
return 0;

static List<int>? TryParseSortedList(ReadOnlySpan<char> view)
{
    List<int> numbers = [];

    while (!view.IsEmpty)
    {
        int comma = view.IndexOf(',');
        ReadOnlySpan<char> segment = comma == -1 ? view : view[..comma];

        if (!int.TryParse(segment.Trim(), out int val))
            return null;

        if (numbers is [.., var last] && val < last)
            return null;

        numbers.Add(val);

        if (comma == -1)
            break;
        view = view[(comma + 1)..];
    }

    return numbers.Count == 0 ? null : numbers;
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

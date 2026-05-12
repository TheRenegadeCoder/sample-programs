using System;
using System.Collections.Generic;

if (args is not [var input, var targetRaw] || !int.TryParse(targetRaw, out int target))
    return ExitWithUsage();

if (!TryParseSortedList(input.AsSpan(), out var numbers))
    return ExitWithUsage();

Console.WriteLine(numbers.BinarySearch(target) >= 0);
return 0;

static bool TryParseSortedList(ReadOnlySpan<char> view, out List<int> numbers)
{
    numbers = null!;
    if (view.IsWhiteSpace()) return false;

    int expectedCount = view.Count(',') + 1;
    var list = new List<int>(expectedCount);
    int last = int.MinValue;

    while (!view.IsEmpty)
    {
        if (!TryParseNext(ref view, out int val) || val < last)
            return false;

        list.Add(val);
        last = val;
    }

    numbers = list;
    return numbers.Count > 0;

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

static int ExitWithUsage()
{
    Console.WriteLine(
        """Usage: please provide a list of sorted integers ("1, 4, 5, 11, 12") and the integer to find ("11")"""
    );
    return 1;
}

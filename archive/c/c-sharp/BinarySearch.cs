using System.Collections.Generic;

if (args is not [var input, var targetRaw]
    || !int.TryParse(targetRaw, out int target)
    || !TryParseSorted(input.AsSpan(), out var numbers))
{
    return Usage();
}

Console.WriteLine(numbers.BinarySearch(target) >= 0);
return 0;

static bool TryParseSorted(ReadOnlySpan<char> span, out List<int> numbers)
{
    numbers = new(span.Count(',') + 1);

    int last = int.MinValue;

    while (!span.IsEmpty)
    {
        int comma = span.IndexOf(',');
        var token = comma >= 0 ? span[..comma] : span;

        span = comma >= 0 ? span[(comma + 1)..] : [];

        if (!int.TryParse(token, out int n) || n < last)
            return false;

        numbers.Add(n);
        last = n;
    }

    return numbers.Count > 0;
}

static int Usage()
{
    Console.Error.WriteLine(
        """Usage: please provide a list of sorted integers ("1, 4, 5, 11, 12") and the integer to find ("11")"""
    );

    return 1;
}
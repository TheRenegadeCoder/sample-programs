if (
    args is not [var input, var targetRaw]
    || !int.TryParse(targetRaw, out int target)
    || !TryParseList(input.AsSpan(), out var numbers)
)
    return Usage();

Console.WriteLine(numbers.Contains(target));
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

    return numbers.Count > 0;
}

static int Usage()
{
    Console.WriteLine(
        """Usage: please provide a list of integers ("1, 4, 5, 11, 12") and the integer to find ("11")"""
    );
    return 1;
}

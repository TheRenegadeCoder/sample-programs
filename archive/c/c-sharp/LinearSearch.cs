using System.Collections.Generic;

if (
    args is not [var input, var targetRaw]
    || !int.TryParse(targetRaw, out int target)
    || !TryParseList(input.AsSpan(), out var numbers)
)
    return ExitWithUsage();

Console.WriteLine(numbers.Contains(target));
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

static int ExitWithUsage()
{
    Console.WriteLine(
        """Usage: please provide a list of integers ("1, 4, 5, 11, 12") and the integer to find ("11")"""
    );
    return 1;
}

if (args is not [var input] || !TryParseList(input.AsSpan(), out var numbers))
    return ExitWithUsage();

Console.WriteLine(MaximumRotationSum(numbers));
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

static int MaximumRotationSum(List<int> numbers)
{
    int n = numbers.Count;

    int totalSum = numbers[0];
    int rotationSum = 0;

    for (int i = 1; i < n; i++)
    {
        int v = numbers[i];
        totalSum += v;
        rotationSum += v * i;
    }

    int best = rotationSum;

    for (int i = 1, last = n - 1; i < n; i++, last--)
    {
        rotationSum += totalSum - n * numbers[last];
        best = Math.Max(best, rotationSum);
    }

    return best;
}

static int ExitWithUsage()
{
    Console.WriteLine(
        "Usage: please provide a list of integers (e.g. \"8, 3, 1, 2\")"
    );
    return 1;
}

if (args is not [var input] || !TryParseList(input.AsSpan(), out var numbers))
    return ExitWithUsage();

Console.WriteLine(MaximumRotationSum(numbers));
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

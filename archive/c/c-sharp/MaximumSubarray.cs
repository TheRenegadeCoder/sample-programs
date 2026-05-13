if (
    args is not [var input]
    || string.IsNullOrWhiteSpace(input)
    || !TryParseList(input.AsSpan(), out var numbers)
)
    return ExitWithUsage();

Console.WriteLine(MaximumSubarraySum(numbers));
return 0;

static int MaximumSubarraySum(List<int> numbers)
{
    int current = numbers[0];
    int best = numbers[0];

    for (int i = 1; i < numbers.Count; i++)
    {
        int v = numbers[i];
        current = Math.Max(v, current + v);
        best = Math.Max(current, best);
    }

    return best;
}

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

    return true;
}

static int ExitWithUsage()
{
    Console.Error.WriteLine(
        "Usage: Please provide a list of integers in the format: \"1, 2, 3, 4, 5\""
    );
    return 1;
}

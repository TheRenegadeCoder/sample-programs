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
    Console.Error.WriteLine(
        "Usage: Please provide a list of integers in the format: \"1, 2, 3, 4, 5\""
    );
    return 1;
}

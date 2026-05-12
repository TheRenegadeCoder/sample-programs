using System.Collections.Generic;

if (args is not [var input])
    return ExitWithUsage();

if (!TryParseList(input.AsSpan(), out var numbers))
    return ExitWithUsage();

BubbleSort(numbers);

Console.WriteLine(string.Join(", ", numbers));
return 0;

static bool TryParseList(ReadOnlySpan<char> view, out List<int> numbers)
{
    numbers = [];

    while (!view.IsEmpty)
    {
        if (!TryParseNextToken(ref view, out int val))
            return false;

        numbers.Add(val);
    }

    return numbers.Count >= 2;

    static bool TryParseNextToken(ref ReadOnlySpan<char> span, out int value)
    {
        int comma = span.IndexOf(',');
        ReadOnlySpan<char> segment = comma == -1 ? span : span[..comma];

        bool success = int.TryParse(segment.Trim(), out value);

        // Advance the span: if no more commas, we're done (set to Empty)
        span = comma == -1 ? default : span[(comma + 1)..];

        return success;
    }
}

static void BubbleSort(List<int> xs)
{
    int n = xs.Count;

    for (int i = 0; i < n - 1; i++)
    {
        bool swapped = false;

        for (int j = 0; j < n - i - 1; j++)
        {
            if (xs[j] > xs[j + 1])
            {
                (xs[j], xs[j + 1]) = (xs[j + 1], xs[j]);
                swapped = true;
            }
        }

        if (!swapped)
            break;
    }
}

static int ExitWithUsage()
{
    Console.WriteLine(
        "Usage: please provide a list of at least two integers to sort in the format \"1, 2, 3, 4, 5\""
    );
    return 1;
}

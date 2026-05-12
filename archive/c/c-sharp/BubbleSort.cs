using System.Collections.Generic;
using System.Runtime.InteropServices;

if (args is not [var input] || !TryParseList(input.AsSpan(), out var numbers))
    return ExitWithUsage();

BubbleSort(numbers);

Console.WriteLine(string.Join(", ", numbers));
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

    if (list.Count < 2)
        return false;

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

static void BubbleSort(List<int> list)
{
    if (list.Count < 2) 
        return;

    Span<int> span = CollectionsMarshal.AsSpan(list);
    int n = span.Length;

    for (int i = 0; i < n - 1; i++)
    {
        bool swapped = false;

        for (int j = 0; j < n - i - 1; j++)
        {
            if (span[j] > span[j + 1])
            {
                (span[j], span[j + 1]) = (span[j + 1], span[j]);
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

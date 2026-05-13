using System.Collections.Generic;
using System.Runtime.InteropServices;

if (args is not [var input] || !TryParseList(input.AsSpan(), out var numbers))
    return ExitWithUsage();

SelectionSort(numbers);

Console.WriteLine(string.Join(", ", numbers));
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

    return numbers.Count > 1;
}

static void SelectionSort(List<int> list)
{
    if (list.Count < 2)
        return;

    Span<int> span = CollectionsMarshal.AsSpan(list);

    int n = span.Length;

    for (int i = 0; i < n - 1; i++)
    {
        int minIndex = i;

        for (int j = i + 1; j < n; j++)
        {
            if (span[j] < span[minIndex])
                minIndex = j;
        }

        if (minIndex != i)
            (span[i], span[minIndex]) = (span[minIndex], span[i]);
    }
}

static int ExitWithUsage()
{
    Console.WriteLine(
        "Usage: please provide a list of at least two integers to sort in the format \"1, 2, 3, 4, 5\""
    );
    return 1;
}

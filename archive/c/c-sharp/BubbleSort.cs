using System.Runtime.InteropServices;

if (args is not [var input] || !TryParseList(input.AsSpan(), out var numbers))
    return Usage();

BubbleSort(numbers);

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

static void BubbleSort(List<int> list)
{
    Span<int> span = CollectionsMarshal.AsSpan(list);
    int n = span.Length;

    for (int i = 0; i < n - 1; i++)
    {
        bool swapped = false;

        for (int j = 0; j < n - i - 1; j++)
        {
            if (span[j] <= span[j + 1])
                continue;

            (span[j], span[j + 1]) = (span[j + 1], span[j]);
            swapped = true;
        }

        if (!swapped)
            return;
    }
}


static int Usage()
{
    Console.Error.WriteLine("""
Usage: please provide a list of at least two integers to sort in the format "1, 2, 3, 4, 5"
"""
    );
    return 1;
}
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
    numbers = new List<int>();

    while (!view.IsEmpty)
    {
        int comma = view.IndexOf(',');

        ReadOnlySpan<char> segment = comma < 0 ? view : view[..comma];

        segment = segment.Trim();

        if (segment.IsEmpty || !int.TryParse(segment, out int val))
            return false;

        numbers.Add(val);

        if (comma < 0)
            break;

        view = view[(comma + 1)..];
    }

    return numbers.Count >= 2;
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

using System.Collections.Generic;
using System.Runtime.InteropServices;
using System.Buffers;

if (args is not [var input] || !TryParseList(input.AsSpan(), out var numbers))
    return ExitWithUsage();

Span<int> span = CollectionsMarshal.AsSpan(numbers);
MergeSort(span);

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

// Bottom-up merge sort
static void MergeSort(Span<int> span)
{
    int n = span.Length;
    if (n <= 1)
        return;

    int[] buffer = new int[n];

    Span<int> src = span;
    Span<int> dst = buffer;

    for (int width = 1; width < n; width *= 2)
    {
        for (int left = 0; left < n; left += width * 2)
        {
            int mid = Math.Min(left + width, n);
            int right = Math.Min(left + width * 2, n);

            Merge(
                src[left..mid],
                src[mid..right],
                dst[left..right]
            );
        }

        Span<int> temp = src;
        src = dst;
        dst = temp;
    }

    // if final data ended up in buffer, copy back
    if (!src.Overlaps(span))
        src.CopyTo(span);
}

static void Merge(
    ReadOnlySpan<int> left,
    ReadOnlySpan<int> right,
    Span<int> target)
{
    int li = 0;
    int ri = 0;
    int ti = 0;

    while (li < left.Length && ri < right.Length)
    {
        target[ti++] = left[li] <= right[ri]
            ? left[li++]
            : right[ri++];
    }

    left[li..].CopyTo(target[ti..]);
    right[ri..].CopyTo(target[ti..]);
}

static int ExitWithUsage()
{
    Console.WriteLine(
        "Usage: please provide a list of at least two integers to sort in the format \"1, 2, 3, 4, 5\""
    );
    return 1;
}

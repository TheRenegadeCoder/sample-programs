using System;
using System.Collections.Generic;
using System.Globalization;

if (args is not [var raw] ||
    !long.TryParse(raw, out long n) ||
    n < 0)
{
    return ExitWithUsage();
}

if (n == 0)
    return 0;

ReadOnlySpan<long> fibs = GenerateFibs();
Span<long> buffer = stackalloc long[fibs.Length];

int count = Decompose(n, fibs, buffer);
Console.WriteLine(string.Join(", ", buffer[..count].ToArray()));

return 0;

static int Decompose(long n, ReadOnlySpan<long> fibs, Span<long> result)
{
    int count = 0;

    for (int i = fibs.Length - 1; i >= 0 && n > 0; i--)
    {
        long f = fibs[i];

        if (f <= n)
        {
            result[count++] = f;
            n -= f;
        }
    }

    return count;
}

static int ExitWithUsage()
{
    Console.WriteLine("Usage: please input a non-negative integer");
    return 1;
}

static long[] GenerateFibs()
{
    var list = new List<long> { 1, 2 };

    while (true)
    {
        long next = list[^1] + list[^2];
        if (next < 0 || next > long.MaxValue - list[^1])
            break;

        list.Add(next);
    }

    return list.ToArray();
}
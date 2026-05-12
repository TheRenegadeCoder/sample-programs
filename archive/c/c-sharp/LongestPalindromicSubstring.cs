using System;

if (args is not { Length: > 0 })
    return ExitWithUsage();

string input = string.Join(' ', args);

string result = LongestPalindrome(input);

if (result.Length < 2)
    return ExitWithUsage();

Console.WriteLine(result);
return 0;

static string LongestPalindrome(string input)
{
    int length = input.Length;
    if (length < 2)
        return "";

    char[] transformed = new char[2 * length + 3];
    int[] radius = new int[transformed.Length];

    int index = 0;
    transformed[index++] = '^';

    ReadOnlySpan<char> source = input;

    for (int i = 0; i < length; i++)
    {
        transformed[index++] = '#';
        transformed[index++] = source[i];
    }

    transformed[index++] = '#';
    transformed[index++] = '$';

    int center = 0;
    int rightBoundary = 0;

    int bestRadius = 0;
    int bestCenter = 0;

    for (int i = 1; i < index - 1; i++)
    {
        int mirror = 2 * center - i;

        if (i < rightBoundary)
            radius[i] = Math.Min(rightBoundary - i, radius[mirror]);

        while (transformed[i + radius[i] + 1] == transformed[i - radius[i] - 1])
            radius[i]++;

        if (i + radius[i] > rightBoundary)
        {
            center = i;
            rightBoundary = i + radius[i];
        }

        if (radius[i] > bestRadius)
        {
            bestRadius = radius[i];
            bestCenter = i;
        }
    }

    if (bestRadius < 2)
        return "";

    int startIndex = (bestCenter - bestRadius) / 2;

    return input.AsSpan(startIndex, bestRadius).ToString();
}

static int ExitWithUsage()
{
    Console.WriteLine("Usage: please provide a string that contains at least one palindrome");
    return 1;
}
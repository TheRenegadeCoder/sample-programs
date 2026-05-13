if (args is not { Length: > 0 })
    return Usage();

string result = LongestPalindrome(string.Join(' ', args));

if (result.Length < 2)
    return Usage();

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

    foreach (char c in source)
    {
        transformed[index++] = '#';
        transformed[index++] = c;
    }

    transformed[index++] = '#';
    transformed[index++] = '$';

    int center = 0;
    int rightBoundary = 0;

    int bestCenter = 0;
    int bestRadius = 0;

    for (int i = 1; i < index - 1; i++)
    {
        int mirror = 2 * center - i;
        int R = radius[i];

        if (i < rightBoundary)
            R = Math.Min(rightBoundary - i, radius[mirror]);

        while (transformed[i + R + 1] == transformed[i - R - 1])
            R++;

        radius[i] = R;
        int expandedRight = i + R;

        center = expandedRight > rightBoundary ? i : center;
        rightBoundary = Math.Max(expandedRight, rightBoundary);

        bool isBest = R > bestRadius;
        bestRadius = isBest ? R : bestRadius;
        bestCenter = isBest ? i : bestCenter;
    }

    if (bestRadius < 2)
        return "";

    int startIndex = (bestCenter - bestRadius) / 2;
    return input.AsSpan(startIndex, bestRadius).ToString();
}

static int Usage()
{
    Console.Error.WriteLine("Usage: please provide a string that contains at least one palindrome");
    return 1;
}

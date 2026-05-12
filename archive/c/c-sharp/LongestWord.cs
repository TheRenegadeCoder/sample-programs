if (args is not [var sentence] || string.IsNullOrWhiteSpace(sentence))
    return ExitWithUsage();

ReadOnlySpan<char> span = sentence.AsSpan();

int maxLength = 0;
int currentLength = 0;

foreach (char c in span)
{
    if (char.IsWhiteSpace(c))
    {
        maxLength = Math.Max(currentLength, maxLength);
        currentLength = 0;
        continue;
    }

    currentLength++;
}

maxLength = Math.Max(currentLength, maxLength);

Console.WriteLine(maxLength);
return 0;

static int ExitWithUsage()
{
    Console.WriteLine("Usage: please provide a string");
    return 1;
}
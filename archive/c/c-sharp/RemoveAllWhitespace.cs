if (args is not [var input] || string.IsNullOrEmpty(input))
    return ExitWithError();

RemoveWhitespace(input.AsSpan());
return 0;

static void RemoveWhitespace(ReadOnlySpan<char> input)
{
    char[] buffer = new char[input.Length];
    int j = 0;

    foreach (char c in input)
    {
        if (!char.IsWhiteSpace(c))
            buffer[j++] = c;
    }

    Console.WriteLine(new string(buffer, 0, j));
}

static int ExitWithError()
{
    Console.WriteLine("Usage: please provide a string");
    return 1;
}
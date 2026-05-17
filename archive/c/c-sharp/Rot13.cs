if (args is not [var input] || string.IsNullOrEmpty(input))
    return ExitWithUsage();

Console.WriteLine(Rot13(input.AsSpan()));
return 0;

static string Rot13(ReadOnlySpan<char> input)
{
    char[] result = new char[input.Length];

    for (int i = 0; i < input.Length; i++)
    {
        char c = input[i];
        result[i] = c switch
        {
            >= 'a' and <= 'z' => (char)('a' + (c - 'a' + 13) % 26),
            >= 'A' and <= 'Z' => (char)('A' + (c - 'A' + 13) % 26),
            _ => c,
        };
    }

    return new string(result);
}

static int ExitWithUsage()
{
    Console.WriteLine("Usage: please provide a string to encrypt");
    return 1;
}

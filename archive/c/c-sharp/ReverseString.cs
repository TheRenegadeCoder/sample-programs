if (args is [var input] && !string.IsNullOrEmpty(input))
    Console.WriteLine(Reverse(input.AsSpan()));

static string Reverse(ReadOnlySpan<char> s)
{
    int n = s.Length;
    char[] result = new char[n];

    for (int i = 0; i < n; i++)
        result[i] = s[n - 1 - i];

    return new string(result);
}
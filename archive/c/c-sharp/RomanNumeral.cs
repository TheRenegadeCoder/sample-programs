if (args is not [var input])
    return ExitWith("Usage: please provide a string of roman numerals");

if (!TryRomanToInt(input.AsSpan().Trim(), out int value))
    return ExitWith("Error: invalid string of roman numerals");

Console.WriteLine(value);
return 0;

static bool TryRomanToInt(ReadOnlySpan<char> roman, out int result)
{
    result = 0;
    if (roman.Length == 0)
        return true;

    int prev = 0;

    for (int i = roman.Length - 1; i >= 0; i--)
    {
        if (!TryGetValue(roman[i], out int current))
            return false;

        if (current < prev)
            result -= current;
        else
            result += current;

        prev = current;
    }

    return true;
}

static bool TryGetValue(char c, out int value)
{
    value = char.ToUpper(c) switch
    {
        'I' => 1,
        'V' => 5,
        'X' => 10,
        'L' => 50,
        'C' => 100,
        'D' => 500,
        'M' => 1000,
        _ => 0
    };

    return value != 0;
}

static int ExitWith(string message)
{
    Console.WriteLine(message);
    return 1;
}
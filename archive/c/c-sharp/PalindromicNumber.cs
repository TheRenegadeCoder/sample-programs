if (args is not [var raw] || !ulong.TryParse(raw.AsSpan(), out ulong number))
    return ExitWithUsage();

Console.WriteLine(IsPalindrome(number) ? "true" : "false");
return 0;

static bool IsPalindrome(ulong value)
{
    if (value < 10)
        return true;

    if (value % 10 == 0)
        return false;

    ulong reversedHalf = 0;

    while (value > reversedHalf)
    {
        reversedHalf = reversedHalf * 10 + value % 10;
        value /= 10;
    }

    return value == reversedHalf ||
           value == reversedHalf / 10;
}

static int ExitWithUsage()
{
    Console.WriteLine("Usage: please input a non-negative integer");
    return 1;
}
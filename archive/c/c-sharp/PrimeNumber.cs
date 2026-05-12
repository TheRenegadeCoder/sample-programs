if (args is not [var raw] || !ulong.TryParse(raw, out ulong number))
    return ExitWithUsage();

Console.WriteLine(IsPrime(number) ? "Prime" : "Composite");
return 0;

static bool IsPrime(ulong value)
{
    if (value < 2)
        return false;

    if (value == 2)
        return true;

    if (value % 2 == 0)
        return false;

    for (ulong divisor = 3; divisor * divisor <= value; divisor += 2)
    {
        if (value % divisor == 0)
            return false;
    }

    return true;
}

static int ExitWithUsage()
{
    Console.WriteLine("Usage: please input a non-negative integer");
    return 1;
}

if (args is not [var sentence] || string.IsNullOrWhiteSpace(sentence))
    return Usage();

int max = 0,
    cur = 0;

foreach (char c in sentence)
{
    if (char.IsWhiteSpace(c))
    {
        cur = 0;
        continue;
    }

    cur++;
    max = Math.Max(cur, max);
}

Console.WriteLine(max);
return 0;

static int Usage()
{
    Console.Error.WriteLine("Usage: please provide a string");
    return 1;
}

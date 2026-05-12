if (args is not [string input, ..] || string.IsNullOrWhiteSpace(input))
{
    Console.WriteLine("Usage: please provide a string");
    return;
}

if (char.IsUpper(input[0]))
{
    Console.WriteLine(input);
    return;
}

string output = string.Create(
    input.Length,
    input,
    static (span, str) =>
    {
        str.CopyTo(span);
        span[0] = char.ToUpperInvariant(span[0]);
    }
);

Console.WriteLine(output);

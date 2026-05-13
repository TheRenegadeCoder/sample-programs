if (args is not [string input, ..] || string.IsNullOrWhiteSpace(input))
{
    Console.Error.WriteLine("Usage: please provide a string");
    return;
}

char c = input[0];

if (char.IsLower(c))
    input = char.ToUpperInvariant(c) + input[1..];

Console.WriteLine(input);
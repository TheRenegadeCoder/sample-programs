if (args is not [var input] || string.IsNullOrWhiteSpace(input))
{
    Console.Error.WriteLine("Usage: please provide a string");
    return;
}

Span<int> freq = stackalloc int[128];

foreach (char c in input)
    if (c < 128)
        freq[c]++;

bool found = false;

foreach (char c in input)
{
    if (c >= 128 || freq[c] < 2)
        continue;

    Console.WriteLine($"{c}: {freq[c]}");
    freq[c] = 0;
    found = true;
}

if (!found)
    Console.WriteLine("No duplicate characters");
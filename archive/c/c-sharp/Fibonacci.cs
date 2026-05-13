if (args is not [var input] || !int.TryParse(input, out int n) || n < 0)
{
    Console.Error.WriteLine("Usage: please input the count of fibonacci numbers to output");
    return;
}

int a = 1, b = 1;

for (int i = 1; i <= n; i++)
{
    Console.WriteLine($"{i}: {a}");
    (a, b) = (b, a + b);
}
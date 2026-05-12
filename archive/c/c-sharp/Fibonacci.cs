if (args is not [var input] || !int.TryParse(input, out int n) || n < 0)
{
    Console.WriteLine("Usage: please input the count of fibonacci numbers to output");
    return;
}

int index = 1;
foreach (var value in Fibonacci(n))
{
    Console.WriteLine($"{index++}: {value}");
}

static IEnumerable<int> Fibonacci(int n)
{
    int a = 1, b = 1;

    for (int i = 0; i < n; i++)
    {
        yield return a;
        (a, b) = (b, a + b);
    }
}
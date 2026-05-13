if (args is not [var input] || !int.TryParse(input, out int n))
{
    Console.Error.WriteLine("Usage: please input a number");
    return;
}

Console.WriteLine(n % 2 == 0 ? "Even" : "Odd");
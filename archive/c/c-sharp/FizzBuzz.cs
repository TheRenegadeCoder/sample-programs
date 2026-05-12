for (int i = 1; i <= 100; i++)
{
    Console.WriteLine(FizzBuzz(i));
}

static string FizzBuzz(int n)
{
    bool fizz = n % 3 == 0;
    bool buzz = n % 5 == 0;

    return (fizz, buzz) switch
    {
        (true, true) => "FizzBuzz",
        (true, false) => "Fizz",
        (false, true) => "Buzz",
        _ => n.ToString()
    };
}
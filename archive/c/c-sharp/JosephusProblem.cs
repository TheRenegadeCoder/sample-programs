const string Usage = "Usage: please input the total number of people and number of people to skip.";

if (args is not [var nText, var kText] ||
    !int.TryParse(nText, out var n) ||
    !int.TryParse(kText, out var k) ||
    n <= 0 || k <= 0)
{
    Console.WriteLine(Usage);
    return;
}

Console.WriteLine(Josephus(n, k));

static int Josephus(int n, int k)
{
    int result = 0;

    for (int m = 2; m <= n; m++)
    {
        result = (result + k) % m;
    }

    return result + 1;
}
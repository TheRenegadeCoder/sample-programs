if (
    args is not [var nText, var kText]
    || !int.TryParse(nText, out int n)
    || !int.TryParse(kText, out int k)
    || n <= 0
    || k <= 0
)
{
    Console.Error.WriteLine(
        "Usage: please input the total number of people and number of people to skip."
    );
    return;
}

int survivor = 0;
for (int i = 2; i <= n; i++)
    survivor = (survivor + k) % i;

Console.WriteLine(survivor + 1);

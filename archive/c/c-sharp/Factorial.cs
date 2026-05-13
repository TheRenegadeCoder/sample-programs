using System.Numerics;

if (args is not [var input] || !BigInteger.TryParse(input, out var n) || n < 0)
{
    Console.Error.WriteLine("Usage: please input a non-negative integer");
    return;
}

Console.WriteLine(Factorial(n));

static BigInteger Factorial(BigInteger n) => n < 2 ? BigInteger.One : MultiplyRange(2, n);

static BigInteger MultiplyRange(BigInteger lo, BigInteger hi)
{
    if (lo > hi)
        return BigInteger.One;
    if (lo == hi)
        return lo;
    if (hi - lo == 1)
        return lo * hi;

    BigInteger mid = (lo + hi) / 2;
    return MultiplyRange(lo, mid) * MultiplyRange(mid + 1, hi);
}

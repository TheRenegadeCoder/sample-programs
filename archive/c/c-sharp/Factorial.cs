using System.Numerics;

if (args is not [var input] || !BigInteger.TryParse(input, out var n) || n < 0)
{
    Console.WriteLine("Usage: please input a non-negative integer");
    return;
}

Console.WriteLine(n.Factorial());

public static class BigIntegerExtensions
{
    extension(BigInteger n)
    {
        public BigInteger Factorial()
        {
            if (n < BigInteger.Zero)
                throw new ArgumentOutOfRangeException(nameof(n), "Non-negative integer required.");

            if (n < 2)
                return BigInteger.One;

            return MultiplyRange(1, n);
        }

        private static BigInteger MultiplyRange(BigInteger low, BigInteger high)
        {
            var diff = high - low;

            // Base cases to stop recursion
            if (diff == 0)
                return low;
            if (diff == 1)
                return low * high;

            // Binary split logic
            BigInteger mid = low + (diff >> 1);
            return MultiplyRange(low, mid) * MultiplyRange(mid + 1, high);
        }
    }
}

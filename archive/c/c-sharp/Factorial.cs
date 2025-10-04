using System;
using System.Numerics;

namespace SamplePrograms
{
    public class Factorial
    {
        public static BigInteger Fact(BigInteger n)
        {
            if (n <= 0)
                return 1;
            return n * Fact(n - 1);
        }

        public static void Main(string[] args)
        {
            try
            {
                var n = BigInteger.Parse(args[0]);
                if (n > 4550)
                {
                    Console.WriteLine(string.Format("{0}! is out of the reasonable bounds for calculation.", n));
                    Environment.Exit(1);
                }
                else if (n < 0) {
                    Console.WriteLine("Usage: please input a non-negative integer");
                    Environment.Exit(1);
                }
                var result = Fact(n);
                Console.WriteLine(result);
            }
            catch
            {
                Console.WriteLine("Usage: please input a non-negative integer");
                Environment.Exit(1);
            }
        }
    }
}

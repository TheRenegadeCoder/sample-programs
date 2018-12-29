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
                    Console.WriteLine($"{n}! is out of the reasonable bounds for calculation.");
                    Environment.Exit(1);
                }
                var result = Fact(n);
                Console.WriteLine(result);
            }
            catch
            {
                Console.WriteLine("Usage: please input a number");
                Environment.Exit(1);
            }
        }
    }
}

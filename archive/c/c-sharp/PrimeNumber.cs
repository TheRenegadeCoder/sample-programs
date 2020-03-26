using System;
using Math = System.Math;

namespace SamplePrograms
{
    public class PrimeNumber
    {
        public static bool IsPrime(ulong x)
        {
            if (x <= 1)
                return false;
            if (x != 2 && x % 2 == 0)
                return false;

            for (ulong i = 3; i <= Convert.ToUInt64(Math.Sqrt(x)); i += 2)
            {
                if (x % i == 0)
                    return false;
            }

            return true;
        }

        public static void Main(string[] args)
        {
            try
            {
                var n = ulong.Parse(args[0]);
                if (n > 18446744073709551615) // Max of a ulong in C#
                {
                    Console.WriteLine(string.Format("{0} is out of the reasonable bounds for calculation.", n));
                    Environment.Exit(1);
                }
                var result = IsPrime(n) ? "Prime" : "Composite";
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

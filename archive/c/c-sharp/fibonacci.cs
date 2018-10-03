using System;

namespace SamplePrograms
{
    public class Fibonacci
    {
        public static long CalculateFibonacci(int n)
        {
            if (n == 0) return 0;
            if (n <= 2)
            {
                return 1;
            }
            else
            {
                return CalculateFibonacci(n - 1) + CalculateFibonacci(n - 2);
            }
        }

        public static void Main(string[] args)
        {
            if(args.Length < 1)
            {
                Console.WriteLine("Usage: \"Fibonacci.exe <term no to iterate to, with 0 as the first term number");
                Environment.Exit(0);
            }

            int n = int.Parse(args[0]);
            for(int i = 0; i <= n; i++)
            {
                Console.WriteLine(i + ": " + CalculateFibonacci(i));
            }
        }
    }
}

using System;

namespace SamplePrograms
{
    public class EvenOdd
    {
        public static void Main(string[] args)
        {
            try
            {
                int n = int.Parse(args[0]);
                var result = n % 2 == 0 ? "Even" : "Odd";
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

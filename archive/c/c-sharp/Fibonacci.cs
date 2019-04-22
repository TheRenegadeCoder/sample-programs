using System;

namespace SamplePrograms
{
    public class Fibonacci
    {
        public static void Main(string[] args)
        {
            try
            {
                int n = int.Parse(args[0]);
                int first = 0;
                int second = 1;
                int result = 0;
                for(int i = 1; i <= n; i++)
                {
                    result = first + second;
                    first = second;
                    second = result;
                    Console.WriteLine(i + ": " + first);
                }
            }
            catch(Exception)
            {
                Console.WriteLine("Usage: please input the count of fibonacci numbers to output");
                Environment.Exit(0);
            }
        }
    }
}

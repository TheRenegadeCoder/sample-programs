using System;

namespace SamplePrograms
{
    public class Fibonacci
    {
        public static void Main(string[] args)
        {
            if(args.Length < 1)
            {
                Console.WriteLine("Usage: please input the count of fibonacci");
                Environment.Exit(0);
            }

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
    }
}

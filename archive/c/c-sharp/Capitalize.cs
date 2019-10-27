using System;
using System.Linq;

namespace SamplePrograms
{
    class Program
    {
        static void Main(string[] args)
        {
            if (!args.Any() || args[0] == "")
            {
                Console.WriteLine("Usage: please provide a string");
                return;
            }
            string input = args[0];
            string output = input.First().ToString().ToUpper() + input.Substring(1);
            Console.WriteLine(output);
        }
    }
}

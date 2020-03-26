using System;

namespace SamplePrograms
{
    public class ReverseString
    {
        public static string Reverse(string input)
        {
            var charArray = input.ToCharArray();
            Array.Reverse(charArray);
            return new string(charArray);
        }

        public static void Main(string[] args)
        {
            if (args.Length > 0)
            {
                System.Console.WriteLine(Reverse(args[0]));
            }
        }
    }
}

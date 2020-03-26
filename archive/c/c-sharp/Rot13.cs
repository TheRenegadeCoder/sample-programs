using System;
using System.Collections.Generic;
using System.Linq;

namespace SamplePrograms
{
    public class Rot13
    {
        static List<char> Lowers = "abcdefghijklmnopqrstuvwxyz".ToCharArray().ToList();
        static List<char> Uppers = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".ToCharArray().ToList();

        public static string Encrypt(string str) =>
            string.Join("", str.ToCharArray().Select(c => Encrypt(c)));

        public static Char Encrypt(char c)
        {
            List<char> ltrs;
            if (char.IsUpper(c))
                ltrs = Uppers;
            else if (char.IsLower(c))
                ltrs = Lowers;
            else
                return c;

            var newIndex = (ltrs.IndexOf(c) + 13) % 26;
            return ltrs[newIndex];

        }

        public static void ExitWithError()
        {
            Console.WriteLine("Usage: please provide a string to encrypt");
            Environment.Exit(1);
        }

        public static void Main(string[] args)
        {
            try
            {
                var str = args[0];
                if (String.IsNullOrEmpty(str))
                    ExitWithError();
                var result = Encrypt(str);
                Console.WriteLine(result);
            }
            catch
            {
                ExitWithError();
            }
        }
    }
}

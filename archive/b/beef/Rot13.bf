using System;

namespace Rot13;

class Program
{
    public static void Usage()
    {
        Console.WriteLine("Usage: please provide a string to encrypt");
        Environment.Exit(0);
    }

    public static void Rot13(StringView str, ref String result)
    {
        result.Clear();
        result.Reserve(str.Length);
        for (char8 ch in str)
        {
            char8 chLower = ch.ToLower;
            if (chLower >= 'a' && chLower <= 'm')
            {
                ch += 13;
            }
            else if (chLower >= 'n' && chLower <= 'z')
            {
                ch -= 13;
            }

            result += ch;
        }
    }

    public static int Main(String[] args)
    {
        if (args.Count < 1 || args[0].Length < 1)
        {
            Usage();
        }

        String result = scope String();
        Rot13(args[0], ref result);
        Console.WriteLine(result);
        return 0;
    }
}
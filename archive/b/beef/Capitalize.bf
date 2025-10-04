using System;

namespace Capitalize;

class Program
{
    public static void Usage()
    {
        Console.WriteLine("Usage: please provide a string");
        Environment.Exit(0);
    }

    public static void Capitalize(StringView str, ref String capitalized)
    {
        capitalized.Set(scope $"{str[0].ToUpper}{str[1...]}");
    }

    public static int Main(String[] args)
    {
        if (args.Count < 1 || args[0].Length == 0)
        {
            Usage();
        }

        String capitalized = scope .();
        Capitalize(args[0], ref capitalized);
        Console.WriteLine(capitalized);
        return 0;
    }
}

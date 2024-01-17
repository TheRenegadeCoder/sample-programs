using System;

namespace RemoveAllWhitespace;

class Program
{
    public static void Usage()
    {
        Console.WriteLine("Usage: please provide a string");
        Environment.Exit(0);
    }

    public static void RemoveAllWhitespace(StringView str, ref String result)
    {
        result.Clear();
        result.Join("", str.Split(' ', '\t', '\r', '\n'));
    }

    public static int Main(String[] args)
    {
        if (args.Count < 1 || args[0].Length < 1)
        {
            Usage();
        }

        String result = scope .();
        RemoveAllWhitespace(args[0], ref result);
        Console.WriteLine(result);
        return 0;
    }
}

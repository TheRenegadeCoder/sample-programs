using System;

namespace LongestWord;

class Program
{
    public static void Usage()
    {
        Console.WriteLine("Usage: please provide a string");
        Environment.Exit(0);
    }

    public static int LongestWord(StringView str)
    {
        int maxLen = 0;
        for (StringView word in str.Split(' ', '\t', '\r', '\n'))
        {
            maxLen = Math.Max<int>(maxLen, word.Length);
        }

        return maxLen;
    }

    public static int Main(String[] args)
    {
        if (args.Count < 1 || args[0].Length < 1)
        {
            Usage();
        }

        int result = LongestWord(args[0]);
        Console.WriteLine(result);
        return 0;
    }
}

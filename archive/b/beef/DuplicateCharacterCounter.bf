using System;

namespace DuplicateCharacterCounter;

class Program
{
    public static void Usage()
    {
        Console.WriteLine("Usage: please provide a string");
        Environment.Exit(0);
    }

    public static void CountDuplicateCharacters(StringView str, uint[] dupeCounter)
    {
        for (int i < 256)
        {
            dupeCounter[i] = 0;
        }

        for (char8 ch in str)
        {
            dupeCounter[(int)ch]++;
        }
    }

    public static void ShowDuplicateCharacterCounts(StringView str, uint[] dupeCounter)
    {
        bool hasDupes = false;
        for (char8 ch in str)
        {
            uint dupeCount = dupeCounter[(int)ch];
            if (dupeCount > 1)
            {
                Console.WriteLine($"{ch}: {dupeCount}");
                dupeCounter[(int)ch] = 0; // Indicate character already seen
                hasDupes = true;
            }
        }

        if (!hasDupes)
        {
            Console.WriteLine("No duplicate characters");
        }
    }

    public static int Main(String[] args)
    {
        if (args.Count < 1 || args[0].Length < 1)
        {
            Usage();
        }

        uint[] dupeCounter = scope uint[256];
        CountDuplicateCharacters(args[0], dupeCounter);
        ShowDuplicateCharacterCounts(args[0], dupeCounter);
        return 0;
    }
}

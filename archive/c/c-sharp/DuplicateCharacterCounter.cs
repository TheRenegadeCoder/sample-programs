using System;

public class DuplicateCharacterCounter
{
    public static void Main()
    {
        string input = Console.ReadLine();

        if (string.IsNullOrEmpty(input))
        {
            Console.WriteLine("Usage: please provide a string");
            return;
        }

        Dictionary<char, int> countMap = new Dictionary<char, int>();

        foreach (char c in input)
        {
            if (countMap.ContainsKey(c))
                countMap[c]++;
            else
                countMap[c] = 1;
        }

        string result = "";

        foreach (char c in input)
        {
            if (countMap[c] > 1)
            {
                result += $"{c}: {countMap[c]}\n";
                countMap[c] = 0;
            }
        }

        Console.WriteLine(string.IsNullOrEmpty(result) ? "No duplicate characters" : result.Trim());
    }
}
using System;

public class DuplicateCharacterCounter
{
    public static void Main()
    {
        Console.WriteLine(FindDuplicateCharacters("hola"));
        Console.WriteLine(FindDuplicateCharacters("goodbyeblues"));
    }

    public static string FindDuplicateCharacters(string input)
    {
        Dictionary<char, int> countMap = new Dictionary<char, int>();

        foreach (char c in input)
        {
            if (countMap.ContainsKey(c))
                countMap[c]++;
            else
                countMap[c] = 1;
        }

        foreach (KeyValuePair<char, int> entry in countMap)
        {
            Console.WriteLine($"{entry.Key}: {entry.Value}");
        }
        return "---";
    }
}
using System;

public class DuplicateCharacterCounter
{
    public static void Main()
    {
        Console.WriteLine(FindDuplicateCharacters("hola"));
        Console.WriteLine(FindDuplicateCharacters("goodbyeblues"));
        Console.WriteLine(FindDuplicateCharacters("abba"));
    }

    public static string FindDuplicateCharacters(string input)
    {
        if (string.IsNullOrEmpty(input))
        {
            return "Usage: please provide a string";
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
                result += c + ": " + countMap[c] + " \n";
                countMap[c] = 0;
            }
        }

        return string.IsNullOrEmpty(result) ? "No duplicate characters" : result.Trim();
    }
}
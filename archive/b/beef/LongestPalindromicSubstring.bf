using System;

namespace LongestPalindromicSubstring;

class Program
{
    public static void Usage()
    {
        Console.WriteLine("Usage: please provide a string that contains at least one palindrome");
        Environment.Exit(0);
    }

    // Find longest palindromic string using matching array
    // Source: https://www.geeksforgeeks.org/longest-palindromic-substring-using-dynamic-programming/
    public static void LongestPalindromicSubstring(StringView str, String longest)
    {
        // Convert string to lowercase
        String strLower = scope .(str) .. ToLower();

        // Initialize character match matrix to indicate length 1 strings match
        int n = str.Length;
        bool [,] matches = scope .[n, n];
        for (int i < n)
        {
            matches[i, i] = true;
        }

        // Find all length 2 matches
        int start = 0;
        int maxLen = 1;
        for (int i < (n - 1))
        {
            if (strLower[i] == strLower[i + 1])
            {
                matches[i, i + 1] = true;
                start = i;
                maxLen = 2;
            }
        }

        // Find all length 3 or longer matches
        for (int len in 3...n)
        {
            // Loop through each starting character
            int j = len - 1;
            for (int i in 0...(n - len))
            {
                // If match for one character in from start and end characters
                // and start and end characters match, set match for start and
                // end characters, and update max length
                if (matches[i + 1, j - 1] && strLower[i] == strLower[j])
                {
                    matches[i, j] = true;
                    if (len > maxLen)
                    {
                        start = i;
                        maxLen = len;
                    }
                }

                j++;
            }
        }

        longest.Clear();
        longest.Append(str[start..<(start + maxLen)]);
    }

    public static int Main(String[] args)
    {
        if (args.Count < 1 || args[0].Length < 1)
        {
            Usage();
        }

        String result = scope .();
        LongestPalindromicSubstring(args[0], result);
        if (result.Length < 2)
        {
            Usage();
        }

        Console.WriteLine(result);

        return 0;
    }
}

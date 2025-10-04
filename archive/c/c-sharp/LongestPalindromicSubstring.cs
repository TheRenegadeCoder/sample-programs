using System;
using System.Text.RegularExpressions;

namespace SamplePrograms
{
    public class LongestPalindromicSubstring
    {
        public static void Main(string[] args)
        {
            string input = string.Join(" ", args);
            Console.WriteLine(LongestPalindrome(input));
        }

        public static string LongestPalindrome(string input)
        {
            if (string.IsNullOrEmpty(input) || !ContainsPalindrome(input))
            {
                return "Usage: please provide a string that contains at least one palindrome";
            }

            int start = 0;
            int end = 0;

            for (int i = 0; i < input.Length; i++)
            {
                int lengthOne = ExpandAroundCenter(input, i, i);
                int lengthTwo = ExpandAroundCenter(input, i, i + 1);
                int length = Math.Max(lengthOne, lengthTwo);

                if (length > end - start)
                {
                    start = i - (length - 1) / 2;
                    end = i + length / 2;
                }
            }
            return input.Substring(start, end - start + 1);
        }

        private static int ExpandAroundCenter(string input, int left, int right)
        {
            while (left >= 0 && right < input.Length && input[left] == input[right])
            {
                left--;
                right++;
            }
            return right - left - 1;
        }

        private static bool ContainsPalindrome(string input)
        {
            string[] words = input.Split(' ');
            foreach (string word in words)
            {
                if (word.Length > 1 && word == Reverse(word))
                {
                    return true;
                }
            }
            
            string cleanedInput = input.Replace(" ", "");
            return cleanedInput.Length > 1 && cleanedInput == Reverse(cleanedInput);
        }

        private static string Reverse(string input)
        {
            char[] charArray = input.ToCharArray();
            Array.Reverse(charArray);
            return new string(charArray);
        }
    }
}
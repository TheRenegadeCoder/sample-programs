using System;
using System.Linq;

public class LongestWord
{
    public static void Main(string[] args)
    {
        // check for empty string or empty input
        if (args.Length == 0 || args[0] == "") {
            Console.WriteLine("Usage: please provide a string");
        } else {
            // stores string from args
            string sentence = args[0];

            // split string by whitespace (these four special characters), removes empty entries
            string[] words = sentence.Split(new[] {' ', '\t', '\n', '\r'}, StringSplitOptions.RemoveEmptyEntries);

            // sort array by length in descending order so longest string is first and returns is to array
            words = words.OrderByDescending(word => word.Length).ToArray();

            // log the length of longest word
            Console.WriteLine(words[0].Length);
        }
    }


}
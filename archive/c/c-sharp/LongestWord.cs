using System;

public class LongestWord
{
    public static void main(string sentence)
    {
        if (sentence.IsNullOrEmpty) {
            console.WriteLine("Usage: please provide a string");
        } else {
            // split string by whitespace (these four special characters)
            string[] words = sentence.Split(new[] {' ', '\t', '\n', '\r'});

            // sort array by length in descending order so longest string is first and returns is to array
            words = words.OrderByDescending(word => word).ToArray();
            console.WriteLine(words[0].Length);
        }
    }


}
using Systems;
using System.Linq;

class Program
{
    static void Main(string[] args)
    {
        if (args.Length > 0)
        {
           string input = args[0];
           string result = RemoveWhitespace(input);
           Console.WriteLine(result); 
        }
        else
        {
            Console.WriteLine("Error: No input provided. Please enter a string as ana argument.");
        }
    }

    static string RemoveWhitespace(string input)
    {
        return string.Concat(input.Where(c => !char.IsWhiteSpace(c)));
    }
}
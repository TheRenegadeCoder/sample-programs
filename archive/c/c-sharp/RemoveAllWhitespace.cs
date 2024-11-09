using Systems;
using System.Linq;

class Program
{
    static void Main(string[] args)
    {
        if (args.Length > 0)
        {
           string input = "Hello World";
           string result = RemoveWhitespace(input);
           Console.WriteLine(result); 
        }
        else
        {
            Console.WriteLine("Please provide a string input");
        }
    }

    static string RemoveWhitespace(string input)
    {
        return string.Concat(input.Where(char => !char.IsWhiteSpace(c)));
    }
}
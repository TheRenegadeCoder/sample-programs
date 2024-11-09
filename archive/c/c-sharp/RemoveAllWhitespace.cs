using Systems;

class Program
{
    static void Main(string[] args)
    {
        string input = "Hello World";
        string result = RemoveWhitespace(input);
        Console.WriteLine(result);
    }

    static string RemoveWhitespace(string input)
    {
        return input.Replace(" ","");
    }
}
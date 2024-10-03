using System;

class RemoveAllWhitespace
{

    public static void ExitWithError()
    {
        Console.WriteLine("Usage: please provide a string");
        Environment.Exit(1);
    }

    public static void RemoveAllWhitespace(string str) {
        Console.WriteLine(
            new string(
                args[0]
                .Where(c => !Char.IsWhiteSpace(c))
                .ToArray()
            )
        );
    }

    static void Main (string[] args)
    {
        var input = args[0]
        if (string.IsNullOrEmpty(input)) {
            ExitWithError();
        }
        RemoveAllWhitespace(input);
    }

}

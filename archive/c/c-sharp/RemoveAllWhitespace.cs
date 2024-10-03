using System;
using System.Linq;

class CSharp
{

    public static void ExitWithError()
    {
        Console.WriteLine("Usage: please provide a string");
        Environment.Exit(1);
    }

    public static void RemoveAllWhitespace(string str) {
        Console.WriteLine(
            new string(
                str
                .Where(c => !Char.IsWhiteSpace(c))
                .ToArray()
            )
        );
    }

    static void Main (string[] args)
    {
        if (!args.Any() || args[0] == "") {
            ExitWithError();
        }
        RemoveAllWhitespace(args[0]);
    }

}

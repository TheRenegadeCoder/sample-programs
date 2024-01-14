using System;

namespace EvenOdd;

class Program
{
    public static void Usage()
    {
        Console.WriteLine("Usage: please input a number");
        Environment.Exit(0);
    }

    public static Result<T> ParseInt<T>(StringView str)
    where T : IParseable<T>
    {
        StringView trimmedStr = scope String(str);
        trimmedStr.Trim();

        // For some reason T.Parse does not treat a sign without a number as an error.
        // Also, for some reason T.Parse does not treat a single quote as an invalid character.
        if (trimmedStr == "-" || trimmedStr == "+" || trimmedStr.Contains('\''))
        {
            return .Err;
        }

        return T.Parse(trimmedStr);
    }

    public static int Main(String[] args)
    {
        if (args.Count < 1)
        {
            Usage();
        }

        switch (ParseInt<int32>(args[0]))
        {
            case .Ok(let val):
                Console.WriteLine((val % 2 == 0) ? "Even" : "Odd");
            case .Err:
                Usage();
        }

        return 0;
    }
}

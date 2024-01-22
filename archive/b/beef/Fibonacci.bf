using System;

namespace Fibonacci;

class Program
{
    public static void Usage()
    {
        Console.WriteLine("Usage: please input the count of fibonacci numbers to output");
        Environment.Exit(0);
    }

    public static Result<T> ParseInt<T>(StringView str)
    where T : IParseable<T>
    {
        StringView trimmedStr = scope String(str);
        trimmedStr.Trim();

        // T.Parse ignores single quotes since they are treat as digit separators -- e.g. 1'000
        if (trimmedStr.Contains('\''))
        {
            return .Err;
        }

        return T.Parse(trimmedStr);
    }

    public static void Fibonacci(int32 n)
    {
        uint64 first = 0;
        uint64 second = 1;
        for (int i in 1...n)
        {
            second += first;
            first = second - first;
            Console.WriteLine($"{i}: {first}");
        }
    }

    public static int Main(String[] args)
    {
        if (args.Count < 1)
        {
            Usage();
        }

        int32 val = 0;
        switch (ParseInt<int32>(args[0]))
        {
            case .Ok(out val):
            case .Err:
                Usage();
        }

        Fibonacci(val);
        return 0;
    }
}

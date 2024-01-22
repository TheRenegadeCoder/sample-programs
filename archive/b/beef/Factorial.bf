using System;

namespace Factorial;

class Program
{
    public static void Usage()
    {
        Console.WriteLine("Usage: please input a non-negative integer");
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

    public static Result<uint64> Factorial(int32 n)
    {
        uint64 result = 1;
        for (int32 i in 2...n)
        {
            if (result > (uint64.MaxValue / (uint64)i))
            {
                return .Err;
            }

            result *= (uint64)i;
        }

        return .Ok(result);
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
                if (val < 0)
                {
                    Usage();
                }
            case .Err:
                Usage();
        }

        uint64 result = 0;
        switch (Factorial(val))
        {
            case .Ok(out result):
                Console.WriteLine(result);
            case .Err:
                Console.WriteLine("Overflow!");
        }

        return 0;
    }
}

using System;

namespace PrimeNumber;

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

    public static bool IsPrime<T>(T val)
        where T : IInteger, operator explicit int, operator explicit float, operator T % T, operator T + T
        where int : operator T <=> T
        where float : operator explicit T
    {
        bool isPrime = false;
        if (val == (T)2)
        {
            isPrime = true;
        }
        else if (val >= (T)3 && (val % (T)2) != (T)0)
        {
            isPrime = true;
            T q = (T)Math.Sqrt((float)val);
            for (T k = (T)3; k <= q; k += (T)2)
            {
                if ((val % k) == (T)0)
                {
                    isPrime = false;
                    break;
                }
            }
        }

        return isPrime;
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

        bool isPrime = IsPrime<int32>(val);
        Console.WriteLine(isPrime ? "prime" : "composite");
        return 0;
    }
}

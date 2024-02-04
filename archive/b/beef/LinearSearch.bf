using System;
using System.Collections;

namespace LinearSearch;

class Program
{
    public static void Usage()
    {
        Console.WriteLine(
            """
            Usage: please provide a list of integers ("1, 4, 5, 11, 12") and the integer to find ("11")
            """
        );
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

    public static Result<void> ParseIntList<T>(StringView str, List<T> arr)
    where T: IParseable<T>
    {
        arr.Clear();
        for (StringView item in str.Split(','))
        {
            switch (ParseInt<T>(item))
            {
                case .Ok(let val):
                    arr.Add(val);

                case .Err:
                    return .Err;
            }
        }

        return .Ok;
    }

    public static int LinearSearch<T>(List<T> arr, T target)
    {
        return arr.IndexOf(target);
    }

    public static int Main(String[] args)
    {
        if (args.Count < 2)
        {
            Usage();
        }

        List<int32> arr = scope .();
        if (ParseIntList<int32>(args[0], arr) case .Err)
        {
            Usage();
        }

        int32 target = ?;
        switch (ParseInt<int32>(args[1]))
        {
            case .Ok(out target):
            case .Err:
                Usage();
        }

        int index = LinearSearch<int32>(arr, target);
        Console.WriteLine(index >= 0 ? "true" : "false");

        return 0;
    }
}

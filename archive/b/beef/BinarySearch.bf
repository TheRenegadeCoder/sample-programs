using System;
using System.Collections;

namespace BinarySearch;

class Program
{
    public static void Usage()
    {
        Console.WriteLine(
            """
            Usage: please provide a list of sorted integers ("1, 4, 5, 11, 12") and the integer to find ("11")
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

    public static int BinarySearch<T>(List<T> arr, T target)
    where int : operator T <=> T
    {
        return arr.BinarySearch(target);
    }

    public static bool IsSorted<T>(List<T> arr)
    where int : operator T <=> T
    {
        for (int i = 1; i < arr.Count; i++)
        {
            if (arr[i - 1] > arr[i])
            {
                return false;
            }
        }

        return true;
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

        if (!IsSorted<int32>(arr))
        {
            Usage();
        }

        int index = BinarySearch<int32>(arr, target);
        Console.WriteLine(index >= 0 ? "true" : "false");

        return 0;
    }
}

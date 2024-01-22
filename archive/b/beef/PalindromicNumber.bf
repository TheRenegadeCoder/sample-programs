using System;

namespace PalindromicNumber;

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

    public static bool PalindromicNumber<T>(T val)
    where T: IInteger
    {
        String str = scope String();
        val.ToString(str);
        bool isPalindromic = true;
        for (int left = 0, right = str.Length - 1; left < right; left++, right--)
        {
            if (str[left] != str[right])
            {
                isPalindromic = false;
                break;
            }
        }

        return isPalindromic;
    }

    public static int Main(String[] args)
    {
        if (args.Count < 1 || args[0].Length < 1)
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

        bool result = PalindromicNumber<int32>(val);
        Console.WriteLine(result ? "true" : "false");
        return 0;
    }
}

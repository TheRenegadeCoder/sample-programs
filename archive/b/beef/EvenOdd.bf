using System;

namespace EvenOdd;

class Program
{
    public static void Usage()
    {
        Console.WriteLine("Usage: please input a number");
        Environment.Exit(0);
    }

    public static Result<int32> ParseInt(StringView str)
    {
        StringView trimmedStr = scope String(str);
        trimmedStr.Trim();

        // Do some initial validation to overcome some bugs in Beef's Parse function
        bool valid = false;
        for (int i < trimmedStr.Length)
        {
            if ((trimmedStr[i] == '-' || trimmedStr[i] == '+') && (i == 0))
            {
                continue;
            }

            if (trimmedStr[i] >= '0' && trimmedStr[i] <= '9')
            {
                valid = true;
            }
            else
            {
                valid = false;
                break;
            }
        }

        if (!valid)
        {
            return .Err;
        }

        switch (Int32.Parse(trimmedStr))
        {
            case .Ok(let val):
                return .Ok(val);
            case .Err:
                return .Err;
        }
    }

    public static String EvenOdd(int32 val)
    {
        if ((val % 2) == 0)
        {
            return "Even";
        }
        else
        {
            return "Odd";
        }
    }

    public static int Main(String[] args)
    {
        if (args.Count < 1)
        {
            Usage();
        }

        switch (ParseInt(args[0]))
        {
            case .Ok(let val):
                Console.WriteLine(EvenOdd(val));
            case .Err:
                Usage();
        }

        return 0;
    }
}

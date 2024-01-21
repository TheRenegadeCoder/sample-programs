using System;

namespace RomanNumeral;

class Program
{
    public static void Usage()
    {
        Console.WriteLine("Usage: please provide a string of roman numerals");
        Environment.Exit(0);
    }

    public static void Error()
    {
        Console.WriteLine("Error: invalid string of roman numerals");
        Environment.Exit(0);
    }

    public static Result<int> RomanNumeral(StringView str)
    {
        int total = 0;
        int prevDigit = 0;
        for (char8 ch in str)
        {
            int digit = 0;
            switch (ch)
            {
                case 'I': digit = 1;
                case 'V': digit = 5;
                case 'X': digit = 10;
                case 'L': digit = 50;
                case 'C': digit = 100;
                case 'D': digit = 500;
                case 'M': digit = 1000;
                default: return .Err;
            }

            total += digit;

            // If there is a previous digit and digit is greater than previous digit,
            // subtract two times previous digit from total to compensate for addition of
            // previous digit
            if (prevDigit > 0 && digit > prevDigit)
            {
                total -= 2 * prevDigit;
                prevDigit = 0;
            }

            prevDigit = digit;
        }

        return .Ok(total);
    }

    public static int Main(String[] args)
    {
        if (args.Count < 1)
        {
            Usage();
        }

        switch (RomanNumeral(args[0]))
        {
            case .Ok(let result):
                Console.WriteLine(result);
            case .Err:
                Error();
        }

        return 0;
    }
}
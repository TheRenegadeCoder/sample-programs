using System;

namespace ReverseString;

class Program
{
    public static void ReverseString(StringView str, ref String reversed)
    {
        reversed.Clear();
        reversed.Reserve(str.Length);
        for (char8 ch in str.Reversed)
        {
            reversed += ch;
        }
    }

    public static int Main(String[] args)
    {
        if (args.Count > 0)
        {
            String reversed = scope String();
            ReverseString(args[0], ref reversed);
            Console.WriteLine(reversed);
        }

        return 0;
    }
}


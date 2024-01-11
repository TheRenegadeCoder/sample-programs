using System;

namespace ReverseString;

class Program
{
    public static void ReverseString(String str, ref String reversed)
    {
        reversed.Clear();
        for (int i = String.StrLen(str) - 1; i >= 0; i--)
        {
            reversed += str.Substring(i, 1);
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


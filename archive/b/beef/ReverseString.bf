using System;

namespace ReverseString;

class Program
{
    public static void ReverseString(StringView str, ref String reversed)
    {
        reversed.Clear();
        for (int i = str.Length - 1; i >= 0; i--)
        {
            reversed += str[i];
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


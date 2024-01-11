using System;

namespace ReverseString;

class Program
{
    public static String ReverseString(String str)
    {
        String reversed = new String();
        for (int i = String.StrLen(str) - 1; i >= 0; i--)
        {
            reversed += str.Substring(i, 1);
        }

        return reversed;
    }

    public static int Main(String[] args)
    {
        String reversed = ReverseString(args[0]);
        Console.WriteLine(reversed);
        delete reversed;
        return 0;
    }
}


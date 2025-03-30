using System;

namespace Base64EncodeDecode;

class Program
{
    static String base64Chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

    public static void Usage()
    {
        Console.WriteLine("Usage: please provide a mode and a string to encode/decode");
        Environment.Exit(0);
    }

    public static void Base64Encode(StringView str, ref String result)
    {
        int len = str.Length;
        result.Clear();
        int numChunks = (len + 2) / 3;
        result.Reserve(4 * numChunks);
        for (int n = 0; n < len; n += 3)
        {
            int n1 = (int)str[n];
            int n2 = (n + 1 < len) ? (int)str[n + 1] : 0;
            int n3 = (n + 2 < len) ? (int)str[n + 2] : 0;
            int u = (n1 << 16) | (n2 << 8) | n3;
            result += base64Chars[u >> 18];
            result += base64Chars[(u >> 12) & 0x3f];
            result += (n + 1 < len) ? base64Chars[(u >> 6) & 0x3f] : '=';
            result += (n + 2 < len) ? base64Chars[u & 0x3f] : '=';
        }
    }

    public static bool Base64Decode(StringView str, ref String result)
    {
        int len = str.Length;
        int padCount = countTrailingPads(str);
        result.Clear();
        bool valid = len % 4 == 0 && padCount <= 2;
        if (valid)
        {
            int numChunks = len / 4;
            result.Reserve(3 * numChunks - padCount);
            len -= padCount;
            for (int n = 0; n < len && valid; n += 4)
            {
                int n1 = base64Index(str[n]);
                int n2 = base64Index(str[n + 1]);
                int n3 = (n + 2 < len) ? base64Index(str[n + 2]) : 0;
                int n4 = (n + 3 < len) ? base64Index(str[n + 3]) : 0;
                int u = (n1 << 18) | (n2 << 12) | (n3 << 6) | n4;
                valid = (n1 >= 0) && (n2 >= 0) && (n3 >= 0) && (n4 >= 0);
                if (valid)
                {
                    result += (char8)(u >> 16);
                    result.Append(
                        (n + 2 < len) ?
                        scope String((char8)((u >> 8) & 0xff), 1) :
                        ""
                    );
                    result.Append(
                        (n + 3 < len) ?
                        scope String((char8)(u & 0xff), 1) :
                        ""
                    );
                }
            }
        }

        return valid;
    }

    static int countTrailingPads(StringView str)
    {
        int padCount = 0;
        int index = str.Length - 1;
        while (index >= 0 && str[index] == '=')
        {
            padCount += 1;
            index -= 1;
        }

        return padCount;
    }

    static int base64Index(char8 ch)
    {
        int n = -1;
        if (ch >= 'A' && ch <= 'Z')
        {
            n = ch - 'A';
        }
        else if (ch >= 'a' && ch <= 'z')
        {
            n = ch - 'a' + 26;
        }
        else if (ch >= '0' && ch <= '9')
        {
            n = ch - '0' + 52;
        }
        else if (ch == '+')
        {
            n = 62;
        }
        else if (ch == '/')
        {
            n = 63;
        }

        return n;
    }

    public static int Main(String[] args)
    {
        if (args.Count < 2 || args[1].Length < 1)
        {
            Usage();
        }

        String result = scope String();
        switch (args[0])
        {
        case "encode":
            Base64Encode(args[1], ref result);
        case "decode":
            if (!Base64Decode(args[1], ref result))
            {
                Usage();
            }
        default:
            Usage();
        }

        Console.WriteLine(result);
        return 0;
    }
}

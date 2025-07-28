using System.Text;

public class Base64EncodeDecode
{
    public static void Usage()
    {
        Console.WriteLine("Usage: please provide a mode and a string to encode/decode");
        Environment.Exit(1);
    }

    public static bool IsBase64Char(char c)
    {
        return (c >= 'A' && c <= 'Z') ||
               (c >= 'a' && c <= 'z') ||
               (c >= '0' && c <= '9') ||
               c == '+' || c == '/' || c == '=';
    }

    private static bool IsValidBase64(string input)
    {
        if (string.IsNullOrWhiteSpace(input) || input.Length % 4 != 0)
            return false;

        foreach (char c in input)
        {
            if (!"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=".Contains(c))
                return false;
        }

        int padCount = input.EndsWith("==") ? 2 :
                       input.EndsWith('=') ? 1 : 0;

        int firstPadIndex = input.IndexOf('=');
        return firstPadIndex == -1 || firstPadIndex >= input.Length - padCount;
    }

    public static int Main(string[] args)
    {
        if (args.Length != 2)
        {
            Usage();
            return 1;
        }

        string mode = args[0].ToLowerInvariant();
        string value = args[1];

        try
        {
            string result = mode switch
            {
                "encode" => Convert.ToBase64String(Encoding.UTF8.GetBytes(value)),
                "decode" => IsValidBase64(value)
                            ? Encoding.UTF8.GetString(Convert.FromBase64String(value))
                            : throw new ArgumentException("Input is not valid Base64."),
                _ => throw new ArgumentException("Unknown mode. Use 'encode' or 'decode'.")
            };

            Console.WriteLine(result);
            return 0;
        }
        catch
        {
            Usage();
            return 1;
        }
    }
}
using System.Text;

if (args is not [string mode, string value] || string.IsNullOrEmpty(value))
{
    Usage();
    return 1;
}

if (mode == "encode")
{
    Console.WriteLine(Convert.ToBase64String(Encoding.ASCII.GetBytes(value)));
    return 0;
}

if (mode == "decode")
{
    byte[] buffer = new byte[value.Length];

    if (!Convert.TryFromBase64String(value, buffer, out int written))
    {
        Usage();
        return 1;
    }

    Console.WriteLine(Encoding.ASCII.GetString(buffer, 0, written));
    return 0;
}

Usage();
return 1;

static void Usage()
{
    Console.WriteLine("Usage: please provide a mode and a string to encode/decode");
}

using System.Text;

return args switch
{
    ["encode", var value] when !string.IsNullOrWhiteSpace(value)
        => Encode(value),

    ["decode", var value] when !string.IsNullOrWhiteSpace(value)
        => Decode(value),

    _ => Usage()
};

static int Encode(string value)
{
    Console.WriteLine(Convert.ToBase64String(Encoding.ASCII.GetBytes(value)));
    return 0;
}

static int Decode(string value)
{
    byte[] buffer = new byte[value.Length];
    if (!Convert.TryFromBase64String(value, buffer, out int written))
        return Usage();

    Console.WriteLine(Encoding.ASCII.GetString(buffer, 0, written));
    return 0;
}

static int Usage()
{
    Console.Error.WriteLine("Usage: please provide a mode and a string to encode/decode");
    return 1;
}
using System;
using System.IO;

namespace FileInputOutput;

class Program
{
    public static Result<void> WriteFile(StringView filename)
    {
        StreamWriter fs = scope .();
        Try!(fs.Create(filename));
        fs.WriteLine("Hello from Beef!");
        fs.WriteLine("This is line 1");
        fs.WriteLine("This is line 2");
        fs.WriteLine("Goodbye!");
        return .Ok;
    }

    public static Result<void> ReadFile(StringView filename)
    {
        StreamReader fs = scope .();
        Try!(fs.Open(filename));
        String line = scope .();
        while (fs.ReadLine(line) case .Ok)
        {
            Console.WriteLine(line);
            line.Clear();
        }

        return .Ok;
    }

    public static int Main(String[] args)
    {
        String filename = "output.txt";

        if (WriteFile(filename) case .Err)
        {
            Console.WriteLine($"Could not write {filename}");
        }

        if (ReadFile(filename) case .Err)
        {
            Console.WriteLine($"Could not read {filename}");
        }

        return 0;
    }
}

using System;
using System.Linq;
using System.Collections.Generic;

public class QuickSort
{
    public static List<int> Sort(List<int> xs)
    {
        if (!xs.Any())
            return xs;

        var index = xs.Count() / 2;
        var x = xs[index];
        xs.RemoveAt(index);
        var left = Sort(xs.Where(v => v <= x).ToList());
        var right = Sort(xs.Where(v => v > x).ToList());
        return left.Append(x).Concat(right).ToList();
    }

    public static void ErrorAndExit()
    {
        Console.WriteLine("Usage: please provide a list of at least two integers to sort in the format \"1, 2, 3, 4, 5\"");
        Environment.Exit(1);
    }

    public static void Main(string[] args)
    {
        if (args.Length != 1)
            ErrorAndExit();
        try
        {
            var xs = args[0].Split(',').Select(i => Int32.Parse(i.Trim())).ToList();
            if (xs.Count() <= 1)
                ErrorAndExit();
            var sortedXs = Sort(xs);
            Console.WriteLine(string.Join(", ", sortedXs));
        }
        catch
        {
            ErrorAndExit();
        }
    }
}

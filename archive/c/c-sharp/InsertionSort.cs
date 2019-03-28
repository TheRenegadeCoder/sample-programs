using System;
using System.Linq;
using System.Collections.Generic;

public class InsertionSort
{
    public static List<int> Insertion(List<int> xs)
    {
        var sorted = new List<int>();
        foreach (var x in xs)
            sorted = Insert(sorted, x);
        return sorted;
    }

    public static List<int> Insert(List<int> xs, int x)
    {
        var index = 0;
        while (index < xs.Count() && x > xs[index])
            index++;
        xs.Insert(index > 0 ? index : 0, x);
        return xs;
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
            var sortedXs = Insertion(xs);
            Console.WriteLine(string.Join(", ", sortedXs));
        }
        catch
        {
            ErrorAndExit();
        }
    }
}
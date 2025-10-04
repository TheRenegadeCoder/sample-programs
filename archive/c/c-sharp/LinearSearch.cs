using System;
using System.Linq;
using System.Collections.Generic;

public class LinearSearch
{
    public static bool Search(List<int> list, int toFind)
    {
        foreach (int value in list) 
        {
            if (value == toFind) 
            {
                return true;
            }
        }
        return false;
    }

    public static void ErrorAndExit()
    {
        Console.WriteLine("Usage: please provide a list of integers (\"1, 4, 5, 11, 12\") and the integer to find (\"11\")");
        Environment.Exit(1);
    }

    public static void Main(string[] args)
    {
        try
        {
            var list = args[0].Split(',').Select(i => Int32.Parse(i.Trim())).ToList();
            var toFind = Int32.Parse(args[1]);
            Console.WriteLine(Search(list, toFind));
        }
        catch
        {
            ErrorAndExit();
        }
    }
}

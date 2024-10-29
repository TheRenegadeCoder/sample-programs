using System;
using System.Linq;
using System.Collections.Generic;

public class BinarySearch
{
    public static bool Search(List<int> list, int toFind)
    {   
        int lowerBound = 0;
        int upperBound = list.Count - 1;
        while (lowerBound <= upperBound) 
        {
            int midpoint = (lowerBound + upperBound) / 2;
            if (list[midpoint] == toFind)
            {
                return true;
            }
            else if (list[midpoint] < toFind)
            {
                lowerBound = midpoint + 1;
            }
            else
            {
                upperBound = midpoint - 1;
            }
        }
        return false;
    }

    public static void ErrorAndExit()
    {
        Console.WriteLine("Usage: please provide a list of sorted integers (\"1, 4, 5, 11, 12\") and the integer to find (\"11\")");
        Environment.Exit(1);
    }

    public static void Main(string[] args)
    {
        try
        {
            var list = args[0].Split(',').Select(i => Int32.Parse(i.Trim())).ToList();
            var toFind = Int32.Parse(args[1]);

            for (int i = 0; i < list.Count - 1; i++)
            {
                if (list[i] > list[i + 1])
                {
                    ErrorAndExit();
                }
            }
            
            Console.WriteLine(Search(list, toFind));
        }
        catch
        {
            ErrorAndExit();
        }
    }
}

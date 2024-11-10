using System;
using System.Linq;

class Program
{
    // main method - entry point of the program
    static void Main(string[] args)
    {
        // check if there is atleast one arugment and it is not empty or whitespace
        if (args.Length > 0 && !string.IsNullOrWhiteSpace(args[0]))
        {
            // if a valid input is provided, remove whitespace and display the result
           Console.WriteLine(RemoveWhitespace(args[0]));
        }
        else
        {
            // display a usage message if no valid input is provided.
            Console.WriteLine("Usage: please provide a string");
        }
    }
    
    // method to remove all whitespace characters from a string
    static string RemoveWhitespace(string input)
    {
        // using LINQ to filter out whitespace characters and link the result.
        return string.Concat(input.Where(c => !char.IsWhiteSpace(c)));
    }
}
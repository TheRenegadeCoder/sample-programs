using System;
using System.Collections.Generic;
using System.Linq;

public static class Program
{
    private static void ShowUsage()
    {
        Console.Error.WriteLine("Usage: Please provide a list of integers in the format: \"1, 2, 3, 4, 5\"");
        Environment.Exit(1);
    }

    private static List<int> ParseIntegerList(string input)
    {
        if (string.IsNullOrWhiteSpace(input))
            ShowUsage();

        var list = input
            .Split(',', StringSplitOptions.RemoveEmptyEntries | StringSplitOptions.TrimEntries)
            .Select(s =>
            {
                if (!int.TryParse(s, out var val))
                    ShowUsage();
                return val;
            })
            .ToList();

        if (list.Count == 0)
            ShowUsage();

        return list;
    }

    private static int MaximumSubarraySum(IReadOnlyList<int> numbers)
    {
        if (numbers.Count == 0)
            return 0;

        int currentSum = numbers[0];
        int maxSum = numbers[0];

        for (int i = 1; i < numbers.Count; i++)
        {
            int number = numbers[i];
            currentSum = Math.Max(number, currentSum + number);
            maxSum = Math.Max(maxSum, currentSum);
        }

        return maxSum;
    }

    public static int Main(string[] args)
    {
        if (args.Length != 1)
            ShowUsage();

        var inputList = ParseIntegerList(args[0]);

        Console.WriteLine(MaximumSubarraySum(inputList));

        return 0;
    }
}

using System;
using System.Collections.Generic;
using System.Linq;

public static class Program
{
    private static void ShowUsage()
    {
        Console.Error.WriteLine("Usage: please provide a list of integers (e.g. \"8, 3, 1, 2\")");
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
                if (!int.TryParse(s, out var val) || val < 0)
                    ShowUsage();
                return val;
            })
            .ToList();

        if (list.Count == 0)
            ShowUsage();

        return list;
    }

    private static int MaximumRotationSum(IList<int> numbers)
    {
        int n = numbers.Count;
        if (n == 0)
            ShowUsage();

        int totalSum = 0;
        int currentWeightedSum = 0;

        for (int i = 0; i < n; i++)
        {
            totalSum += numbers[i];
            currentWeightedSum += numbers[i] * i;
        }

        int maxWeightedSum = currentWeightedSum;

        for (int i = 1; i < n; i++)
        {
            currentWeightedSum = currentWeightedSum + totalSum - n * numbers[n - i];
            if (currentWeightedSum > maxWeightedSum)
                maxWeightedSum = currentWeightedSum;
        }

        return maxWeightedSum;
    }

    public static int Main(string[] args)
    {
        if (args.Length != 1)
            ShowUsage();

        var inputList = ParseIntegerList(args[0]);

        Console.WriteLine(MaximumRotationSum(inputList));

        return 0;
    }
}

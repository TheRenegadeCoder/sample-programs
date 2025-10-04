using System;
using System.Collections.Generic;
using System.Linq;

public static class Program
{
    private static void ShowUsage()
    {
        Console.Error.WriteLine("Usage: please enter the dimension of the matrix and the serialized matrix");
        Environment.Exit(1);
    }

    private static List<int> ParseIntegerList(string input)
    {
        if (string.IsNullOrWhiteSpace(input))
            ShowUsage();

        var tokens = input
            .Split(',', StringSplitOptions.RemoveEmptyEntries | StringSplitOptions.TrimEntries);

        var numbers = new List<int>();
        foreach (var token in tokens)
        {
            if (!int.TryParse(token, out int value))
                ShowUsage();

            numbers.Add(value);
        }

        return numbers;
    }

    static List<int> TransposeMatrix(int cols, int rows, List<int> input)
    {
        var result = new List<int>(new int[rows * cols]);

        for (int i = 0; i < rows; ++i)
        {
            for (int j = 0; j < cols; ++j)
            {
                int index = j * rows + i;
                result[index] = input[i * cols + j];
            }
        }

        return result;
    }

    static int Main(string[] args)
    {
        if (args.Length != 3)
            ShowUsage();

        if (!int.TryParse(args[0], out var cols))
            ShowUsage();

        if (!int.TryParse(args[1], out var rows))
            ShowUsage();

        var numbers = ParseIntegerList(args[2]);
        if (numbers.Count != cols * rows)
            ShowUsage();

        var transposed = TransposeMatrix(cols, rows, numbers);
        Console.WriteLine(string.Join(", ", transposed));
        return 0;
    }
}

using System;
using System.Collections;

namespace QuickSort;

class Program
{
    public static void Usage()
    {
        Console.WriteLine(
            """
            Usage: please provide a list of at least two integers to sort in the format "1, 2, 3, 4, 5"
            """
        );
        Environment.Exit(0);
    }

    public static Result<T> ParseInt<T>(StringView str)
    where T : IParseable<T>
    {
        StringView trimmedStr = scope String(str);
        trimmedStr.Trim();

        // T.Parse ignores single quotes since they are treat as digit separators -- e.g. 1'000
        if (trimmedStr.Contains('\''))
        {
            return .Err;
        }

        return T.Parse(trimmedStr);
    }

    public static Result<void> ParseIntList<T>(StringView str, List<T> arr)
    where T: IParseable<T>
    {
        arr.Clear();
        for (StringView item in str.Split(','))
        {
            switch (ParseInt<T>(item))
            {
                case .Ok(let val):
                    arr.Add(val);

                case .Err:
                    return .Err;
            }
        }

        return .Ok;
    }

    // Reference: https://en.wikipedia.org/wiki/Quicksort#Lomuto_partition_scheme
    public static void QuickSort<T>(List<T> arr)
    where int : operator T <=> T
    {
        QuickSortRec<T>(arr, 0, arr.Count - 1);
    }

    public static void QuickSortRec<T>(List<T> arr, int lo, int hi)
    where int : operator T <=> T
    {
        // Exit if no enough elements
        if (lo >= hi || lo < 0)
        {
            return;
        }

        // Get partition
        int p = Partition<T>(arr, lo, hi);

        // Sort left side of partition
        QuickSortRec<T>(arr, lo, p - 1);

        // Sort right side of partition
        QuickSortRec<T>(arr, p + 1, hi);
    }

    public static int Partition<T>(List<T> arr, int lo, int hi)
    where int : operator T <=> T
    {
        // Set pivot to last element
        T pivot = arr[hi];

        // Set temporary pivot index
        int i = lo - 1;

        for (int j in lo..<hi)
        {
            // If current element less than pivot, advance pivot index
            // and swap elements
            if (arr[j] <= pivot)
            {
                i++;
                Swap!(arr[i], arr[j]);
            }
        }

        // Move pivot element to correct position
        i++;
        if (i != hi)
        {
            Swap!(arr[i], arr[hi]);
        }

        return i;
    }

    public static void ShowList<T>(List<T> arr)
    {
        String line = scope .();
        for (T val in arr)
        {
            if (!line.IsEmpty)
            {
                line += ", ";
            }

            line.AppendF("{}", val);
        }

        Console.WriteLine(line);
    }

    public static int Main(String[] args)
    {
        if (args.Count < 1)
        {
            Usage();
        }

        List<int32> arr = scope .();
        switch (ParseIntList<int32>(args[0], arr))
        {
            case .Ok:
                if (arr.Count < 2)
                {
                    Usage();
                }
            case .Err:
                Usage();
        }

        QuickSort<int32>(arr);
        ShowList<int32>(arr);
        return 0;
    }
}

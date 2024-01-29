using System;
using System.Collections;

namespace MergeSort;

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

    // Source: https://en.wikipedia.org/wiki/Merge_sort#Top-down_implementation
    public static void MergeSort<T>(List<T> arrA)
    where int : operator T <=> T
    {
        List<T> arrB = scope .(arrA);
        MergeSortRec(arrA, 0, arrA.Count, arrB);
    }

    public static void MergeSortRec<T>(List<T> arrB, int iBegin, int iEnd, List<T> arrA)
    where int : operator T <=> T
    {
        // Exit if not enough elements to sort
        if ((iEnd - iBegin) <= 1)
        {
            return;
        }

        // Split sort into two halves
        int iMid = (iBegin + iEnd) / 2;

        // Recursively sort left half from A into B
        MergeSortRec<T>(arrA, iBegin, iMid, arrB);

        // Recursively sort right half from A into B
        MergeSortRec<T>(arrA, iMid, iEnd, arrB);

        // Merge left and right halves from B into A
        Merge<T>(arrB, iBegin, iMid, iEnd, arrA);
    }

    public static void Merge<T>(
        List<T> arrB, int iBegin, int iMid, int iEnd, List<T> arrA
    )
    where int : operator T <=> T
    {
        int i = iBegin;
        int j = iMid;
        for (int k in iBegin..< iEnd)
        {
            // If there are elements from the left side and there are still
            // elements on the right sight side or the left side element
            // is less or equal the right side element, merge in left element
            if (i < iMid && (j >= iEnd || arrA[i] <= arrA[j]))
            {
                arrB[k] = arrA[i];
                i++;
            }
            // Else, merge in right element
            else
            {
                arrB[k] = arrA[j];
                j++;
            }
        }
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

        MergeSort<int32>(arr);
        ShowList<int32>(arr);
        return 0;
    }
}

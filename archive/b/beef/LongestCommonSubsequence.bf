using System;
using System.Collections;

namespace LongestCommonSubsequence;

class Program
{
    public static void Usage()
    {
        Console.WriteLine(
            """
            Usage: please provide two lists in the format "1, 2, 3, 4, 5"
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

    // Source: https://en.wikipedia.org/wiki/Longest_common_subsequence#Computing_the_length_of_the_LCS
    //
    // However, instead of storing lengths, an index to the subsequence is stored
    public static void LongestCommonSubsequence<T>(List<T> arr1, List<T> arr2, List<T> result)
    where int : operator T <=> T
    {
        int m = arr1.Count;
        int n = arr2.Count;

        // Initialize all subsequences to the empty sequence
        int[,] c = new .[m + 1, n + 1];
        List<List<T>> subsequences = new .();
        subsequences.Add(new List<T>());

        // Find the longest common subsequence using prior subsequences
        for (int i in 1...m)
        {
            for (int j in 1...n)
            {
                // If common element found, create new subsequence based on prior
                // subsequence with the common element appended
                if (arr1[i - 1] == arr2[j - 1])
                {
                    c[i, j] = subsequences.Count;
                    List<T> newSubsequence = new .() ..
                        AddRange(subsequences[c[i - 1, j - 1]]) ..
                        Add(arr1[i - 1]);
                    subsequences.Add(newSubsequence);
                }
                // Else, reuse the longer of the two prior subsequences
                else
                {
                    int index1 = c[i, j - 1];
                    int index2 = c[i - 1, j];
                    c[i, j] = (subsequences[index1].Count > subsequences[index2].Count) ?
                        index1 : index2;
                }
            }
        }

        // Store result
        result.Clear();
        result.AddRange(subsequences[c[m, n]]);

        // Deallocate subsequences
        for (List<T> subsequence in subsequences)
        {
            delete subsequence;
        }
        delete subsequences;
        delete c;
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
        if (args.Count < 2)
        {
            Usage();
        }

        List<int32> arr1 = scope .();
        if (ParseIntList<int32>(args[0], arr1) case .Err)
        {
                Usage();
        }

        List<int32> arr2 = scope .();
        if (ParseIntList<int32>(args[1], arr2) case .Err)
        {
            Usage();
        }

        List<int32> result = scope .();
        LongestCommonSubsequence<int32>(arr1, arr2, result);
        ShowList<int32>(result);
        return 0;
    }
}

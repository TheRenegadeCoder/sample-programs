using System;
using System.Collections;

namespace MaximumArrayRotation;

class Program
{
    public static void Usage()
    {
        Console.WriteLine(
            """
            Usage: please provide a list of integers (e.g. "8, 3, 1, 2")
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

    // Find maximum array rotation, max{W(k), k=0..N-1}, where:
    //
    //     W(k) = sum{i*a[i+k mod N], i=0..N-1}
    //
    // The value of W(k) can be calculated from W(k-1) as follows:
    //
    //     W(k) = W(k-1) - S + N*a[k-1]
    //
    // where:
    //
    //     S = sum{a[i], i=0..N-1} = sum{a[i+x mod N], i=0..N-1}
    //
    // where: x is any arbitary value
    //
    // Proof:
    //
    // - Set up initial assumption for W(k):
    //
    //     W(k-1) - S + N*a[k-1] = sum{i*a[i+k-1 mod N], i=0..N-1} - sum{a[i+k-1 mod N], i=0..N-1} + N*a[k-1]
    //
    // - Combine the two sums:
    //
    //     = sum{(i-1)*a[i+k-1 mod N], i=0..N-1} + N*a[k-1]
    //
    // - Pull out the i=0 term:
    //     = -a[k-1] + sum{(i-1)*a[i+k-1 mod N], i=1..N-1} + N*a[k-1]
    //
    // - Combine the a[k-1] terms:
    //
    //     = sum{(i-1)*a[i+k-1 mod N], i=1..N-1} + (N-1)*a[k-1]
    //
    // - Change indexing from i=1..N-1 to 0..N-2:
    //
    //     = sum{i*a[i+k mod N], i=0..N-2} + (N-1)*a[k-1]
    //
    // - Bring the i=N-1 term back into the sum since N-1+k mod N equals k-1:
    //
    //     = sum{i*a[i+k mod N], i=0..N-1}
    //
    // - The above equals W(k)
    public static T MaximumArrayRotation<T>(List<T> arr)
    where T : operator explicit int, operator T * T, operator T + T, operator T - T
    where int : operator T <=> T
    {
        T s = default(T);
        T w = default(T);
        int n = arr.Count;
        for (int i < n)
        {
            s += arr[i];
            w += (T)i * arr[i];
        }

        T wmax = w;
        for (T val in arr[...^2])
        {
            w += (T)n * val - s;
            wmax = Math.Max<T>(w, wmax);
        }

        return wmax;
    }

    public static int Main(String[] args)
    {
        if (args.Count < 1)
        {
            Usage();
        }

        List<int32> arr = scope .();
        if (ParseIntList<int32>(args[0], arr) case .Err)
        {
            Usage();
        }

        int32 result = MaximumArrayRotation<int32>(arr);
        Console.WriteLine(result);

        return 0;
    }
}

using System;
using System.Collections.Generic;

if (args is not [var input, var targetRaw] || !int.TryParse(targetRaw, out int target))
    return ExitWithUsage();

List<int> numbers = [];
int start = 0;

while (start < input.Length)
{
    int comma = input.indexOf(',', start);
    int end = (comma == -1) ? input.Length : comma;

    if (!int.TryParse(input[start..end].Trim(), out int val))
        return ExitWithUsage();

    if (numbers is [.., var last] && val < last)
        return ExitWithUsage();

    numbers.Add(val);
    start = end + 1;
}

if (numbers.Count == 0)
    return ExitWithUsage();

Console.WriteLine(BinarySearch(numbers, target).ToString().ToLower());
return 0;

static bool BinarySearch(List<int> list, int target)
{
    int lo = 0;
    int hi = list.Count - 1;

    while (lo <= hi)
    {
        int mid = lo + ((hi - lo) / 2);
        int midValue = list[mid];

        if (midValue == target)
            return true;
        if (midValue < target)
            lo = mid + 1;
        else
            hi = mid - 1;
    }
    return false;
}

static int ExitWithUsage()
{
    Console.WriteLine(
        "Usage: please provide a list of sorted integers (\"1, 4, 5, 11, 12\") and the integer to find (\"11\")"
    );
    return 1;
}

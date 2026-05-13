using System.Runtime.InteropServices;

if (
    args is not [var profitsRaw, var deadlinesRaw]
    || !TryParseJobs(profitsRaw.AsSpan(), deadlinesRaw.AsSpan(), out var jobs, out int maxDeadline)
)
{
    return Usage();
}

Console.WriteLine(MaxProfit(jobs, maxDeadline));
return 0;

static bool TryParseJobs(
    ReadOnlySpan<char> profits,
    ReadOnlySpan<char> deadlines,
    out List<Job> jobs,
    out int maxDeadline
)
{
    jobs = new(Math.Max(profits.Count(',') + 1, 0));
    maxDeadline = 0;

    while (!profits.IsEmpty && !deadlines.IsEmpty)
    {
        if (!TryNext(ref profits, out int profit) || !TryNext(ref deadlines, out int deadline))
            return false;

        jobs.Add(new(profit, deadline));
        maxDeadline = Math.Max(maxDeadline, deadline);
    }

    return profits.IsEmpty && deadlines.IsEmpty && jobs.Count > 0;

    static bool TryNext(ref ReadOnlySpan<char> span, out int n)
    {
        int comma = span.IndexOf(',');
        var token = comma >= 0 ? span[..comma] : span;
        span = comma >= 0 ? span[(comma + 1)..] : [];
        return int.TryParse(token, out n);
    }
}

static long MaxProfit(List<Job> jobs, int maxDeadline)
{
    jobs.Sort((a, b) => b.Profit.CompareTo(a.Profit));

    int n = Math.Min(jobs.Count, maxDeadline);

    Span<int> parent = n <= 1024 ? stackalloc int[n + 1] : new int[n + 1];

    for (int i = 0; i <= n; i++)
        parent[i] = i;

    long total = 0;

    foreach (ref readonly var j in CollectionsMarshal.AsSpan(jobs))
    {
        int slot = Find(parent, Math.Min(j.Deadline, n));

        if (slot == 0)
            continue;

        total += j.Profit;
        parent[slot] = Find(parent, slot - 1);
    }

    return total;
}

static int Find(Span<int> parent, int i)
{
    while (i != parent[i])
    {
        parent[i] = parent[parent[i]];
        i = parent[i];
    }
    return i;
}

static int Usage()
{
    Console.Error.WriteLine("Usage: please provide a list of profits and a list of deadlines");
    return 1;
}

readonly record struct Job(int Profit, int Deadline);

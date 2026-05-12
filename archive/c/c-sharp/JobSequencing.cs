using System.Runtime.InteropServices;

if (
    args is not [var profitsRaw, var deadlinesRaw]
    || !TryParseJobs(profitsRaw, deadlinesRaw, out var jobs, out int maxDeadline)
)
    return ExitWithUsage();

long result = MaxJobProfit(jobs, maxDeadline);

Console.WriteLine(result);
return 0;

static bool TryParseJobs(string pRaw, string dRaw, out List<Job> jobs, out int maxDeadline)
{
    jobs = [];
    maxDeadline = 0;

    ReadOnlySpan<char> pSpan = pRaw;
    ReadOnlySpan<char> dSpan = dRaw;

    int expected = pSpan.Count(',') + 1;
    if (expected != dSpan.Count(',') + 1)
        return false;

    jobs = new List<Job>(expected);

    while (!pSpan.IsEmpty && !dSpan.IsEmpty)
    {
        if (!TryParseNext(ref pSpan, out int p) || !TryParseNext(ref dSpan, out int d))
            return false;

        jobs.Add(new Job(p, d));

        if (d > maxDeadline)
            maxDeadline = d;
    }

    // ensure both consumed equally
    if (!pSpan.IsEmpty || !dSpan.IsEmpty)
        return false;

    return jobs.Count > 0;

    static bool TryParseNext(ref ReadOnlySpan<char> span, out int value)
    {
        int comma = span.IndexOf(',');

        ReadOnlySpan<char> token;
        if (comma >= 0)
        {
            token = span[..comma];
            span = span[(comma + 1)..];
        }
        else
        {
            token = span;
            span = default;
        }

        return int.TryParse(token, out value);
    }
}

static long MaxJobProfit(List<Job> jobs, int maxDeadline)
{
    jobs.Sort(static (a, b) => b.Profit.CompareTo(a.Profit));

    int size = Math.Min(maxDeadline, jobs.Count);

    Span<int> parent = size <= 1024
        ? stackalloc int[size + 1]
        : new int[size + 1];

    for (int i = 0; i <= size; i++)
        parent[i] = i;

    long totalProfit = 0;

    foreach (ref readonly var job in CollectionsMarshal.AsSpan(jobs))
    {
        int slot = Find(parent, Math.Min(job.Deadline, size));

        if (slot > 0)
        {
            totalProfit += job.Profit;
            parent[slot] = Find(parent, slot - 1);
        }
    }

    return totalProfit;
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

static int ExitWithUsage()
{
    Console.Error.WriteLine("Usage: please provide a list of profits and a list of deadlines");
    return 1;
}

readonly record struct Job(int Profit, int Deadline);

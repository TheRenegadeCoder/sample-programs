using System;
using System.Collections;

namespace System.Collections
{
    extension List<T>
    where T : IMinMaxValue<T>
    where int : operator T <=> T
    {
        public T Max()
        {
            T max = T.MinValue;
            for (T val in this)
            {
                if (val > max)
                {
                    max = val;
                }
            }

            return max;
        }
    }
}

namespace JobSequencing;

struct JobInfo<T>
where int : operator T <=> T
{
    public int mJobId;
    public T mProfit;
    public int mDeadline;

    public this(int jobId = 0, T profit = default(T), int deadline = 0)
    {
        mJobId = jobId;
        mProfit = profit;
        mDeadline = deadline;
    }

    public bool IsAvailable => mJobId < 1;

    static public int operator <=>(JobInfo<T> lhs, JobInfo<T> rhs)
    {
        // Reverse order of compare so that it is in descending order by profit
        // then deadline
        int result = rhs.mProfit <=> lhs.mProfit;
        if (result == 0)
        {
            result = rhs.mDeadline <=> lhs.mDeadline;
        }

        return result;
    }
}

class JobList<T> : List<JobInfo<T>>
where T : operator T + T
where int : operator T <=> T
{
    public this()
    {
    }

    public this(List<T> profits, List<int> deadlines)
    {
        for (int i < profits.Count)
        {
            this.Add(.(i + 1, profits[i], deadlines[i]));
        }
    }

    public void AddEmptyJobs(int numJobs)
    {
        for (int i < numJobs)
        {
            this.Add(.());
        }
    }

    public T GetTotalProfit()
    {
        T sum = default(T);
        for (JobInfo<T> job in this)
        {
            sum += job.mProfit;
        }

        return sum;
    }
}

class Program
{
    public static void Usage()
    {
        Console.WriteLine("Usage: please provide a list of profits and a list of deadlines");
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

    // Job sequencing with deadlines
    // Source: https://www.techiedelight.com/job-sequencing-problem-deadlines/
    public static void JobSequencing<T>(List<T> profits, List<int> deadlines, JobList<T> slots)
    where T : operator T + T
    where int : operator T <=> T
    {
        // Set up job details
        JobList<T> jobs = scope .(profits, deadlines);

        // Get longest deadline
        int longestDeadline = deadlines.Max();

        // Initialize job slots
        slots.Clear();
        slots.AddEmptyJobs(longestDeadline);

        // Sort jobs by profit then deadline
        jobs.Sort();

        // For each job, see if there is available slot at or before the deadline.
        // If so, store this job in that slot
        for (JobInfo<T> job in jobs)
        {
            for (int j in (0..<job.mDeadline).Reversed)
            {
                if (slots[j].IsAvailable)
                {
                    slots[j] = job;
                    break;
                }
            }
        }
    }

    public static int Main(String[] args)
    {
        if (args.Count < 2)
        {
            Usage();
        }

        List<int32> profits = scope .();
        if (ParseIntList(args[0], profits) case .Err)
        {
            Usage();
        }

        List<int> deadlines = scope .();
        if (ParseIntList(args[1], deadlines) case .Err)
        {
            Usage();
        }

        if (profits.Count != deadlines.Count)
        {
            Usage();
        }

        JobList<int32> jobs = scope .();
        JobSequencing<int32>(profits, deadlines, jobs);
        int32 total = jobs.GetTotalProfit();
        Console.WriteLine(total);

        return 0;
    }
}
using System;
using System.Collections.Generic;
using System.Linq;

class Job 
{
    public int Profit { get; set; }
    public int Deadline { get; set; }

    public Job(int profit, int deadline)
    {
        Profit = profit;
        Deadline = deadline;
    }
}

class JobSequencing
{
    static void Main(string[] args)
    {
        if (args.Length < 2)
        {
            Console.WriteLine("Usage: please provide a list of profits and a list of deadlines");
            return;
        }

        var profitList = args[0].Split(',').Select(p => int.TryParse(p.Trim(), out int x) ? x : (int?)null).ToList();
        var deadlineList = args[1].Split(',').Select(d => int.TryParse(d.Trim(), out int x) ? x : (int?)null).ToList();

        if (profitList.Contains(null) || deadlineList.Contains(null) || profitList.Count != deadlineList.Count)
        {
            Console.WriteLine("Usage: please provide a list of profits and a list of deadlines");
            return;
        }

        var jobs = profitList.Zip(deadlineList, (p, d) => new Job(p.Value, d.Value)).ToList();
        var result = GetMaxProfitJobSequence(jobs);
        Console.WriteLine(result.Sum(job => job.Profit));
    }

    public static List<Job> GetMaxProfitJobSequence(List<Job> jobs)
    {
        jobs.Sort((a, b) => b.Profit.CompareTo(a.Profit));
        int maxDeadline = jobs.Max(job => job.Deadline);
        var timeSlots = new bool[maxDeadline];
        var jobSequence = new List<Job>();

        foreach (var job in jobs)
        {
            for (int i = job.Deadline - 1; i >= 0; i--)
            {
                if (!timeSlots[i])
                {
                    timeSlots[i] = true;
                    jobSequence.Add(job);
                    break;
                }
            }
        }

        return jobSequence;
    }
}

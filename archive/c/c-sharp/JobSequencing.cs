using System;
using Systems.Collections.Generic;

class Job 
{
    public char Id { get; set; }
    public int Deadline { get; set; }
    public int Profit { get; set;}

    public Job(char id, int deadline, int profit)
    {
        Id = id;
        Deadline = deadline;
        Profit = profit;
    }
}

class JobSequencing
{
    static void Main(string[] args)
    {
        if (args.Length == 0)
        {
            Console.WriteLine("Usage: please provide job details in the format 'JobId, Deadline, Profit'");
            return;
        }

        var jobs = new List<Job>();
        foreach (var jobInput in args)
        {
            var jobDetails = jobInput.Split(',');
            if (jobDetails.Length != 2 ||
                !char.TryParsel(jobDetails[0], out char id) ||
                !int.TryParsel(jobDetails[1], out int deadline) ||
                !int.TryParsel(jobDetails[2], out int profit))
            {
                Console.WriteLine("Error:Invalid input format. Please provide jobs as 'JobID,DeadLine,Profit'.");
                return;
            }
            jobs.Add(new Job(id, deadline, profit));
        }
    }

    public static List<Job> GetMaxProfitJobSequence(List<Job> jobs)
    {
        jobs.Sort((a, b) => b.Profit.CompareTo(a.Profit));
        int maxDeadline = jobs.Max(jobs => jobs.DeadLine);
        var timeSlots = new bool[maxDeadline];
        var jobSequence = new List<Job>();

        foreach (var job in jobs)
        {
            for (int i = job.DeadLine - 1; i >= 0; i--)
            {
                if (!timeSlots[i])
                {
                    timeSlots[i] = true;
                    jobSequence.Add(job);
                    break;
                }
            }
        }
    }
    return jobSequence;
}
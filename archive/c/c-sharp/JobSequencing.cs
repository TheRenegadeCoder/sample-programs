using System;
using System.Collections.Generic;
using System.Linq;

// shows a job with profit and deadline properties
class Job 
{
    public int Profit { get; set; }
    public int Deadline { get; set; }

    // constructor to initialize the job with profits and deadline
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
        // check if 2 arugments are provided (lists of profits and deadlines)
        if (args.Length < 2)
        {
            Console.WriteLine("Usage: please provide a list of profits and a list of deadlines");
            return;
        }

        // parse the list of profits from the first arugment
        var profitList = args[0].Split(',').Select(p => int.TryParse(p.Trim(), out int x) ? x : (int?)null).ToList();

        // parse the list of profits from the second arugment
        var deadlineList = args[1].Split(',').Select(d => int.TryParse(d.Trim(), out int x) ? x : (int?)null).ToList();

        // Validate inputs
        if (profitList.Contains(null) || deadlineList.Contains(null) || profitList.Count != deadlineList.Count)
        {
            Console.WriteLine("Usage: please provide a list of profits and a list of deadlines");
            return;
        }

        // combine both profits and deadline sinto job objects
        var jobs = profitList.Zip(deadlineList, (p, d) => new Job(p.Value, d.Value)).ToList();

        // calculate the max profit
        var result = GetMaxProfitJobSequence(jobs);

        // output of total profit
        Console.WriteLine(result.Sum(job => job.Profit));
    }

    // method to calculate the max profits
    public static List<Job> GetMaxProfitJobSequence(List<Job> jobs)
    {

        // sort jobs in descending order
        jobs.Sort((a, b) => b.Profit.CompareTo(a.Profit));

        // find the max deadline of the time slots
        int maxDeadline = jobs.Max(job => job.Deadline);

        // create voolean array to mark time taken of time slots
        var timeSlots = new bool[maxDeadline];

        // store the selected job sequence
        var jobSequence = new List<Job>();

        foreach (var job in jobs)
        {
            for (int i = job.Deadline - 1; i >= 0; i--)
            {
                // time slot is availble the scedule the job
                if (!timeSlots[i])
                {
                    timeSlots[i] = true;
                    jobSequence.Add(job);
                    break;
                }
            }
        }

        // return the selected jobs
        return jobSequence;
    }
}

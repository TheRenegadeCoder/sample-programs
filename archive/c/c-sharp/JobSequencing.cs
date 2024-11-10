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
        Console.WriteLine("Job Sequencing Program");
    }
}
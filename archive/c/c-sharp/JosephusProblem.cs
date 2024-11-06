using System;
using System.Collections.Generic;

namespace JosephusProblem
{
    class Program
    {
        static void Main(string[] args)
        {
            if (args.Length < 2)
            {
                return;
            }

            if (!int.TryParse(args[0], out int n) || !int.TryParse(args[1], out int k) || n <= 0 || k <= 0)
            {
                return;
            }

            int survivor = FindJosephusPosition(n, k);
            Console.WriteLine(survivor);
        }

        static int FindJosephusPosition(int n, int k)
        {
            List<int> people = new List<int>();
            for (int i = 1; i <= n; i++)
            {
                people.Add(i);
            }

            int currentIndex = 0;
            while (people.Count > 1)
            {
                currentIndex = (currentIndex + k - 1) % people.Count;
                people.RemoveAt(currentIndex);
            }

            return people[0];
        }
    }
}
using System;

namespace JosephusProblem
{
    class Program
    {
        const string Usage = "Usage: please input the total number of people and number of people to skip.";

        static void Main(string[] args)
        {
            if (args.Length < 2)
            {
                Console.WriteLine(Usage);
                return;
            }

            if (!int.TryParse(args[0], out int n) || !int.TryParse(args[1], out int k) || n <= 0 || k <= 0)
            {
                Console.WriteLine(Usage);
                return;
            }

            int survivor = FindJosephusPosition(n, k);

            Console.WriteLine(survivor);
        }

        static int FindJosephusPosition(int n, int k)
        {
            int result = 0;

            for (int m = 2; m <= n; m++)
            {
                result = (result + k) % m;
            }

            return result + 1;
        }
    }
}

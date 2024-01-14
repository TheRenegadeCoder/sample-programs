using System;

namespace FizzBuzz;

class Program
{
    public static int Main(String[] args)
    {
        for (int i in 1...100)
        {
            String line = scope String();
            if ((i % 3) == 0)
            {
                line.Append("Fizz");
            }

            if ((i % 5) == 0)
            {
                line.Append("Buzz");
            }

            if (line.Length == 0)
            {
                i.ToString(line);
            }

            Console.WriteLine(line);
        }
        return 0;
    }
}

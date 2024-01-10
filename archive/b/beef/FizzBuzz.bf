using System;

namespace FizzBuzz;

class Program
{
    public static int Main(String[] args)
    {
        for (var i in 1...100)
        {
            let line = scope String();
            if ((i % 3) == 0)
            {
                line.Append("Fizz");
            }

            if ((i % 5) == 0)
            {
                line.Append("Buzz");
            }

            if (line == "")
            {
                line.Append(i);
            }

            Console.WriteLine(line);
        }
        return 0;
    }
}

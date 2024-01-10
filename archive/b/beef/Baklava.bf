using System;

namespace Baklava;

class Program
{
    public static int Main(String[] args)
    {
        for (var i in -10...10)
        {
            let num_spaces = Math.Abs(i);
            let num_stars = 21 - 2 * num_spaces;
            let line = scope String();
            line.Append(' ', num_spaces);
            line.Append('*', num_stars);
            Console.WriteLine(line);
        }
        return 0;
    }
}

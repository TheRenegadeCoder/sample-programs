using System;
namespace Quine;
class Program
{
    public static int Main(String[] args)
    {
        String s = """
using System;
namespace Quine;
class Program
{1}
    public static int Main(String[] args)
    {1}
        String s = {2}{2}{2}
{0}
{2}{2}{2};
        Console.WriteLine(s, s, (char8)123, (char8)34, (char8)125);
        return 0;
    {3}
{3}
""";
        Console.WriteLine(s, s, (char8)123, (char8)34, (char8)125);
        return 0;
    }
}

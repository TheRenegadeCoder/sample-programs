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
{{
    public static int Main(String[] args)
    {{
        String s = {1}{1}{1}
{0}
{1}{1}{1};
        Console.WriteLine(s, s, '"');
        return 0;
    }}
}}
""";
        Console.WriteLine(s, s, '"');
        return 0;
    }
}

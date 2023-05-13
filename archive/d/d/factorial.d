// Factorial program in D
import std.stdio: writeln;
import std.conv: to, ConvException;
import core.stdc.stdlib: exit;

void usage()
{
    writeln("Usage: please input a non-negative integer");
    exit(0);
}

int fac(int a)
{
    if (a <= 1)
    {
        return 1;
    }
    return a*fac(a-1);
}

int main(string[] args)
{
    if (args.length < 2)
    {
        usage();
    }

    int depth;
    try {
        depth = to!int(args[1]);
        if (depth < 0)
        {
            usage();
        }
    }
    catch(ConvException _)
    {
        usage();
    }

    int result = fac(depth);
    writeln(result);
    return 0;
}

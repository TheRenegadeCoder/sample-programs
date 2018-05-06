import std.stdio;

void main(string[] args)
{
    foreach (i, arg; args)
        writefln("args[%d] = '%s'", i, arg);
}

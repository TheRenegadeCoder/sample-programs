import std.stdio, std.array;

void main (string[ ] args)
{

    for (byte i = 0; i < 10; i++)
        writeln (
            " ".replicate (10 - i), "*".replicate (i * 2 + 1)
        );

    for (byte i = 10; -1 < i; i--)
        writeln (
            " ".replicate (10 - i), "*".replicate (i * 2 + 1)
        );

}

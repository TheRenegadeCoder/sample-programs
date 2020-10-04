

// Factorial program in D


import std.stdio: writeln;
import std.getopt;
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
  int depth;
  auto params = getopt(args, "depth", &depth);
  int result = fac(depth);
  writeln(result);
  return 0;
}

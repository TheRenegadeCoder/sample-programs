#include <iostream>
#include <cstdlib>
using namespace std;

int main(int argc, char *argv[])
{
  if (argc < 2 || std::string(argv[1]) == "")
  {
    cout << "Usage: please input the count of fibonacci numbers to output" << endl;
    return 1;
  }

  int n = atoi(argv[1]);
  if (n == 0 && std::string(argv[1]) != "0")
  {
    cout << "Usage: please input the count of fibonacci numbers to output" << endl;
    return 1;
  }
  int first = 0;
  int second = 1;
  int result = 0;

  for (int i = 1; i <= n; ++i)
  {
      result = first + second;
      first = second;
      second = result;
      cout << i << ": " << first << endl;
  }
  return 0;
}

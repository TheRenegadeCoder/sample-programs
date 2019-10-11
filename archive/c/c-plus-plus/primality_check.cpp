#include <iostream>
#include <cstdlib>
using namespace std;

int main(int argc, char *argv[])
{
    if (argc < 2 || std::string(argv[1]) == "")
    {
        cout << "Usage: please input a non-negative integer" << endl;
        return 1;
    }

    int n = atoi(argv[1]);
    if (n == 0 && std::string(argv[1]) != "0")
    {
        cout << "Usage: please input a non-negative integer" << endl;
        return 1;
    }
    if (n <= 1)
    {
        cout << "Usage: please input an integer greater than 1" << endl;
        return 1;
    }
    bool isPrime = true;

    for (int i = 2; i * i <= n; ++i)
    {
        if (n % i == 0)
        {
            isPrime = false;
            break;
        }
    }
    cout << n << " is a " << (isPrime ? "Prime" : "non-Prime") << " number" << endl;
    return 0;
}

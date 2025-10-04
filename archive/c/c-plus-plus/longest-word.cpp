#include <iostream>
#include <string>
#include <cstring>
#include <sstream>

using namespace std;

int handle_error()
{
    printf("Usage: please provide a string");
    exit(0);
}

int main(int argc, char *argv[])
{
    if (argc < 2)
    {
        handle_error();
    }
    string inputStr(argv[1]);

    if (inputStr.size() == 0)
    {
        handle_error();
    }
    int max = -1;

    stringstream ss(inputStr);
    string word;
    while (ss >> word)
    {

        int size = word.size();
        if (size > max)
        {
            max = size;
        }
    }
    cout << max;

    return 0;
}
#include <iostream>
#include <string>
#include <unordered_map>
using namespace std;

int handle_error()
{
    cout << "Usage: please provide a string\n";
    exit(0);
}
int main(int argc, char *argv[])
{

    if (argc != 2)
    {
        handle_error();
    }
    string inputStr(argv[1]);

    if (inputStr.size() == 0)
    {
        handle_error();
    }

    unordered_map<char, int> m1;

    for (auto x : inputStr)
    {
        if (m1.find(x) == m1.end())
        {
            m1.insert({x, 1});
        }
        else
        {
            m1[x]++;
        }
    }
    int flag = 1;
    for (int i = 0; i < inputStr.length(); i++)
    {
        if (m1[inputStr[i]] > 1)
        {
            flag = 0;
            cout << inputStr[i] << ": " << m1[inputStr[i]] << "\n";
            m1[inputStr[i]] = 0;
        }
    }
    if (flag == 1)
        cout << "No duplicate characters\n";
    return 0;
}
#include <iostream>
#include <vector>
#include <string>
#include <cstring>
using namespace std;

int main(int argc, char *argv[])
{
    string error = "Usage: please provide a list of integers (\"1, 4, 5, 11, 12\") and the integer to find (\"11\")";

    if (argc != 3)
    {
        cout << error << endl;
        return 1;
    }
    int numberLength = strlen(argv[1]);
    int keyLength = strlen(argv[1]);

    if (numberLength == 0 || keyLength == 0)
    {
        cout << error << endl;
        return 1;
    }
    vector<int> arr;
    string temp = "";
    for (int i = 0; i < numberLength; i++)
    {
        if (argv[1][i] == ',')
        {
            arr.push_back(stoi(temp));
            temp = "";
        }
        else
        {
            temp = temp + argv[1][i];
        }
    }
    arr.push_back(stoi(temp));
    int key = stoi(argv[2]);
    bool found = false;
    for (int i = 0; i < arr.size(); i++)
    {
        if (arr[i] == key)
        {
            found = true;
        }
    }
    if (found)
    {
        cout << "true";
    }
    else
    {
        cout << "false";
    }
}
#include <bits/stdc++.h>
#include <iostream>

using namespace std;

bool is_invalid_roman(char x)
{
    return !(x == 'I'
             || x == 'V'
             || x == 'X'
             || x == 'L'
             || x == 'C'
             || x == 'D'
             || x == 'M');
}

int main(int argc, char *argv[])
{
    if (argv[1] == NULL)
    {
        cerr << "Usage: please provide a string of roman numerals" << endl;
        exit(0);
    }

    string s;
    s = argv[1];

    for (char c : s)
    {
        if (is_invalid_roman(c))
        {
            cerr << "Error: invalid string of roman numerals" << endl;
            exit(0);
        }
    }

    map<char, int> value;
    value['I'] = 1;
    value['V'] = 5;
    value['X'] = 10;
    value['L'] = 50;
    value['C'] = 100;
    value['D'] = 500;
    value['M'] = 1000;

    int num = 0;

    for (int i = s.size() - 1; i >= 0; i--)
    {
        if (i > 0 && value[s[i]] > value[s[i - 1]])
        {
            num += value[s[i]] - value[s[i - 1]];
            i--;
        }
        else
        {
            num += value[s[i]];
        }
    }

    cout << num << endl;
}

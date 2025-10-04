#include <iostream>
#include <bits/stdc++.h>

using namespace std;

void handle_error()
{
    cout << "Usage: please provide a list of sorted integers (\"1, 4, 5, 11, 12\") and the integer to find (\"11\")" << endl;
    exit(0);
}

int check(string s)
{
    int x1 = 0, x2 = s.size() - 1;

    for (int i = 0; i < s.size(); i++)
    {
        if (s[i] != ' ')
        {
            x1 = i;
            break;
        }
    }

    for (int i = s.size() - 1; i >= x1; i--)
    {
        if (s[i] != ' ')
        {
            x2 = i;
            break;
        }
    }

    for (int i = x1; i <= x2; i++)
    {
        if (s[i] == ' ')
        {
            handle_error();
        }
    }

    return stoi(s);
}

vector<int> convert(string s)
{
    if (s.size() == 0)
    {
        handle_error();
    }
    vector<int> v;
    string num = "";
    for (int i = 0; i < s.size(); i++)
    {
        if ((int)s[i] >= 48 && (int)s[i] <= 57 || s[i] == ' ')
        {
            num += s[i];
        }
        else if (s[i] == ',')
        {
            v.push_back(check(num));
            num = "";
        }
        else
        {
            handle_error();
        }
    }

    if (num.size() > 0)
    {
        v.push_back(check(num));
    }

    return v;
}

int main(int argc, char *argv[])
{
    if (argc < 3)
    {
        handle_error();
    }

    vector<int> v = convert(argv[1]);
    int num = check(argv[2]);

    for (int i = 0; i < v.size() - 1; i++)
    {
        if (v[i] > v[i + 1])
        {
            handle_error();
        }
    }

    int start = 0, end = v.size();
    string ans = "false";
    while (start < end)
    {
        int mid = (start + end) / 2;

        if (num < v[mid])
        {
            end = mid;
        }
        else if (v[mid] < num)
        {
            start = mid + 1;
        }
        else if (v[mid] == num)
        {
            ans = "true";
            break;
        }
    }

    if (start > end)
    {
        ans = "false";
    }

    cout << ans << endl;
}

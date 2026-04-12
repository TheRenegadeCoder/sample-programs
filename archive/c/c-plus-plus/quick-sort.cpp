#include <bits/stdc++.h>
#include <iostream>

using namespace std;

void handle_error()
{
    cout
        << "Usage: please provide a list of at least two integers to sort in "
           "the format \"1, 2, 3, 4, 5\""
        << endl;
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
        if (s[i] == ' ')
            handle_error();

    return stoi(s);
}

vector<int> convert(string s)
{
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
        v.push_back(check(num));
    return v;
}

int partition1(vector<int> &a, int l, int u)
{
    int pivot = a[l];
    int i = l;
    int j = u + 1;

    while (true)
    {
        do
        {
            ++i;
        } while (i <= u && a[i] < pivot);

        do
        {
            --j;
        } while (a[j] > pivot);

        if (i >= j)
            break;

        swap(a[i], a[j]);
    }

    swap(a[l], a[j]);
    return j;
}

void quick_sort(vector<int> &a, int l, int u)
{
    int j;
    if (l < u)
    {
        j = partition1(a, l, u);
        quick_sort(a, l, j - 1);
        quick_sort(a, j + 1, u);
    }
}

int main(int argc, char *argv[])
{
    if (argc < 2)
        handle_error();
    vector<int> v = convert(argv[1]);
    if (v.size() < 2)
    {
        cout
            << "Usage: please provide a list of at least two integers to sort "
               "in the format \"1, 2, 3, 4, 5\""
            << endl;
        exit(0);
    }
    int n = v.size();
    int min_idx;
    quick_sort(v, 0, n - 1);
    for (int i = 0; i < n - 1; i++)
        cout << v[i] << ", ";
    cout << v[n - 1];
}

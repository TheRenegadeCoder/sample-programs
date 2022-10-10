#include <bits/stdc++.h>
using namespace std;

const int N = 3e5 + 10;
bool vis[N];
vector<int> g[N];

void handle_error()
{
    cout << "Usage: please provide a tree in an adjacency matrix form (\"0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0\") together with a list of vertex values (\"1, 3, 5, 2, 4\") and the integer to find (\"4\")\n";
    exit(0);
}

int check(string s)
{
    int x1 = 0, x2 = (int)s.size() - 1;

    for (int i = 0; i < s.size(); i++)
    {
        if (s[i] != ' ')
        {
            x1 = i;
            break;
        }
    }

    for (int i = (int)s.size() - 1; i >= x1; i--)
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
        if (((int)s[i] >= 48 && (int)s[i] <= 57) || s[i] == ' ')
        {
            num += s[i];
        }
        else if (s[i] == ',')
        {
            v.push_back(check(num));
            num = "";
        }
    }

    if (num.size() > 0)
    {
        v.push_back(check(num));
    }

    return v;
}

void dfs(int root)
{

    vis[root] = 1;

    for (auto child : g[root])
    {

        if (vis[child])
            continue;

        dfs(child);
        vis[child] = 1;
    }
}

int main(int argc, char *argv[])
{
    if (argc <= 1)
        handle_error();

    vector<int> bin = convert(argv[1]), nodes = convert(argv[2]), t = convert(argv[3]);
    if (bin.size() == 0 || nodes.size() == 0 || t.size() == 0)
        handle_error();

    int sz = (int)nodes.size();
    int k = 0;
    int f = sqrt(bin.size());
    if (sz != f)
        handle_error();
    for (int i = 0; i < bin.size(); i += sz)
    {
        for (int j = i; j < i + sz; j++)
        {
            if (bin[j] == 1)
            {
                g[nodes[j - sz * k]].push_back(nodes[k]);
                g[nodes[k]].push_back(nodes[j - sz * k]);
            }
        }
        k++;
    }

    int src = nodes[0];
    dfs(src);
    if (vis[t[0]])
        cout << "true"
             << "\n";
    else
        cout << "false"
             << "\n";
}

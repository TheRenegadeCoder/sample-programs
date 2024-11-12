#include <bits/stdc++.h>
#define pii pair<int, int>
using namespace std;

const int N = 7;
bool vis[N];
vector<pii> g[N];
vector<int> dis(N, INT_MAX);

void handle_error()
{
    cout << "Usage: please provide three inputs: a serialized matrix, a source node and a destination node";
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
        if (((int)s[i] >= 48 && (int)s[i] <= 57) || s[i] == ' ' || s[i] == '-')
        {
            num += s[i];
        }
        else if (s[i] == ',')
        {
            int x = check(num);
            if (x < 0)
                handle_error();
            v.push_back(x);
            num = "";
        }
    }

    if (num.size() > 0)
    {
        int x = check(num);
        if (x < 0)
            handle_error();
        v.push_back(x);
    }

    return v;
}

vector<int> dijkstra(int src)
{
    set<pii> s;
    s.insert({dis[src], src});
    while (!s.empty())
    {
        pii tp = *s.begin();
        int tpn = tp.second, tpd = tp.first;
        s.erase({tpd, tpn});
        for (auto it : g[tpn])
        {
            int chd = it.second;
            int chn = it.first;
            if (tpd + chd < dis[chn])
            {
                auto it = s.find({dis[chn], chn});
                if (it != s.end())
                    s.erase(it);
                dis[chn] = tpd + chd;
                s.insert({dis[chn], chn});
            }
        }
    }
    return dis;
}

int main(int argc, char *argv[])
{

    if (argc <= 1)
        handle_error();
    vector<int> bin = convert(argv[1]), nodes = convert(argv[2]), t = convert(argv[3]);
    if (bin.size() == 0 || nodes.size() == 0 || t.size() == 0)
        handle_error();
    int des = t[0];
    int src = nodes[0];
    if (src < 0 || des < 0)
        handle_error();

    int sz = sqrt((int)bin.size());
    if ((size_t)sz * sz != bin.size())
        handle_error();
    int k = 0;
    for (int i = 0; i < bin.size(); i += sz)
    {
        for (int j = i; j < i + sz; j++)
        {
            if (bin[j] < 0)
                handle_error();
            if (bin[j] != 0)
            {
                g[j - sz * k].push_back({k, bin[j]});
                g[k].push_back({j - sz * k, bin[j]});
            }
        }
        k++;
    }

    dis[src] = 0;
    vector<int> ans = dijkstra(src);
    if (dis[des] == INT_MAX)
        handle_error();
    cout << ans[des] << "\n";
}

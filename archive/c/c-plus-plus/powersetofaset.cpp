// code to print all possible subsets of a given set using backtracking
#include <bits/stdc++.h>
using namespace std;
#define ll long long
void helper(vector<vector<int>> &v,vector <int> s,ll k,vector <int> &a,int n)
{
    v.push_back(s);
    for(int i=k;i<n;i++)
    {
        s.push_back(a[i]);
        helper(v,s,i+1,a,n);
        s.pop_back(); //backtracking
    }
}
vector<vector<int>> subset(vector <int> &a)
{
    vector <vector <int>> v;
    vector <int> s;
    int n=a.size();
    helper(v,s,0,a,n);
    return v;

}
int main()
{
    vector <int> a{1,2,3};
    vector <vector <int>> v;
    v=subset(a);
    for(ll i=0;i<(v.size());i++)
    {
        for(ll j=0;j<v[i].size();j++)
        {
        cout<<v[i][j]<<" ";
        }
    cout<<endl;
    }
    return 0;
}


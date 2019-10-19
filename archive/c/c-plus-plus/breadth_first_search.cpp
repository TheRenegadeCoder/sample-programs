#include <bits/stdc++.h>
using namespace std;
void addEdge(vector<int> adj[], int u, int v) 
{ 
    adj[u].push_back(v); 
    adj[v].push_back(u); 
} 
void DFS(vector<int> adj[],int V,int i)
{
    vector<bool> vis(V,false);
    queue<int> q;
    q.push(i);
    vis[i]=true;
    while(!q.empty())
    {
        int f=q.front();
        q.pop();
        cout<<f<<" ";
        for(auto i=adj[f].begin();i!=adj[f].end();i++)
        {
            if(vis[*i]==false)
            {
                q.push(*i);
                vis[*i]=true;
            }
        }
    }
}
int main()
{
    int V=5;
    
    vector<int> adj[V];

    addEdge(adj, 0, 1); 
    addEdge(adj, 0, 4); 
    addEdge(adj, 1, 2); 
    addEdge(adj, 1, 3); 
    addEdge(adj, 1, 4); 
    addEdge(adj, 2, 3); 
    addEdge(adj, 3, 4); 
    DFS(adj, V, 2);    
    return 0;
}
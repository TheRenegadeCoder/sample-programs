/*
 
 Depth-First Search Algorithm (DFS)
 What is DFS ?
 -> Depth-first search is an algorithm for traversing ing graph data structure.
 So the basic idea is to start from the root or any arbitrary node and mark the
 node and move to the adjacent unmarked node and continue this loop until there
 is no unmarked adjacent node. Then backtrack and check for other unmarked nodes
 and traverse them. Finally, print the nodes in the path.
 
 */



#include <bits/stdc++.h>
using namespace std;

/* Declaring variables globally. So that we are not required to pass them in functions as parameters */
const int N=3e5+10;
bool vis[N];
vector<int> g[N]; // Adjacency list for representing graph


/* DFS Function */
void dfs(int root)
{
    // Marking the current node as visited and printing it
    vis[root]=1; cout<<root<<" ";
    
    // Recur for all the vertices adjacent to this vertex
    for(auto child:g[root])
    {
        
        // Not visiting a visited node again
        if(vis[child]) continue;
        
        // Marking the child as visited and calling DFS for it
        dfs(child);
        vis[child]=1;
        
    }
}

// Main Function
int main()
{
    /*
     
     For Taking custom input of Graph
     int v,e; cin>>v>>e;
     for(int i=0;i<e;i++)
     {
        int a,b; cin>>a>>b;
        g[a].push_back(b); g[b].push_back(a);
     }
     
     */
    
    // For this let us consider an example
    /*
     
     1------2-------3
     |      |
     |      |
     |      |
     4      5-------6------7
     
     */
    int v = 7 , e = 6 ;
    g[1].push_back(2); g[2].push_back(1);
    g[2].push_back(3); g[3].push_back(2);
    g[4].push_back(1); g[1].push_back(4);
    g[5].push_back(2); g[2].push_back(5);
    g[5].push_back(6); g[6].push_back(5);
    g[6].push_back(7); g[7].push_back(6);
    
    // Calling DFS considering 1 as the source (starting point)
    dfs(1);
    
    
    // How DFS traversed ?
    /*
     
     #    1
     
     
     #    1------2
     
     
     #    1------2-------3              // We traversed till max depth in this path !
     
     
     #    1------2-------3
                 |
                 |
                 |
                 5
     
     
     #    1------2-------3
                 |
                 |
                 |
                 5-------6
     
     
     #    1------2-------3
                 |
                 |
                 |
                 5-------6------7       // We traversed till max depth in this path !
     
     
     #    1------2-------3
          |      |
          |      |
          |      |
          4      5-------6------7
     
     
     */
    
}

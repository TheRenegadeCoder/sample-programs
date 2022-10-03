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

void handle_error()
{
    cout<<"Usage: please provide a tree in an adjacency matrix form (\"0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0\") together with a list of vertex values (\"1, 3, 5, 2, 4\") and the integer to find (\"4\")\n";
    exit(0);
}

//Function to check whether inputs satisfy given constraints
int check(string s){
    int x1=0,x2=(int)s.size()-1;

    //x1 gives first index position where integer occurs
    for(int i=0;i<s.size();i++){
        if(s[i]!=' '){
            x1=i;
            break;
        }
    }

    //x2 gives last index position where integer occurs
    for(int i=(int)s.size()-1;i>=x1;i--){
        if(s[i]!=' '){
            x2=i;
            break;
        }
    }
    
    //if any space occurs between this substring then throw error
    for(int i=x1;i<=x2;i++){
        if(s[i]==' '){
            handle_error();
        }
    }

    return stoi(s);
}


//Function for converting string input into integer vector
vector<int> convert(string s){
    /*
        Loop to convert numbers in string to integers
    */
    if(s.size()==0){
        handle_error();
    }
    vector<int> v;
    string num="";
    for(int i=0;i<s.size();i++){
        if(((int)s[i]>=48 && (int)s[i]<=57) || s[i]==' '){
            num+=s[i];
        }else if(s[i]==','){
            v.push_back(check(num));
            num="";
        }
    }


    if(num.size()>0){
        v.push_back(check(num));
    }
    
    return v;
}

/* DFS Function */
void dfs(int root)
{
    // Marking the current node as visited and printing it
    // cout<<root<<" ";
    vis[root]=1;
    
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
int main(int argc, char *argv[])
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

    if(argc<=1) handle_error();

    vector<int> bin = convert(argv[1]) , nodes = convert(argv[2]) , t = convert(argv[3]) ;
    if(bin.size() == 0 || nodes.size() ==0 || t.size()==0) handle_error();

    int sz = (int) nodes.size();
    int k=0;
    int f = sqrt(bin.size());
    if(sz!=f) handle_error();
    for(int i=0;i<bin.size();i+=sz)
    {
        for(int j=i;j<i+sz;j++)
        {
            if(bin[j]==1)
            {
                g[nodes[j-sz*k]].push_back(nodes[k]);
                g[nodes[k]].push_back(nodes[j-sz*k]);
            }
        }
        k++;
    }
    
    int src = nodes[0];
    dfs(src);
    if(vis[t[0]]) cout<<"true"<<"\n";
    else cout<<"false"<<"\n";
    


    // Calling DFS considering 1 as the source (starting point)
    
    
    
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

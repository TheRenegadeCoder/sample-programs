/*** Dijkstra - Single source Multiple Destination ***/

#include <iostream>
#include <vector>
#include <queue>
using std::vector;
using std::priority_queue;
using std::cin;
using std::cout;
using std::pair;
using std::make_pair;

const int OO = 1e9;   // Infinity
vector<int> SP;
vector< vector<pair<int,int> > > adj;

struct node
{
	int id,cost;
	node(int _id , int _cost)
	{
		id = _id , cost = _cost;
	}
	bool operator < (const node & nn) const
	{
		return cost > nn.cost;
	}
};

int dijkstra(int Source, int Destination, int Number_of_nodes)
{
	// Create a priority queue to store nodes that
	// are being preprocessed.
	priority_queue<node> q;

	// Create a vector for distances and initialize all
    // distances as infinite (OO)
	SP.resize(Number_of_nodes+10, OO);

	// Insert source itself in priority queue and initialize
    // its distance as 0.
	q.push(node(Source , 0));
	SP[Source] = 0;


	while(!q.empty())
	{
		node cur = q.top();
		q.pop();
		int u = cur.id;
		int cost = cur.cost;
		// Get all adjacent of u.
		for (auto v : adj[u])
		{
			// If there is shorted path to v through u.
			if (cost + v.second < SP[v.first])
			{
				// Updating distance of v
				SP[v.first] = cost + v.second;
				q.push(node(v.first, SP[v.first]));
			}
		}
	}

	return SP[Destination];
}


int main()
{
	int n,m;
	cout << "Enter the number of nodes : \n";
	cin >> n;
	adj.resize(n);
	cout << "Enter the number of edges : \n";
	cin >> m;
	int u,v,w;
	for (int i = 0; i < m; i++)
	{
		cout << "Edge " << i+1 << " From : ";
		cin >> u;
		cout << "To : ";
		cin >> v;
		cout << "Weight : ";
		cin >> w;
		adj[u].push_back(make_pair(v,w));
	}

	cout << "Run Dijkstra From : ";
	cin >> u;
	cout << "To : ";
	cin >> v;

	int Answer = dijkstra(u,v,n);
	if (Answer == OO)
		cout << "No path from node : " << u << " to node : " << v << '\n';
	else
		cout << "The Minimum Cost to go from node : " << u
		 	<<  " to node : " << v << " is : " << Answer << '\n';

}

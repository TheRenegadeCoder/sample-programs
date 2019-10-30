/*** Dijkstra - Single source Multiple Destination ***/

#include <iostream>
#include <vector>
#include <queue>
#include <math.h>
using std::vector;
using std::queue;
using std::cin;
using std::cout;
using std::pair;
using std::make_pair;

const int OO = 1e9;   // Infinity
vector<int> SP;
vector<vector<int>> adj;

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
	queue<node> q;

	// Create a vector for distances and initialize all
    // distances as infinite (OO)
	SP.resize(Number_of_nodes+10, OO);

	// Insert source itself in priority queue and initialize
    // its distance as 0.
	q.push(node(Source , 0));
	SP[Source] = 0;


	while(!q.empty())
	{
		node cur = q.front();
		q.pop();
		int u = cur.id;
		int cost = cur.cost;
		// Get all adjacent of u.
		for (int i = 0; i < Number_of_nodes; i++)
		{
			int v = adj[u][i];
			if (!v) continue;
			// If there is shorted path to v through u.
			if (cost + v < SP[i])
			{
				// Updating distance of v
				SP[i] = cost + v;
				q.push(node(i, SP[i]));
			}
		}
	}

	return SP[Destination];
}


int main(int argc, char *argv[])
{
	
	if (argc < 4 || std::string(argv[1]).size() == 0)
	{
		if (argc == 3) 
		{
			cout << "Usage: please provide a destination\n";
			return 1;
		}
		if (argc == 2)
		{
			cout << "Usage: please provide source and destination\n";
			return 1;
		}
		cout << "Usage: please provide a comma-separated list of integers\n";
		return 1;
	}
	std::string s = std::string(argv[1]);

	vector<int> num;
	int val = 0;
	for (int i = 0; i < s.size(); ++i)
	{
		if (s[i] == ',' && i <= s.size() - 3 && s[i+1] == ' ')
		{
			num.push_back(val); i++;
		}
		else if (s[i] >= '0' && s[i] <= '9')
		{
			val *= 10;
			val += s[i] - '0';
		}
		else
		{
			cout << "Usage: please provide a comma-separated list of integers\n";
			return 1;
		}
	}
	num.push_back(val);


	int sz = num.size();
	int n = sqrt(sz);
	if (n * n != sz)
	{
		cout << "Usage: please provide a comma-separated list of integers\n";
		return 1;
	}

	adj.resize(n, vector<int>(n));
	for (int i = 0; i < n; ++i)
	{
		for (int j = 0; j < n; ++j)
		{
			adj[i][j] = num[i * n + j];
			if (adj[i][j] < 0)
			{
				cout << "Usage: please provide positive weights\n";
				return 1;
			}
		}
	}
}

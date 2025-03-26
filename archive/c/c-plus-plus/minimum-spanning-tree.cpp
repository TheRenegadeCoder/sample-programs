#include <iostream>
#include <sstream>
#include <vector>
#include <string>
#include <cmath>
#include <algorithm>

using namespace std;

struct Edge {
    int src, dest, weight;
};

int find(vector<int>& parent, int i) {
    if (parent[i] != i)
        parent[i] = find(parent, parent[i]);
    return parent[i];
}

void unionp(vector<int>& parent, vector<int>& rank, int x, int y) {
    int xroot = find(parent, x);
    int yroot = find(parent, y);
    
    if (rank[xroot] < rank[yroot])
        parent[xroot] = yroot;
    else if (rank[xroot] > rank[yroot])
        parent[yroot] = xroot;
    else {
        parent[yroot] = xroot;
        rank[xroot]++;
    }
}

int main(int argc, char* argv[]) {
    if (argc < 2) {
        cout << "Usage: please provide a comma-separated list of integers";
        return 0;
    }
    
    string input = argv[1];
    if (input.empty()) {
        cout << "Usage: please provide a comma-separated list of integers";
        return 0;
    }
    
    vector<int> values;
    istringstream iss(input);
    string token;
    while (getline(iss, token, ',')) {
        // Trim spaces from token.
        size_t start = token.find_first_not_of(" \t");
        size_t end = token.find_last_not_of(" \t");
        if (start == string::npos) token = "";
        else token = token.substr(start, end - start + 1);
        
        try {
            int num = stoi(token);
            values.push_back(num);
        } catch (...) {
            cout << "Usage: please provide a comma-separated list of integers";
            return 0;
        }
    }
    
    int n = values.size();
    int side = static_cast<int>(sqrt(n));
    if (side * side != n) {
        cout << "Usage: please provide a comma-separated list of integers";
        return 0;
    }
    
    vector<vector<int>> matrix(side, vector<int>(side, 0));
    int index = 0;
    for (int i = 0; i < side; i++) {
        for (int j = 0; j < side; j++) {
            matrix[i][j] = values[index++];
        }
    }

    vector<Edge> edges;
    int V = side; 
    for (int i = 0; i < V; i++) {
        for (int j = i + 1; j < V; j++) {
            int weight = matrix[i][j];
            if (weight != 0) {
                edges.push_back({i, j, weight});
            }
        }
    }
    
    vector<int> parent(V), rank(V, 0);
    for (int i = 0; i < V; i++) {
        parent[i] = i;
    }
    
    sort(edges.begin(), edges.end(), [](const Edge &a, const Edge &b) {
        return a.weight < b.weight;
    });
    
    int totalCost = 0;
    int countEdges = 0;
    
    for (auto &e : edges) {
        int setU = find(parent, e.src);
        int setV = find(parent, e.dest);
        
        if (setU != setV) {
            totalCost += e.weight;
            unionp(parent, rank, setU, setV);
            countEdges++;
        }
        if (countEdges == V - 1)
            break;
    }
    
    cout << totalCost;
    return 0;
}

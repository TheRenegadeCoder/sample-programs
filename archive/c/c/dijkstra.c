#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>
#include <stdbool.h>
#include <math.h>

#define MAX_NODES 100

int dijkstra(int graph[MAX_NODES][MAX_NODES], int src, int dest, int n) {
    int dist[MAX_NODES];
    bool sptSet[MAX_NODES];

    for (int i = 0; i < n; i++) {
        dist[i] = INT_MAX;
        sptSet[i] = false;
    }

    dist[src] = 0;

    for (int count = 0; count < n - 1; count++) {
        int min = INT_MAX, min_index;

        for (int v = 0; v < n; v++)
            if (sptSet[v] == false && dist[v] <= min)
                min = dist[v], min_index = v;

        int u = min_index;
        sptSet[u] = true;

        for (int v = 0; v < n; v++)
            if (!sptSet[v] && graph[u][v] && dist[u] != INT_MAX
                && dist[u] + graph[u][v] < dist[v])
                dist[v] = dist[u] + graph[u][v];
    }

    return dist[dest] == INT_MAX ? -1 : dist[dest];
}

int main(int argc, char *argv[]) {
    if (argc != 4) {
        printf("Usage: please provide three inputs: a serialized matrix, a source node and a destination node\n");
        return 1;
    }

    char *matrix = argv[1];
    char *src_str = argv[2];
    char *dest_str = argv[3];

    // Check for empty inputs
    if (strlen(matrix) == 0 || strlen(src_str) == 0 || strlen(dest_str) == 0) {
        printf("Usage: please provide three inputs: a serialized matrix, a source node and a destination node\n");
        return 1;
    }

    int src = atoi(src_str);
    int dest = atoi(dest_str);

    long long n = 0;
    for (size_t i = 0; matrix[i]; i++) {
        if (matrix[i] == ',') n++;
    }
    n = (long long)sqrt((double)n + 1);

    if (src < 0 || dest < 0 || src >= n || dest >= n) {
        printf("Usage: please provide three inputs: a serialized matrix, a source node and a destination node\n");
        return 1;
    }

    int graph[MAX_NODES][MAX_NODES] = {0};
    char *token = strtok(matrix, ", ");
    for (int i = 0; i < n && token; i++) {
        for (int j = 0; j < n && token; j++) {
            int weight = atoi(token);
            if (weight < 0) {
                printf("Usage: please provide three inputs: a serialized matrix, a source node and a destination node\n");
                return 1;
            }
            graph[i][j] = weight;
            token = strtok(NULL, ", ");
        }
    }

    int result = dijkstra(graph, src, dest, (int)n);
    if (result == -1) {
        printf("Usage: please provide three inputs: a serialized matrix, a source node and a destination node\n");
    } else {
        printf("%d\n", result);
    }

    return 0;
}

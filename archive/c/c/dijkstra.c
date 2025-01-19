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

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_JOBS 100

typedef struct {
    int profit;
    int deadline;
} Job;

int compare(const void* a, const void* b) {
    return ((Job*)b)->profit - ((Job*)a)->profit;
}

int min(int a, int b) {
    return (a < b) ? a : b;
}

int max(int a, int b) {
    return (a > b) ? a : b;
}

int jobSequencing(Job jobs[], int n) {
    qsort(jobs, n, sizeof(Job), compare);

    int maxDeadline = 0;
    for (int i = 0; i < n; i++) {
        maxDeadline = max(maxDeadline, jobs[i].deadline);
    }

    int slot[MAX_JOBS] = {0};
    int totalProfit = 0;

    for (int i = 0; i < n; i++) {
        for (int j = min(n, jobs[i].deadline) - 1; j >= 0; j--) {
            if (slot[j] == 0) {
                slot[j] = 1;
                totalProfit += jobs[i].profit;
                break;
            }
        }
    }

    return totalProfit;
}

int* parseInput(char* input, int* size) {
    int* arr = malloc(MAX_JOBS * sizeof(int));
    char* token = strtok(input, ", ");
    *size = 0;
    while (token != NULL) {
        arr[(*size)++] = atoi(token);
        token = strtok(NULL, ", ");
    }
    return arr;
}

int main(int argc, char* argv[]) {
    if (argc != 3) {
        printf("Usage: please provide a list of profits and a list of deadlines\n");
        return 1;
    }

    int profitSize, deadlineSize;
    int* profits = parseInput(argv[1], &profitSize);
    int* deadlines = parseInput(argv[2], &deadlineSize);

    if (profitSize != deadlineSize) {
        printf("Usage: please provide a list of profits and a list of deadlines\n");
        free(profits);
        free(deadlines);
        return 1;
    }

    Job jobs[MAX_JOBS];
    for (int i = 0; i < profitSize; i++) {
        jobs[i].profit = profits[i];
        jobs[i].deadline = deadlines[i];
    }

    int result = jobSequencing(jobs, profitSize);
    printf("%d\n", result);

    free(profits);
    free(deadlines);
    return 0;
}

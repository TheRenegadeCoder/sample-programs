#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int id;      // Job ID
    int profit;  // Profit of the job
    int deadline; // Deadline of the job
} Job;

// Function to compare two jobs based on profit
int compareJobs(const void* a, const void* b) {
    Job* jobA = (Job*)a;
    Job* jobB = (Job*)b;
    return jobB->profit - jobA->profit; // Sort in descending order of profit
}

// Function to perform job sequencing
void jobSequencing(Job jobs[], int n) {
    // Sort jobs based on profit
    qsort(jobs, n, sizeof(Job), compareJobs);

    // To keep track of free time slots
    int result[n]; // Result array to store the sequence of jobs
    int slot[n];   // To keep track of free time slots
    for (int i = 0; i < n; i++) {
        slot[i] = 0; // Initialize all slots as free
    }

    // Iterate over the jobs
    for (int i = 0; i < n; i++) {
        // Find a free slot for this job (going backwards)
        for (int j = (jobs[i].deadline < n ? jobs[i].deadline : n) - 1; j >= 0; j--) {
            if (slot[j] == 0) { // If the slot is free
                slot[j] = 1; // Mark this slot as occupied
                result[j] = jobs[i].id; // Assign job to this slot
                break;
            }
        }
    }

    // Print the scheduled jobs
    printf("Scheduled jobs: ");
    for (int i = 0; i < n; i++) {
        if (slot[i]) { // Print only occupied slots
            printf("Job %d ", result[i]);
        }
    }
    printf("\n");
}

int main() {
    Job jobs[] = {
        {1, 100, 2},
        {2, 19, 1},
        {3, 27, 2},
        {4, 25, 1},
        {5, 15, 3}
    };
    int n = sizeof(jobs) / sizeof(jobs[0]);

    jobSequencing(jobs, n); // Perform job sequencing

    return 0;
}

#include <stdio.h>

// Function to find the position of the last person remaining
int josephus(int n, int k) {
    if (n == 1)
        return 0; // Base case: only one person remains
    else
        return (josephus(n - 1, k) + k) % n; // Recursive case
}

int main() {
    int n, k;

    // Input number of people and step count
    printf("Enter the number of people: ");
    scanf("%d", &n);
    printf("Enter the step count (k): ");
    scanf("%d", &k);

    // Get the position (0-based index) and convert to 1-based index
    int result = josephus(n, k) + 1;

    printf("The position of the last person remaining is: %d\n", result);

    return 0;
}

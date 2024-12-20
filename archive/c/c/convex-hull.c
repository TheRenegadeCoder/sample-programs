#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <ctype.h>

typedef struct {
    int x;
    int y;
} Point;

void printUsageAndExit() {
    printf("Usage: please provide at least 3 x and y coordinates as separate lists (e.g. \"100, 440, 210\")\n");
    exit(1);
}

int compare(const void *p1, const void *p2) {
    Point *point1 = (Point *)p1;
    Point *point2 = (Point *)p2;

    if (point1->x != point2->x) {
        return point1->x - point2->x;
    }
    return point1->y - point2->y;
}

int orientation(Point p, Point q, Point r) {
    int val = (q.y - p.y) * (r.x - q.x) - (q.x - p.x) * (r.y - q.y);
    return (val == 0) ? 0 : (val > 0) ? 1 : 2;
}

void convexHull(Point points[], int n) {
    Point hull[n];
    int hullCount = 0;

    qsort(points, n, sizeof(Point), compare);

    int l = 0;
    for (int i = 1; i < n; i++)
        if (points[i].x < points[l].x)
            l = i;

    int p = l, q;
    do {
        hull[hullCount++] = points[p];
        q = (p + 1) % n;

        for (int i = 0; i < n; i++) {
            if (orientation(points[p], points[i], points[q]) == 2) {
                q = i;
            }
        }

        p = q;
    } while (p != l);

    for (int i = 0; i < hullCount; i++) {
        printf("(%d, %d)\n", hull[i].x, hull[i].y);
    }
}

// Function to check if a string is a valid number
bool isInteger(const char *s) {
    char *end;
    strtol(s, &end, 10); // Convert string to long
    return (*end == '\0' || *end == '\n'); // Check if the entire string was valid
}

// Function to trim whitespace from a string
char* trimWhitespace(char *str) {
    // Trim leading whitespace
    while (isspace((unsigned char)*str)) str++;
    // Trim trailing whitespace
    char *end = str + strlen(str) - 1;
    while (end > str && isspace((unsigned char)*end)) end--;
    *(end + 1) = '\0'; // Null terminate after the last non-space character
    return str;
}

// Function to parse input string and populate the array
int parseInput(const char *input, int **arr, int *size) {
    char *token;
    int capacity = 10; // Initial capacity
    *arr = malloc(capacity * sizeof(int));
    if (*arr == NULL) {
        return false;
    }

    // Tokenize the input string based on commas
    char *inputCopy = strdup(input);
    if (inputCopy == NULL) {
        free(*arr);
        *arr = NULL;
        return false;
    }

    token = strtok(inputCopy, ",");
    *size = 0;
    while (token) {
        trimWhitespace(token); // Trim whitespace around token
        if (!isInteger(token)) {
            free(*arr);
            free(inputCopy);
            *arr = NULL;
            return false; // Exit if a number is invalid
        }

        if (*size >= capacity) {
            capacity *= 2;
            *arr = realloc(*arr, capacity * sizeof(int));
            if (*arr == NULL) {
                free(inputCopy);
                return false;
            }
        }
        (*arr)[(*size)++] = atoi(token);
        token = strtok(NULL, ",");
    }

    // Resize the array to the actual size
    *arr = realloc(*arr, *size * sizeof(int));
    free(inputCopy); // Free the input copy
    if (*arr == NULL) {
        return false;
    }

    return true; // Successful parsing
}

void parseCoordinates(char *inputX, char *inputY) {
    int *xCoords = NULL;
    int *yCoords = NULL;
    int xSize = 0;
    int ySize = 0;
    if (!parseInput(inputX, &xCoords, &xSize) ||
        !parseInput(inputY, &yCoords, &ySize) ||
        xSize != ySize ||
        xSize < 3) {
        if (xCoords != NULL) {
            free(xCoords);
        }

        if (yCoords != NULL) {
            free(yCoords);
        }

        printUsageAndExit();
    }

    int count = xSize;
    Point *points = malloc(sizeof(Point) * count);
    if (points == NULL) {
        free(xCoords);
        free(yCoords);
        printUsageAndExit();
    }

    for (int i = 0; i < count; i++) {
        points[i].x = xCoords[i];
        points[i].y = yCoords[i];
    }

    free(xCoords);
    free(yCoords);

    convexHull(points, count);
    free(points);
}

int main(int argc, char *argv[]) {
    if (argc != 3) {
        printUsageAndExit();
    }

    char *inputX = argv[1];
    char *inputY = argv[2];

    if (strlen(inputX) == 0 || strlen(inputY) == 0) {
        printUsageAndExit();
    }

    parseCoordinates(inputX, inputY);
    return 0;
}

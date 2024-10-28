#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

typedef struct {
    int x, y;
} Point;

int orientation(Point p, Point q, Point r) {
    int val = (q.y - p.y) * (r.x - q.x) - (q.x - p.x) * (r.y - q.y);
    if (val == 0) return 0;  // Collinear
    return (val > 0) ? 1 : 2; // Clock or counterclock wise
}

void convexHull(Point points[], int n) {
    if (n < 3) {
        printf("Convex hull not possible with less than 3 points.\n");
        return;
    }

    int leftmost = 0;
    for (int i = 1; i < n; i++) {
        if (points[i].x < points[leftmost].x) {
            leftmost = i;
        }
    }

    int p = leftmost, q;
    do {
        printf("(%d, %d) ", points[p].x, points[p].y);
        q = (p + 1) % n;
        for (int i = 0; i < n; i++) {
            if (orientation(points[p], points[i], points[q]) == 2) {
                q = i;
            }
        }
        p = q;
    } while (p != leftmost);

    printf("\n");
}

int isInteger(const char *s) {
    while (*s) {
        if (!isdigit(*s) && *s != '-') return 0;
        s++;
    }
    return 1;
}

void parseCoordinates(char *xStr, char *yStr, Point **points, int *n) {
    char *xToken = strtok(xStr, ",");
    char *yToken = strtok(yStr, ",");
    int count = 0;

    while (xToken && yToken) {
        if (!isInteger(xToken) || !isInteger(yToken)) {
            printf("Invalid Integers\n");
            exit(1);
        }
        (*points)[count].x = atoi(xToken);
        (*points)[count].y = atoi(yToken);
        count++;
        xToken = strtok(NULL, ",");
        yToken = strtok(NULL, ",");
    }

    if (xToken || yToken) {
        printf("Different Cardinality\n");
        exit(1);
    }

    *n = count;
}

int main(int argc, char *argv[]) {
    if (argc != 3) {
        printf("Usage: please provide at least 3 x and y coordinates as separate lists (e.g. \"100, 440, 210\")\n");
        return 1;
    }

    char *xStr = argv[1];
    char *yStr = argv[2];

    Point *points = malloc(100 * sizeof(Point));  // Assume a maximum of 100 points for simplicity
    if (!points) {
        printf("Memory allocation failed\n");
        return 1;
    }

    int n = 0;
    parseCoordinates(xStr, yStr, &points, &n);

    if (n < 3) {
        printf("Convex hull not possible with less than 3 points.\n");
        free(points);
        return 1;
    }

    printf("The points in the convex hull are: ");
    convexHull(points, n);

    free(points);
    return 0;
}

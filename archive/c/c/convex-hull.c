#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

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

bool isInteger(const char *s) {
    // Check for an empty string
    if (*s == '\0') {
        return false;
    }

    // Allow a leading negative sign
    if (*s == '-') {
        s++; // Move to the next character
        // If there's no digit after the negative sign, it's not a valid integer
        if (*s == '\0') {
            return false;
        }
    }

    // Check that all remaining characters are digits
    while (*s) {
        if (*s < '0' || *s > '9') {
            return false;
        }
        s++;
    }
    return true;
}

void parseCoordinates(char *inputX, char *inputY) {
    char *tokenX = strtok(inputX, ",");
    char *tokenY = strtok(inputY, ",");

    Point *points = NULL;
    int count = 0;

    while (tokenX && tokenY) {
        if (!isInteger(tokenX) || !isInteger(tokenY)) {
            printUsageAndExit();
        }

        points = realloc(points, sizeof(Point) * (count + 1));
        points[count].x = atoi(tokenX);
        points[count].y = atoi(tokenY);
        count++;

        tokenX = strtok(NULL, ",");
        tokenY = strtok(NULL, ",");
    }

    if (tokenX || tokenY) {
        printUsageAndExit();
    }

    if (count < 3) {
        printUsageAndExit();
    }

    convexHull(points, count);
    free(points);
}

int main(int argc, char *argv[]) {
    if (argc != 3) {
        printUsageAndExit();
    }

    char *inputX = argv[1];
    char *inputY = argv[2];

    if (strlen(inputY) == 0) {
        printUsageAndExit();
    }

    parseCoordinates(inputX, inputY);
    return 0;
}

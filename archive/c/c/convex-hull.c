#include <stdio.h>
#include <stdlib.h>
#include <limits.h>
#include <errno.h>

struct point {
	long x;
	long y;
};

long getorientation (struct point*, struct point*, struct point*);
long getlongorexit (char*);
void usageandexit (char*, int);

int main (int argc, char *argv[])
{
	long i, numpoints, j;
	struct point *points = NULL;
	struct point *leftmost;
	struct point *nexthullpoint;
	struct point *temp;

	/* At least 2 command line args and an even amount of them */
	if (argc < 3 || argc % 2 != 1)
		usageandexit(argv[0], 0);

	numpoints = (argc - 1) / 2;

	/* Get some memory for our point array */
	points = malloc(sizeof(struct point) * numpoints);
	if (!points) {
		fprintf(stderr, "No memory!\n");
		exit(1);
	}

	/* Parse command line args into integers or die*/
	for (i = 0; i < numpoints; i++) {
		errno = 0;
		points[i].x = getlongorexit(argv[i+1]);
		points[i].y = getlongorexit(argv[numpoints + 1 + i]);
	}

	/*
	 * Determine left-most element in array, as it's guaranteed to be a
	 * 	hull point
	 */

	leftmost = points;
	for (i = 1; i < numpoints; i++)
		if (leftmost->x > points[i].x)
			leftmost = &points[i];

	puts("Convex hull points:");

	nexthullpoint = leftmost;
	do {
		/* Print next hull point */
		printf("(%ld, %ld)\n", nexthullpoint->x, nexthullpoint->y);

		/*
		 * Start looking for the next hull point at the next point in
		 * the array (circularly).
		 */
		temp = (points + numpoints - 1 == nexthullpoint) ? points : nexthullpoint + 1;

		/* For our array of points */
		for (j = 0; j < numpoints; j++)
			/* If the next point is more counter-clockwise */
			if (getorientation(nexthullpoint, &points[j], temp) < 0)
				/* Update the next point */
				temp = &points[j];

		nexthullpoint = temp;
	/* While the next most counter-clockwise point is not the leftmost */
	} while (nexthullpoint != leftmost);

	free(points);

	return 0;
}

/*
 * Function to determine orientation.  Formula described here:
 * https://www.geeksforgeeks.org/orientation-3-ordered-points/
 *
 * Negative when counter-clockwise, zero when colinear, and positive when
 * 	clockwise.
 */
long getorientation (struct point *p1, struct point *p2, struct point *p3)
{
	return (p2->y - p1->y) * (p3->x - p2->x) - (p3->y - p2->y) * (p2->x - p1->x);
}

long getlongorexit (char *s)
{
	long n;
	char *endptr;

	errno = 0;
	n = strtol(s, &endptr, 10);
	if ((errno == ERANGE && (n == LONG_MIN || n == LONG_MAX)) ||
			(errno != 0 && n == 0)) {
		perror("strtol");
		exit(1);
	}

	if (endptr == s || !(*endptr == '\0' || *endptr == '\n')) {
		fprintf(stderr, "Not a valid integer\n");
		exit(1);
	}

	return n;
}

void usageandexit (char *name, int code)
{
	printf("Usage: %s x1 x2 x3 ... xN y1 y2 y3 ... yN\n", name);
	exit(code);
}

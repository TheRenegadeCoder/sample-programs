#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <errno.h>
#include <limits.h>

int uint64_overflow(long, long);

int main (int argc, char *argv[])
{
	long n;
	char *endptr;
	uint64_t result = 1;
	long i;

	/* Correct nmber of args? */
	if (argc != 2) {
		printf("Usage: please input a non-negative integer\n");
		exit(0);
	}

	/* Convert argument to number */
	errno = 0;
	n = strtol(argv[1], &endptr, 10);
	if ((errno == ERANGE && (n == LONG_MAX || n == LONG_MIN))
			|| (errno != 0 && n == 0)) {
		perror("strtol");
		exit(1);
	}

	if (endptr == argv[1] ||
			!(*endptr == '\0' || *endptr == '\n') ||
			n < 0) {
		fprintf(stderr, "Usage: please input a non-negative integer\n");
		exit(1);
	}

	/* For non-zero numbers, compute factorial */
	if (n) {
		for (i = 1; i <= n; i++) {
			if (uint64_overflow(result, i)) {
				printf("Results overflowed\n");
				exit(1);
			}

			result *= i;
		}
	}

	/* Priunt result */
	printf("%ld\n", result);

	return 0;
}

/*
 * Detects overflow from 64-bit multiplication.
 *
 * Returns 1 if an overflow occurs, 0 if not
 */
int uint64_overflow(long a, long b) {
	uint64_t x;
	uint64_t b_64;

	x = a * b;
	b_64 = b;

	return (a != 0 && x / a != b_64) ? 1 : 0;
}

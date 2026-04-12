#include <errno.h>
#include <inttypes.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

static void usage(void)
{
    fputs("Usage: please input a non-negative integer\n", stderr);
    exit(EXIT_FAILURE);
}

void zeckendorf(uint64_t n)
{
    if (n == 0)
    {
        putchar('\n');
        return;
    }

    uint64_t a = 1, b = 2;

    while (b <= n)
    {
        uint64_t next = a + b;
        a = b;
        b = next;
    }

    bool first = true;

    while (n > 0)
    {
        if (a <= n)
        {
            if (!first)
                fputs(", ", stdout);
            printf("%" PRIu64, a);
            n -= a;
            first = false;
        }

        uint64_t prev = b - a;
        b = a;
        a = prev;
    }

    putchar('\n');
}

int main(int argc, char *argv[])
{
    if (argc != 2)
        usage();

    const char *s = argv[1];
    char *end = NULL;

    errno = 0;
    uint64_t n = strtoull(s, &end, 10);

    if (*s == '\0' || *end != '\0' || errno == ERANGE || *s == '-')
        usage();

    zeckendorf(n);
    return EXIT_SUCCESS;
}
#define _POSIX_C_SOURCE 200809L

#include <stdio.h>

int main(int argc, char **argv)
{
    char *line = NULL;
    size_t bufsize;
    ssize_t linelen;
    size_t linepos;

    /* continuously read a line from stdin */
    while ((linelen = getline(&line, &bufsize, stdin)) != EOF) {
        /* start 1 earlier to discard the newline */
        linepos = linelen - 1;

        /* print characters in reverse */
        while (linepos-- > 0) {
            putchar(line[linepos]);
        }

        /* put an extra newline */
        putchar('\n');
    }

    return 0;
}

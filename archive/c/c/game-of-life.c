#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <limits.h>
#include <stdint.h>
#include <stdbool.h>

#define clear() printf("\033[H\033[J")
#define gotoxy(x,y) printf("\033[%lu;%luH", (y)+1, (x)+1)

#define MAX_FIELD_SIZE 128

static uint32_t field[MAX_FIELD_SIZE / 32 + 1];

static bool is_alive(uint64_t x, uint64_t y, uint64_t field_width)
{
    uint32_t index, entry, bit;

    index = y * field_width + x;
    entry = field[index / 32];
    bit = index % 32;

    return (entry & (1 << bit));
}

static void set_alive(uint64_t x, uint64_t y, uint64_t field_width)
{
    uint32_t index, bit;

    index = y * field_width + x;
    bit = index % 32;

    field[index / 32] |= (1 << bit);
}

static void set_dead(uint64_t x, uint64_t y, uint64_t field_width)
{
    uint32_t index, bit;

    index = y * field_width + x;
    bit = index % 32;

    field[index / 32] &= ~(1 << bit);
}

static uint32_t num_neighbors(uint64_t x, uint64_t y, uint64_t field_width,
        uint64_t field_height)
{
    uint32_t count = 0;

    count += x > 0 && is_alive(x - 1, y, field_width);
    count += y > 0 && is_alive(x, y - 1, field_width);
    count += x < field_width && is_alive(x + 1, y, field_width);
    count += y < field_height && is_alive(x, y + 1, field_width);

    count += x > 0 && y > 0 && is_alive(x - 1, y - 1, field_width);
    count += x > 0 && y < field_height && is_alive(x - 1, y + 1, field_width);
    count += x < field_width && y > 0 && is_alive(x + 1, y - 1, field_width);
    count += x < field_width && y < field_height && is_alive(x + 1, y + 1, field_width);

    return count;
}

static int parse_field_size(char *parse_str, uint64_t *field_size)
{
    char *end;

    errno = 0;

    *field_size = strtoul(parse_str, &end, 10);

    if ((errno == ERANGE && *field_size == ULONG_MAX)
            || (errno != 0 && *field_size == 0)) {
        perror("strtol");
        return -1;
    }

    if (end == parse_str) {
        fprintf(stderr, "Invalid size\n");
        return -1;
    }

    return 0;
}

static void apply_logic(uint64_t width, uint64_t height)
{
    uint32_t neighbors;
    for (uint64_t y = 1; y <= height - 1; ++y) {
        for (uint64_t x = 1; x <= width - 1; ++x) {
            neighbors = num_neighbors(x, y, width, height);
            if (is_alive(x, y, width)) {
                if (neighbors < 2 || neighbors > 3) {
                    set_dead(x, y, width);
                }
            } else {
                if (neighbors == 3) {
                    set_alive(x, y, width);
                }
            }
        }
    }
}

static void draw_field(uint64_t width, uint64_t height)
{
    clear();

    for (uint64_t i = 0; i <= width; ++i) {
        gotoxy(i, (uint64_t) 0);
        putchar('#');
        gotoxy(i, height);
        putchar('#');
    }

    for(uint64_t i = 0; i <= height; ++i) {
        gotoxy((uint64_t) 0, i);
        putchar('#');
        gotoxy(width, i);
        putchar('#');
    }

    for (uint64_t y = 1; y <= height - 1; ++y) {
        for (uint64_t x = 1; x <= width - 1; ++x) {
            if (is_alive(x, y, width)) {
                gotoxy(x, y);
                putchar('X');
            }
        }
    }

    gotoxy(width, height);
    puts("");
}

int main(int argc, char **argv)
{
    uint64_t field_size;
    int rc;

    if (argc < 2) {
        fprintf(stderr, "Usage: %s <size>\n", argv[0]);
        fprintf(stderr, "\tsize: width/height of square game field\n");
        return EXIT_FAILURE;
    }

    /* parse command line arguments */
    rc = parse_field_size(argv[1], &field_size);
    if (rc != 0) {
        return EXIT_FAILURE;
    }

    uint64_t width = field_size;
    uint64_t height = field_size / 2;

    set_alive(width / 2, height / 2, width);
    set_alive(width / 2 + 1, height / 2, width);
    set_alive(width / 2 + 2, height / 2 + 1, width);
    set_alive(width / 2 - 1, height / 2 + 1, width);
    draw_field(width, height);draw_field(width, height);
    getchar();

    while(true) {
        apply_logic(width, height);
        draw_field(width, height);
        getchar();
    }

    return EXIT_SUCCESS;
}

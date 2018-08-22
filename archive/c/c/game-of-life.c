#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <limits.h>
#include <stdint.h>
#include <stdbool.h>
#include <memory.h>
#include <time.h>

#define clear() printf("\033[H\033[J")
#define gotoxy(x,y) printf("\033[%lu;%luH", (y)+1, (x)+1)

#define MAX_FIELD_SIZE 128*128
#define FIELD_ARR_LEN ((MAX_FIELD_SIZE / 32) + 1)
static uint32_t field[FIELD_ARR_LEN];

static bool is_alive(uint64_t x, uint64_t y, uint64_t field_width, uint32_t *f)
{
    uint32_t index, entry, bit;

    index = y * field_width + x;
    entry = f[index / 32];
    bit = index % 32;

    //printf("alive? f[%d] = %d; bit %d = %d\n", index / 32, f[index/32], bit, (entry & (1 << bit)));

    return (entry & (1 << bit));
}

static void set_alive(uint64_t x, uint64_t y, uint64_t field_width, uint32_t *f)
{
    uint32_t index, bit;

    index = y * field_width + x;
    bit = index % 32;

    //printf("x: %d, y: %d, index: %d (%d), bit: %d\n", x, y, index, index / 32, bit);

    f[index / 32] |= (1 << bit);
}

static void set_dead(uint64_t x, uint64_t y, uint64_t field_width, uint32_t *f)
{
    uint32_t index, bit;

    index = y * field_width + x;
    bit = index % 32;

    f[index / 32] &= ~(1 << bit);
}

static uint32_t num_neighbors(uint64_t x, uint64_t y, uint64_t field_width,
        uint64_t field_height, uint32_t *f)
{
    uint32_t count = 0;

    if (x > 0) {
        count += is_alive(x - 1, y, field_width, f);
        count += y > 0 && is_alive(x - 1, y - 1, field_width, f);
        count += y < field_height && is_alive(x - 1, y + 1, field_width, f);
    }

    if (x < field_width) {
        count += is_alive(x + 1, y, field_width, f);
        count += y > 0 && is_alive(x + 1, y - 1, field_width, f);
        count += y < field_height && is_alive(x + 1, y + 1, field_width, f);
    }

    count += y > 0 && is_alive(x, y - 1, field_width, f);
    count += y < field_height && is_alive(x, y + 1, field_width, f);

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
    uint32_t tmp_field[FIELD_ARR_LEN];
    uint32_t neighbors;

    memcpy(tmp_field, field, FIELD_ARR_LEN);

    for (uint64_t y = 1; y <= height - 1; ++y) {
        for (uint64_t x = 1; x <= width - 1; ++x) {
            neighbors = num_neighbors(x, y, width, height, tmp_field);
            if (is_alive(x, y, width, tmp_field)) {
                if (neighbors < 2 || neighbors > 3) {
                    set_dead(x, y, width, field);
                }
            } else {
                if (neighbors == 3) {
                    set_alive(x, y, width, field);
                }
            }
        }
    }
}

static void draw_field(uint64_t width, uint64_t height)
{
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

    int alive = 0;
    for (uint64_t y = 1; y <= height - 1; ++y) {
        for (uint64_t x = 1; x <= width - 1; ++x) {
            gotoxy(x, y);
            if (is_alive(x, y, width, field)) {
                alive++;
                putchar('X');
            } else {
                putchar(' ');
            }
        }
    }

    gotoxy(width, height);
    puts("");
    printf("alive: %d     \n", alive);
}

static void populate_field(uint64_t width, uint64_t height, double spawn_prob)
{
    uint32_t threshold = spawn_prob * RAND_MAX;
    uint32_t rand_spawn;

    srand(time(NULL));
    for (uint64_t y = 1; y <= height - 1; ++y) {
        for (uint64_t x = 1; x <= width - 1; ++x) {
            rand_spawn = rand();
            if (rand_spawn < threshold) {
                set_alive(x, y, width, field);
            }
        }
    }
}

int main(int argc, char **argv)
{
    uint64_t field_size;
    int rc;
    double spawn_rate = 0.5;
    int fps = 30;

    double secs = 1./fps;

    struct timespec sleep_time = {
        .tv_sec = 0,
        .tv_nsec = secs * 1000000000
    };

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

    clear();
    populate_field(width, height, spawn_rate);
    draw_field(width, height);
    getchar();

    while(true) {
        apply_logic(width, height);
        draw_field(width, height);
        nanosleep(&sleep_time, NULL);
    }

    return EXIT_SUCCESS;
}

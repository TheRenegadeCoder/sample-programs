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

    return (entry & (1 << bit));
}

static void set_alive(uint64_t x, uint64_t y, uint64_t field_width, uint32_t *f)
{
    uint32_t index, bit;

    index = y * field_width + x;
    bit = index % 32;

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

static int parse_args(char **argv, uint64_t *field_size, uint64_t *fps, double *spawn_rate)
{
    int rc;
    char *end;

    errno = 0;

    *field_size = strtoul(argv[1], &end, 10);

    if ((errno == ERANGE && *field_size == ULONG_MAX) || (errno != 0 && *field_size == 0)) {
        perror("strtol");
        return -1;
    }

    if (end == argv[1]) {
        fprintf(stderr, "Invalid field size\n");
        return -1;
    }

    errno = 0;

    *fps = strtoul(argv[2], &end, 10);
    if ((errno == ERANGE && *fps == ULONG_MAX) || (errno != 0 && *fps == 0)) {
        perror("strtol");
        return -1;
    }

    if (end == argv[2]) {
        fprintf(stderr, "Invalid FPS\n");
        return -1;
    }

    rc = sscanf(argv[3], "%lf", spawn_rate);
    if (rc == EOF) {
        fprintf(stderr, "Invalid spawn rate\n");
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
    uint64_t width, height;
    int rc;
    double spawn_rate;
    uint64_t fps;
    struct timespec sleep_time;

    if (argc < 4) {
        fprintf(stderr, "Usage: %s <size> <fps> <spawn_rate>\n", argv[0]);
        fprintf(stderr, "\tsize: width/height of square game field\n");
        fprintf(stderr, "\tfps: target refresh rate\n");
        fprintf(stderr, "\tspawn_rate: floating point value between 0 and 1, " \
                "describing initial spawn probability\n");
        return EXIT_FAILURE;
    }

    /* parse command line arguments */
    rc = parse_args(argv, &field_size, &fps, &spawn_rate);
    if (rc != 0) {
        return EXIT_FAILURE;
    }

    sleep_time = (struct timespec) {
        .tv_sec = 0,
        .tv_nsec = (1./fps) * 1000000000
    };

    width = field_size;
    height = field_size / 2;

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

#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <limits.h>
#include <stdint.h>
#include <stdbool.h>
#include <memory.h>
#include <time.h>

/*
 * Predefine some ANSI escape sequences.
 * These are a series of special characters which can be used to control things
 * like foreground and background color as well as cursor position (which we're
 * using) in most capable terminals.
 */
#define clear() printf("\033[H\033[J")
#define gotoxy(x,y) printf("\033[%lu;%luH", (y)+1, (x)+1)

/*
 * In true C fashion, we are going to use a bitmap to represent the game field.
 * Basically, the rationale behind this is that every cell only has two states:
 * dead and alive. Thus, it can be represented using a single bit.
 *
 * If we create an array of `n` 32-bit integers, we can store `32 * n` cells.
 * Very space-efficient!
 *
 * In this case, we set an upper limit for the field size and divide it by 32
 * to get the number of 32-bit integers we preallocate.
 *
 * The only problem is that looking up and setting cell values gest a little
 * more involved; see the `is_alive`, `set_alive`, and `set_dead` functions
 * below.
 */
#define MAX_FIELD_SIZE 128*128
#define FIELD_ARR_LEN ((MAX_FIELD_SIZE / 32) + 1)
static uint32_t field[FIELD_ARR_LEN];

static bool is_alive(uint64_t x, uint64_t y, uint64_t field_width, uint32_t *f)
{
    uint32_t index, entry, bit;

    /* Calculate the "index" of the bit */
    index = y * field_width + x;

    /* This is the 32-bit integer we need to read in order to get the value */
    entry = f[index / 32];

    /* This is the number of the bit we need to read from the entry */
    bit = index % 32;

    /* Double-negate the result to convert a nonzero value to 1 explicity. */
    return !!(entry & (1 << bit));
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
    /*
     * Count the number of neighbors a cell has. We consider directly
     * orthagonally as well as diagonally adjacent cells neighbors.
     *
     * This (specifically the += statements below) abuse the fact that `true`
     * is guaranteed to evaluate to 1, while `false` evaluates to 0.
     */
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

static int parse_args(char **argv, uint8_t *field_size, uint16_t *fps, double *spawn_rate)
{
    int rc;

    rc = sscanf(argv[1], "%hhu", field_size);
    if (rc == 0 || rc == EOF) {
        fprintf(stderr, "Invalid field size\n");
        return -1;
    }

    rc = sscanf(argv[2], "%hu", fps);
    if (rc == 0 || rc == EOF) {
        fprintf(stderr, "Invalid FPS\n");
        return -1;
    }

    rc = sscanf(argv[3], "%lf", spawn_rate);
    if (rc == 0 || rc == EOF) {
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

    for (uint64_t y = 0; y < height - 1; ++y) {
        for (uint64_t x = 0; x < width - 1; ++x) {
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
    for (uint64_t y = 0; y < height - 1; ++y) {
        for (uint64_t x = 0; x < width - 1; ++x) {
            gotoxy(x + 1, y + 1);
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
    for (uint64_t y = 0; y < height - 1; ++y) {
        for (uint64_t x = 0; x < width - 1; ++x) {
            rand_spawn = rand();
            if (rand_spawn < threshold) {
                set_alive(x, y, width, field);
            }
        }
    }
}

int main(int argc, char **argv)
{
    uint8_t field_size;
    uint8_t width, height;
    int rc;
    double spawn_rate;
    uint16_t fps;
    struct timespec sleep_time;
    double msec_per_frame;

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

    msec_per_frame = (1./fps) * 1000;

    sleep_time = (struct timespec) {
        .tv_sec = msec_per_frame / 1000,
        .tv_nsec = ((long)msec_per_frame % 1000) * 1000000
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

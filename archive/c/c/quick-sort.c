#include <stdio.h>
#include <errno.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

void swap(long* a, long* b)
{
    long t = *a;
    *a = *b;
    *b = t;
}

size_t parse_list(const char *orig_list, long **arr)
{
    char *list;
    char *token;
    size_t num_elements = 0;
    int i;
    int curr_index = 0;
    long temp_num;

    /* figure out the length of the list first */
    for (i = 0; orig_list[i]; i++) {
        if (orig_list[i] == ',') {
            num_elements++;
        }
    }

    /* if there are no commas, it's an invalid list */
    if (num_elements == 0) {
        *arr = NULL;
        return 0;
    }

    /* since there's one more number than there are commas, add one */
    num_elements++;

    /* alloc our array */
    *arr = malloc(num_elements * sizeof(long));

    /* find the numbers */
    list = strdup(orig_list);
    token = strtok(list, ",");
    while (token != NULL) {
        errno = 0;
        temp_num = strtol(token, NULL, 10);
        if (errno != 0) {
            *arr = NULL;
            return 0;
        }

        (*arr)[curr_index++] = temp_num;

        token = strtok(NULL, ",");
    }

    free(list);

    return num_elements;
}

long partition (long *arr, long low, long high)
{
    long pivot = arr[high];
    long i = (low - 1);
    for (long j = low; j <= high- 1; j++)
    {
        if (arr[j] <= pivot)
        {
            i++;
            swap(&arr[i], &arr[j]);
        }
    }
    swap(&arr[i + 1], &arr[high]);
    return (i + 1);
}

void quickSort(long *arr, long low, long high)
{
    if (low < high)
    {
        long pi = partition(arr, low, high);
        quickSort(arr, low, pi - 1);
        quickSort(arr, pi + 1, high);
    }
}

void printArray(long *arr, long size)
{
    long i;
    for (i=0; i < size; i++)
        printf("%ld ", arr[i]);
    printf("\n");
}

void usage()
{
    fputs("Usage: please provide a list of at least two integers to sort in the format \"1, 2, 3, 4, 5\"\n", stderr);
}

int main(int argc, char **argv)
{
    long *arr;
    long num_elements;

    if (argc < 2) {
        usage();
        return 1;
    }

    num_elements = parse_list(argv[1], &arr);

    if (num_elements == 0) {
        usage();
        return 1;
    }

    quickSort(arr, 0, num_elements-1);
    printf("The sorted array is: ");
    printArray(arr, num_elements);
    return 0;
}
// Merge Sort In C Language

#include <stdio.h>
#include <errno.h>
#include <stdlib.h>
#include <string.h>

void merge_sort(long *,int, int);              // Recursive function used for sorting
void merge_array(long *,int, int, int, int);   // Merges two halves of subarray

size_t parse_list(const char *orig_list, long **arr)          // used for parsing the input in array arr
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

/* printing array in desired form */
void print_array(long *arr, size_t num_elems)               
{
    int i;

    for (i = 0; i < num_elems - 1; i++) {
        printf("%ld, ", arr[i]);
    }

    printf("%ld\n", arr[num_elems - 1]);
}

/* Error message if input is not in desired format */
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

    merge_sort(arr,0,num_elements-1);                     // call for complete array [0....n-1]
    print_array(arr, num_elements);

    free(arr);
}

void merge_sort(long *arr_sort,int l, int r) {
  int m;

  if (l < r) {
    m = (l + r) / 2;                    // m is middle index
    merge_sort(arr_sort,l, m);                   // recursive call for first half of subarray arr_sort[l...m]
    merge_sort(arr_sort,m + 1, r);               // recursive call for second half of subarray arr_sort[m+1....r]
    
    merge_array(arr_sort,l, m, m + 1, r);        // merging the two halves into arr_sort[l....r]
  }
}

void merge_array(long *arr_sort,int a, int b, int c, int d) {
  long t[50];                            // Temporary array t created for temporary storage of sorted subarray[l...r] of arr_sort
  int i = a, j = c, k = 0;            // i is starting index for first half [l...m] 
                                        // j is starting index for second half [m+1....r]
                                        // k is starting index for temporary array t
                                        
  while (i <= b && j <= d) {
    if (arr_sort[i] < arr_sort[j])
      t[k++] = arr_sort[i++];
    else
      t[k++] = arr_sort[j++];          // Comparing both indices of first half and second half and adding smaller one to temporary array
  }

  //collect remaining elements if left in first half 
  while (i <= b)
    t[k++] = arr_sort[i++];
    
  //collect remaining elements if left in first half 
  while (j <= d)
    t[k++] = arr_sort[j++];

  for (i = a, j = 0; i <= d; i++, j++)
    arr_sort[i] = t[j];
    
}                                       // End of function merge()


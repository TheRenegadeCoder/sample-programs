// Merge Sort In C Language

#include<stdio.h>
#include<conio.h>

#define MAX_SIZE 5

void merge_sort(int, int);              // Recursive function used for sorting
void merge_array(int, int, int, int);   // Merges two halves of subarray


int arr_sort[MAX_SIZE];                // Array arr_sort declared globally 

int main() {
  int i;

  printf("\nEnter %d Elements for Sorting\n", MAX_SIZE);
  for (i = 0; i < MAX_SIZE; i++)
    scanf("%d", &arr_sort[i]);

  printf("\nYour Data   :");
  for (i = 0; i < MAX_SIZE; i++) {
    printf("\t%d", arr_sort[i]);       // Given Array
  }

  merge_sort(0, MAX_SIZE - 1);        // Call for complete array arr_sort 

  printf("\n\nSorted Data :");
  for (i = 0; i < MAX_SIZE; i++) {
    printf("\t%d", arr_sort[i]);      // Final Array
  }
  getch();

}

void merge_sort(int l, int r) {
  int m;

  if (l < r) {
    m = (l + r) / 2;                    // m is middle index
    merge_sort(l, m);                   // recursive call for first half of subarray arr_sort[l...m]
    merge_sort(m + 1, r);               // recursive call for second half of subarray arr_sort[m+1....r]
    
    merge_array(l, m, m + 1, r);        // merging the two halves into arr_sort[l....r]
  }
}

void merge_array(int a, int b, int c, int d) {
  int t[50];                            // Temporary array t created for temporary storage of sorted subarray[l...r] of arr_sort
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

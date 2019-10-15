// Merge Sort In C Language

#include<stdio.h>
#include<conio.h>

#define MAX_SIZE 100

void merge_sort(int, int);              // Recursive function used for sorting
void merge_array(int, int, int, int);   // Merges two halves of subarray


int arr_sort[MAX_SIZE];                // Array arr_sort declared globally 

int main() {
  int i;
  int length=0;
  char buffer[1024];
  char *aux;
  
  char msg[100] = " Usage: please provide a list of at least two integers to sort in the format “1, 2, 3, 4, 5” ";
  
  fgets(buffer,1023,stdin);
  aux=strtok(buffer, ",");
  
  if(strlen(buffer)==0){
    printf("%s",&msg);
  }
  
  while(aux)
  {
  arr_sort[length]=atoi(aux);
  length++;
  aux=strtok(NULL, ",");
  }
  
  if(length==0||length==1) printf("%s",&msg);
  
  else {
  merge_sort(0, length - 1);        // Call for complete array arr_sort 

  printf("\n\nSorted Data : ");
  for (i = 0; i < length; i++) {
    if(i!=length-1)
      printf("%d, ", arr_sort[i]);     
    else
      printf("%d",arr_sort[i]);
  }
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


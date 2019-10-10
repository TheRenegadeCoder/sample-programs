/Selection-sort in C language with complexity O(n^2)



#include <stdio.h>
#include <stdlib.h>

#define MAX 30000

int *arr;

void *generateRandom()
{
	srand(time(NULL));
	int i;
	for (i=0; i<MAX; i++)
	{
	  arr[i] = rand() % 10001;
	  printf("%d\n", arr[i]);
	}
}

int main()
{
  arr = (int *) malloc(MAX * sizeof(int *));
  
  int i, j, temp = 0;
  generateRandom();
  
  for (i = 0; i < MAX; i++)
  {
    for (j = 0; j < MAX; j++)
    {
      if(arr[i] < arr[j])
      {
	temp = arr[i];
	arr[i] = arr[j];
	arr[j] = temp;
      }
    }
  }
  printf("Sorted\n");
  for (i = 0; i < MAX; i++)
  {
    printf("%d\n", arr[i]);
  }
}

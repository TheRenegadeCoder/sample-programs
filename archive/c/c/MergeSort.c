#include <stdio.h>

void merge(int A[], int l, int m, int u)
{
  int a = m - l + 1, b = u - m, i = 0, j = 0, k;

  int R[a], L[b];

  for(int x = 0; x < a; x++)
    R[x] = A[l + x];
  for(int x = 0; x < b; x++)
    L[x] = A[m + 1 + x];

  k = l;

  while(i < a && j < b)
  {
    if(R[i] <= L[j])
    {
      A[k] = R[i];
      i++;
    }
    else
    {
      A[k] = L[j];
      j++;
    }
    k++;
  }

  while(i < a)
  {
    A[k] = R[i];
    k++;
    i++;
  }

  while(j < b)
  {
    A[k] = L[j];
    k++;
    j++;
  }
}

void mergeSort(int A[], int l, int u)
{
  if(l < u)
  {
    int m = (u + l) / 2;

    mergeSort(A, l, m);
    mergeSort(A, m + 1, u);
    merge(A, l, m, u);
  }
}

void main()
{
  int n;

  printf("Enter n: ");
  scanf("%d", &n);

  int A[n];

  printf("Enter elements: ");
  for(int i = 0; i < n; i++)
    scanf("%d", &A[i]);

  mergeSort(A, 0, n - 1);

  printf("Sorted Array: ");
  for(int i = 0; i < n; i++)
    printf("%d ", A[i]);

  printf("\n");
}

#include<stdio.h>
void main()
{
  int i,j,temp,n,a[50],b[50];
  int pos,small=0;
  clrscr();
  printf("Enter array size:\n");
  scanf("%d",&n);
  printf("Enter array element:\n");
  for(i=0;i<n;i++)
  {
    scanf("%d",&a[i]);
  }
  printf("\n");

  for(i=0;i<n;i++)
  {
    pos = i;small=i;
    for(j=i+1;j<n;j++)
    {
      if(a[j]<a[small])
      small = j;
    }
     temp = a[pos];
     a[pos] = a[small];
     a[small] = temp;
  }

  for(i=0;i<n;i++)
  {
    printf("  %d",a[i]);
  }
  getch();
}
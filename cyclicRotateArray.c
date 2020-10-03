#include<stdio.h>
int main()
{
	int a[10], n, i, temp=0;
	printf("Enter the Array Size::");
	scanf("%d",&n);
	printf("Enter the Array Elements::\n");
	for(i=0; i<n; i++)
	{
		printf("Enter the [%d]th element::",i);
		scanf("%d",&a[i]);
	}
	printf("\nArray is:: ");
	for(i=0; i<n; i++)
		printf("%d\t",a[i]);		
	temp=a[n-1];
	for(i=n-1; i>0; i--)
	{
		a[i]=a[i-1];		
	}
	a[0]=temp;
	printf("\nNew Array is :: ");
	for(i=0; i<n; i++)
		printf("%d\t",a[i]);
}

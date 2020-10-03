#include<stdio.h>
int main()
{
	int a[10], i, n, m, p=0, p_new, d;
	printf("Enter the size of the array::");
	scanf("%d",&n);
	printf("Enter the Array elements::\n");
	for(i=0; i<n; i++)
	{
		printf("Enter the [%d]th element::",i);
		scanf("%d",&a[i]);
	}
	m=a[0];
	for(i=1; i<n; i++)
	{
		p_new = (m>p)?m:p;
		m = p + a[i];
		p = p_new;
	}
	d = (m>p)?m:p;
	printf("Sum is %d",d);
}

#include<stdio.h>
int main()
{
	int n;
	scanf("%d",&n);
	int a[n];
	int max;
	for(int i=0;i<n;i++)
	{
		scanf("%d",&a[i]);
		
		if(i==0)
		max=a[0];
		else
		{
			if(max<a[i])
			max=a[i];
		}
	}
	int c[max+1],b[n];
	int k=max+1;
	for(int i=0;i<k;i++)
	c[i]=0;
	for(int i=0;i<n;i++)
	c[a[i]]++;
	for(int i=1;i<k;i++)
	c[i]=c[i]+c[i-1];
	for(int i=n-1;i>=0;i--)
	{
		b[c[a[i]]-1]=a[i];
		c[a[i]]--;
	}
	
	for(int i=0;i<n;i++)
	printf("%d ",b[i]);
}

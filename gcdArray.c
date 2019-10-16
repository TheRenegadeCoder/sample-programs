#include "stdio.h"
main()
{
	int number,i,k;
	scanf("%d",&number);
	int array[number];
	for(i=0;i<number;i++)
	{
		scanf("%d",array[number]);
	}
	k=array[0];
	for(i=1;i<number;i++)
	{
		k=gcd(k,array[number]);
	}
	printf("%d",k);
}
int gcd(int a,int b)
{
	int c;
	while(c=(a%b)!=0)
	{
		a=b;
		b=c;
	}
	return b;
}
#include<stdio.h>


void upadjust(int heap[],int i)
{
	int temp;
	while(i>1 && heap[i]>heap[i/2])
	{
		temp=heap[i];
		heap[i]=heap[i/2];
		heap[i/2]=temp;
		i=i/2;
		
	}
}
void insert(int heap[],int x)
{
	int n=heap[0];
	heap[n+1]=x;
	heap[0]=n+1;
	upadjust(heap,n+1);
}


void downadjust(int heap[],int i)
{
	int j,temp,n,flag=1;
	n=heap[0];
	while(2*i<=n && flag==1)
	{
		j=2*i;
		if(j+1<=n && heap[j+1]>heap[j])
		j++;
		if(heap[i]>heap[j])
		flag=0;
		else
		{
			temp=heap[i];
			heap[i]=heap[j];
			heap[j]=temp;
			i=j;
		}
	}
}
int delmax(int heap[])
{
	int x,n;
	n=heap[0];
	x=heap[1];
	heap[1]=heap[n];
	heap[0]=n-1;
	downadjust(heap,1);
    return x;	
}


void create(int heap[])
{
	int n,x,i;
	printf("Enter the no. of elements to be inserted.\n");
	scanf("%d",&n);
	printf("Enter the data.\n");
	heap[0]=0;
	for(i=0;i<n;i++)
	{
		scanf("%d",&x);
		insert(heap,x);
	}
}
void heapsort(int heap[])
{
	int n=heap[0];
	int k=n;
	while(k>0)
	{
		int x=delmax(heap);
		heap[k]=x;
	
		k--;
	}
	heap[0]=n;
}

int main()
{
	int heap[100],e;
	int c;
	do
	{
		printf("Enter 1 to create heap.\n");
		printf("Enter 2 to insert an element in heap.\n");
		printf("Enter 3 to delete the maximum element from heap.\n");
		printf("Enter 4 to sort the heap.\n");
		printf("Enter 5 to display the heap.\n");
		printf("Enter 6 to exit.\n");
		printf("Enter your choice.\n");
		scanf("%d",&c);
		switch(c)
		{
			case 1:
				create(heap);
				break;
			case 2:
				printf("Enter the element you want to insert.\n");
				scanf("%d",&e);
				insert(heap,e);
				break;
			case 3:
				printf("The deleted element is: %d\n",delmax(heap));
				break;
			case 4:
				heapsort(heap);
				break;
			case 5:
				printf("Displaying heap\n");
				int n=heap[0];
				for(int i=1;i<=n;i++)
				printf("%d\n",heap[i]);
			    break;
			
		}
		if(c<1 && c>6)
		printf("Invalid Input.\n");
	}while(c!=6);
	
	
	return 0;
}

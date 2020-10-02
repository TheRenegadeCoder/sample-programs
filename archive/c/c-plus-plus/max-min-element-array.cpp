// To find the maximum and minimum element in the array

#include<iostream>
using namespace std;

int main()
{
	int arr[10];

	for (int i=0;i<10;i++)
	{
		cin>>arr[i];
	}
	int min=arr[0];
	int max=arr[0];
	for (int i=1;i<10;i++)
	{
		if(min>arr[i])
			min=arr[i];
		if(arr[i]>max)
			max=arr[i];
	}
	cout<<"Maximum element is: "<<max<<endl;
	cout<<"Minimum element is: "<<min<<endl;
  return 0;
}

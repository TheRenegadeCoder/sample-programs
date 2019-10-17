#include<bits/stdc++.h>
using namespace std;

int main()
{
    long n,i,j;
    cin>>n;
    long arr[n];
    for(i=0;i<n;i++)
       cin>>arr[i];

    for(i=0;i<n-1;i++)
    {
        long min=arr[i];
        long index=i;
        for(j=i;j<n;j++)
        {
            if(arr[j]<min)
            {
                min=arr[j];
                index=j;
            }
        }
        swap(arr[i],arr[index]);
    }
    for(i=0;i<n;i++)
       cout<<arr[i]<<" ";

    return 0;
}

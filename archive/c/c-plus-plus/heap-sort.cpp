#include<bits/stdc++.h>
using namespace std;
void heapify(vector<int> &A, int size,int i)
{
    int largest = i;
    int left = 2*i+1;
    int right = 2*i+2;
    if(left<size && A[left]<A[largest])
    {
        largest = left;
    }
    if(right<size && A[right]<A[largest])
    {
        largest = right;
    }
    if(largest!=i)
    {
        swap(A[i],A[largest]);
        heapify(A,size,largest);
    }

}
void heapsort(vector<int> &A)
{
    for(int i=A.size()-1;i>=0;i--)
        heapify(A,A.size(),i);
    for(int i=A.size()-1;i>=0;i--)
    {
        swap(A[0],A[i]);
        heapify(A,i,0);
    }    
}
int main()
{
    vector<int> A={12, 11, 13, 5, 6, 7};
    heapsort(A);
    for(int i=0;i<A.size();i++)cout<<A[i]<<" ";
    return 0;
}
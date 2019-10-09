#include <iostream>
#define num 1000000
using namespace std;

void insertion_sort(int arr[], int n){
    int t,j;
    for(int i=1;i<n;i++){
        t = arr[i];
        j = i-1;
        while(j >= 0 && t<=arr[j]){
            arr[j+1] = arr[j];
            j--;
        }
        arr[j+1] = t;
    }
}

void show(int arr[], int n)  
{  
    int i;  
    for (i = 0; i < n; i++)  
        cout << arr[i] << " ";  
    cout << endl; 
} 

int main()  
{  
    int n;  
    cout<<"Enter the length of the array ";
    cin>>n;
    cout<<endl;
    int arr[num];
    for(int i=0;i<n;i++){
        cin>>arr[i];
    }
  
    insertion_sort(arr, n);   
    
    cout<<endl;
    show(arr,n);
  
    return 0;  
}  

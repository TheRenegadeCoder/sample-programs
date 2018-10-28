/* C++ program to print largest contiguous subarray sum for array with negative numbers.
Kadane's Algorithm.
Time Complexity O(n).
Space Complexity O(1) */
#include<iostream>
#include<climits>
using namespace std;

/*Function returns Maximum Subarray Sum*/
int maxSubArraySum(int a[], int size)
{
    int curr_max = INT_MIN, temp_max = 0;

    for (int i = 0; i < size; i++)
    {
        temp_max = temp_max + a[i];
        if (curr_max < temp_max)
            curr_max = temp_max;

        if (temp_max < 0)
            temp_max = 0;
    }
    return curr_max;
}

/*Main Function*/
int main()
{
    int i,n;
    cout << "Enter no of elements in array : "<<endl;
    cin>>n;
    int a[n];
    cout<<"Enter the array elements : "<<endl;
    for(i = 0; i < n; i++)
        cin>>a[i];
    int max_sum = maxSubArraySum(a, n);
    cout << "Maximum contiguous sum is " << max_sum;
    return 0;
}

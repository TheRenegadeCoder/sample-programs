---
title: Insertion Sort in C++
layout: default
last-modified: 2019-10-09
featured-image:
tags: [c-plus-plus, Insertion-sort]
authors:
  - sun-fox
---

In this article, we'll learn the implementation of insertion sort algorithm in C++.

## How to Implement the Solution

Let's first take a look at the solution. Then, we'll walk through each line of code:

```c++
#include <iostream>

using namespace std;

void insertion_sort(int arr[], int n)
{

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
    int arr[n];
    for(int i=0;i<n;i++){
        cin>>arr[i];
    }
    insertion_sort(arr, n);   
    cout<<endl;
    show(arr,n);
  
    return 0;  
}  
```

### Includes

In our sample, we include a single standard library utility:

```c++
#include <iostream>
```

Here, we can see that we include the standard I/O for printing messages onto the
screen and for taking the inputs from the user.

### Insertion-Sort Function
In our sample, this function is responsible for sorting the array according 
to the insertion sort algorithm:

```c++
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
```

This function accepts the input array and the size of the array from the main function 
Here we virtually divide the array into two parts i.e., the sorted and the unsorted part,
initially, the first element in the array is considered as sorted, even if it is not sorted.
Further, each element in the array is checked with the previous elements for the strict
inequality with each iteration, the sorting algorithm removes one element at a time and
finds the appropriate location within the sorted array and inserts it there. The iteration
continues until the unsorted array is empty.

Above you can see, that the variable 't' holds the unsorted array's first element and 'j' 
here keeps track of the index of the last element of the sorted array. Now we iterate 
throughout the remaining unsorted array one by one, finding a relevant position for the 
the value stored in 't' throughout the sorted array, as soon we get the desired location we 
place it there and then increment the sorted array end marker 'i' by unity.
This process continues until the array unsorted array size is reduced to zero.

### The Show Function

It's quite self-explanatory that it displays the new altered array:

```c++
void show(int arr[], int n)  
{  

    int i;  
    for (i = 0; i < n; i++)  
        cout << arr[i] << " ";  
    cout << endl; 
}
```
It takes the altered array and then prints it by iterating through it.

### The Main Function

As usual, C++ programs cannot be executed without a main function:

```c++
int main()  
{  

    int n;  
    cout<<"Enter the length of the array ";
    cin>>n;
    cout<<endl;
    int arr[n];
    for(int i=0;i<n;i++){
        cin>>arr[i];
    }
  
    insertion_sort(arr, n);   
    
    cout<<endl;
    show(arr,n);
  
    return 0;  
} 
```

Here the first `cout<<"Enter the length of the array "` just asks for an input for the array length, 
which is required for array declaration, since static programs in C++ demand for an invariable length
of the array for contiguous memory allocation in the system's memory, variable-length arrays are possible
with pointers, but they are beyond the scope of 
discussion in this tutorial.

The for loop is responsible for the input into the array.
Here, we make a call to each function we've created: `insertion_sort(arr, n)` and` show(arr,n)`, bypassing
the array and the array length variables to the function such that they match with their respective function signatures. And, that's it!


## How to Run the Solution

One can run the code on C++ IDE's like CodeBlocks, Turboc++, Eclipse for C/C++, etc.
Their installation is guided by the setup wizards and once install can allow you to 
run the locally on your machine, all these IDE's are available free of cost on their
respective websites.

Perhaps the easiest way to run the solution is to leverage the online gdb 
compiler.

Alternatively, you can try to run the C++ code in a similar way described in the last article. Honestly, it’s pretty easy to write and run C/C++ code 
on most platforms:

```console
gcc -o reverse-string reverse-string.cpp
```

Unfortunately, Windows pretty much requires the use of Visual Studios. So, 
instead of sharing platform-specific directions, I’ll fall back on my online compiler recommendation.[^1]


#### References

[^1]: S. Singh, “Insertion Sort in C++,” The Renegade Coder, 09-Oct-2019. [Online]. Available: <https://therenegadecoder.com/code/insertion-sort-in-c-plus-plus/>.
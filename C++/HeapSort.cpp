/**
 * Title     : Heap Sort
**/

#include<iostream>
using namespace std;

void heapify(int arr[], int n, int pos) {

    int leftChildIdx = (2 * pos) + 1;
    int rightChildIdx = (2 * pos) + 2;
    int maxIdx = pos;

    if ((leftChildIdx < n) && (arr[leftChildIdx] > arr[maxIdx]))
        maxIdx = leftChildIdx;
    if ((rightChildIdx < n) && (arr[rightChildIdx] > arr[maxIdx]))
        maxIdx = rightChildIdx;

    if (maxIdx != pos) {
        swap(arr[pos], arr[maxIdx]);
        heapify(arr, n, maxIdx);
    }
}

void heapSort(int arr[], int n) {

    for (int i = n / 2 - 1; i >= 0; --i)
        heapify(arr, n, i);

    for (int i = n - 1; i > 0; --i) {
        swap(arr[0], arr[i]);
        heapify(arr, i, 0);
    }
}

void displayArray(int arr[], int n) {
    cout << "The array elements are - ";
    for (int i = 0; i < n; ++i)
        cout << arr[i] << " ";
    cout << "\n";
}

int main() {

    int n;
    cout << "Enter the size of the array - ";
    cin >> n;

    int arr[n];
    cout << "Enter the " << n << " array elements - ";
    for (int i = 0; i < n; ++i)
        cin >> arr[i];

    cout << "\nBefore sorting\n";
    displayArray(arr, n);

    heapSort(arr, n);

    cout << "\nAfter sorting\n";
    displayArray(arr, n);

    return 0;
}
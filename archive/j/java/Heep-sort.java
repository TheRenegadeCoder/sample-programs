// Java program for implementation of Heap Sort 

import java.io.*; 

class GFG { 
	
	// To heapify a subtree rooted with node i which is 
	// an index in arr[]. n is size of heap 
	static void heapify(int arr[], int n, int i) 
	{ 
		int smallest = i; // Initialize smalles as root 
		int l = 2 * i + 1; // left = 2*i + 1 
		int r = 2 * i + 2; // right = 2*i + 2 

		// If left child is smaller than root 
		if (l < n && arr[l] < arr[smallest]) 
			smallest = l; 

		// If right child is smaller than smallest so far 
		if (r < n && arr[r] < arr[smallest]) 
			smallest = r; 

		// If smallest is not root 
		if (smallest != i) { 
			int temp = arr[i]; 
			arr[i] = arr[smallest]; 
			arr[smallest] = temp; 

			// Recursively heapify the affected sub-tree 
			heapify(arr, n, smallest); 
		} 
	} 

	// main function to do heap sort 
	static void heapSort(int arr[], int n) 
	{ 
		// Build heap (rearrange array) 
		for (int i = n / 2 - 1; i >= 0; i--) 
			heapify(arr, n, i); 

		// One by one extract an element from heap 
		for (int i = n - 1; i >= 0; i--) { 
			
			// Move current root to end 
			int temp = arr[0]; 
			arr[0] = arr[i]; 
			arr[i] = temp; 

			// call max heapify on the reduced heap 
			heapify(arr, i, 0); 
		} 
	} 

	/* A utility function to print array of size n */
	static void printArray(int arr[], int n) 
	{ 
		for (int i = 0; i < n; ++i) 
			System.out.print(arr[i] + " "); 
		System.out.println(); 
	} 

	// Driver program 
	public static void main(String[] args) 
	{ 
		int arr[] = { 4, 6, 3, 2, 9 }; 
		int n = arr.length; 

		heapSort(arr, n); 

		System.out.println("Sorted array is "); 
		printArray(arr, n); 
	} 
} 

// This code is contributed by vt_m. 

import java.io.*;
import java.util.*;
class BinarySearch 
{ 
    // Returns index of x if it is present in arr[l..r], else return -1 
    int binarySearch(int arr[], int l, int r, int x) 
    { 
        if (r>=l) 
        { 
            int mid = l + (r - l)/2; 
   
            if (arr[mid] == x) 
               return mid; 
   
            if (arr[mid] > x) 
               return binarySearch(arr, l, mid-1, x); 
   
            return binarySearch(arr, mid+1, r, x); 
        } 
        // We reach here when element is not present 
        //  in array 
        return -1; 
    } 
    public static void main(String args[]) 
    { 
        Scanner in = new Scanner(System.in);
        BinarySearch ob = new BinarySearch(); 
        System.out.println("Enter number of elements");
        int n = in.nextInt();
        int arr[] = new int[n]; 
        System.out.println("Enter elements");
        for(int i=0;i<n;i++){
            arr[i] = in.nextInt();
        }
        System.out.println("Enter number to be searched"); 
        int x = in.nextInt(); 
        int result = ob.binarySearch(arr,0,n-1,x); 
        if (result == -1) 
            System.out.println("Element not present"); 
        else
            System.out.println("Element found at index " +  
                                                 result); 
    } 
} 
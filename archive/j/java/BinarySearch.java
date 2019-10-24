//Contributed by Jasani Dhruv.
//Binary Search Algo.

import java.util.Scanner;

class BinarySearch{

    public static int binarySearch(int arr[], int find){

        int s = 0, e = arr.length, mid;

        while( s < e ){

            mid = (s+e)/2;	//finding middle element in array.

            if( arr[mid] == find ){
                return mid;
            }
            else if( find < arr[mid] ){		//if the element is less then middle then e<-mid
                e = mid;
            }
            else{
                s = mid+1;
            }
        }

        return -1;
    }

    public static void main(String args[]){

        int n, find, loc;
        Scanner in = new Scanner(System.in);

        System.out.print("Enter the size of array = ");
        n = in.nextInt();

        int arr[] = new int[n];
        System.out.println("Enter " + n + " sorted elements in array :");
        for(int i=0; i<n; i++){
            arr[i] = in.nextInt();
        }

        System.out.print("Enter value to find = ");
        find = in.nextInt();

        loc = binarySearch(arr, find);	//calling the function binarySearch for performing searching task.

        if( loc == -1 ){
            System.out.println("value Not found in array");
        }
        else{
            System.out.println("value found at index " + loc);
        }
    }
}

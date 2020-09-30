import java.util.*;
public class BucketSort 
{
    static int[] sort(int[] nums, int max_value) 
    {
        // Bucket Sort
        int[] Bucket = new int[max_value + 1];
        int[] sorted_nums = new int[nums.length];
         for (int i = 0; i < nums.length; i++)
          Bucket[nums[i]]++;
          int outPos = 0;
         for (int i = 0; i < Bucket.length; i++)
              for (int j = 0; j < Bucket[i]; j++)
                  sorted_nums[outPos++] = i;
          return sorted_nums;
      }
 
    static int max_value(int[] nums) 
    {
        int max_value = 0;
        for (int i = 0; i < nums.length; i++)
            if (nums[i] > max_value)
                max_value = nums[i];
        return max_value;
    } 

    public static void main(String args[])
    {   int size, i;
        Scanner scan = new Scanner(System.in);  
        System.out.print("Enter Array Size : ");  
        size = scan.nextInt();  
        int nums[] = new int[size]; 
        System.out.print("Enter Array Elements : ");  
        for(i=0; i<size; i++)  
       {  
           nums[i] = scan.nextInt();  
       }     
        int max_value = max_value(nums);
        System.out.println("Original Array:");
        System.out.println(Arrays.toString(nums));
        nums = sort(nums, max_value);
        System.out.println("Sorted Array:");
        System.out.println(Arrays.toString(nums));
        }        
}
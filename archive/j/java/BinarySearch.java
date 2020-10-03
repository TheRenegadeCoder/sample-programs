/* Program: Binary Search
 * Input: Number of elements, element's values, value to be searched
 * Output:Position of the number input by user among other numbers*/
class BinarySearch
{
   public static void main(String args[])
   {
      int counter, item, first, last, middle;
      int array[] = {1, 4, 5, 11, 12};
      item = 11;
      first = 0;
      last = array.length - 1;
      middle = (first + last)/2;

      while( first <= last )
      {
         if ( array[middle] < item )
           first = middle + 1;
         else if ( array[middle] == item )
         {
           System.out.println(item + " found at location " + (middle + 1) + ".");
           break;
         }
         else
         {
             last = middle - 1;
         }
         middle = (first + last)/2;
      }
      if ( first > last )
          System.out.println(item + " is not found.\n");
   }
}

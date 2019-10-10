
/**
 *
 * @author nickb82
 */
public class BubbleSortClass 
{
   // How many elements in the array have a number
   int size;
   
   // size + any index in the the array that may be null or empty
   int capacity;
   
   // If capacity is not given by user
   static final int DEFAULT_CAPACITY = 10;
   
   // Array to hold numbers to be sorted
   int[] bubbleArray;
   
   // Default constructor
   BubbleSortClass()
   {
      size = 0;
      capacity = DEFAULT_CAPACITY;
      bubbleArray = new int[capacity];
      
   }
   
   // Set your own capactity
   BubbleSortClass(int setCapacity)
   {
      size = 0;
      capacity = setCapacity;
      bubbleArray = new int[capacity];
   }
   
   // Copy constrcutor
   BubbleSortClass(BubbleSortClass copied)
   {
      size = copied.size;
      capacity = copied.capacity;
      bubbleArray = new int[capacity];
      
      copyArrayData(this.bubbleArray, copied.bubbleArray);
   }
   
   // adds int value to array
   public boolean addInt(int newInt)
   {
      if(size < capacity)
      {
         bubbleArray[size] = newInt;
         size++;
         return true;
      }
      return false;
   }

   // runs bubbleSort by copying from the original array to a copy array
   // Returns the copy array with the changes
   public int[] runBubbleSort()
   {
      // change new int[size] to new int[capacity] to show empty spaces
      int[] copyArr = new int[size];
      
      // copies from original array to a copy array so original is not changed
      copyArrayData(copyArr, bubbleArray);

      int bubbleIndex;
      int stepIndex;
      
      // if original array needs to be changed replace coppyArr with bubbleArray
      // Also return bubbleArray
        for (bubbleIndex = 0; bubbleIndex < size; bubbleIndex++) 
           
            for (stepIndex = 0; stepIndex < size - bubbleIndex - 1; stepIndex++) 
               
                if (copyArr[stepIndex] > copyArr[stepIndex+1]) 
                { 
                   
                   swapValues(copyArr, stepIndex, stepIndex + 1);
                   
                } 
        
        // Change to bubbleArray to see the original array
        return copyArr;
      
   }
   
   // copies from a source array to the a destination array
   private void copyArrayData(int[] dest, int[] source)
   {

      int index;
      
      for(index = 0; index < size; index++)
      {
         dest[index] = source[index];
      }
      
   }
   
   // swap values and makes runBubbleSort() look cleaner
   private void swapValues(int[] bubbleArray,
           int indexOne, int indexOther)
   {
      int temp = bubbleArray[indexOne];
      bubbleArray[indexOne] = bubbleArray[indexOther];
      bubbleArray[indexOther] = temp; 
   }

}

// 
// Sorting Algorithm : Merge Sort Implentation (Recursion)
// Author : Sanjay Siddha Pradeep Kumar
// Connect at : https://twitter.com/sanjaysiddha
// created date : 11 October, 2019



function mergeSort (unsortedArray) {
    // No need to sort the array if the array only has one element or empty
    if (unsortedArray.length <= 1) {
      return unsortedArray;
    }
  
    // In order to divide the array in half, we need to figure out the middle
    const middle = Math.floor(unsortedArray.length / 2);
    // This is where we will be dividing the array into left and right
    const left = unsortedArray.slice(0, middle);
    const right = unsortedArray.slice(middle);
  
    // Using recursion to combine the left and right 
    return merge(
      mergeSort(left), mergeSort(right)
    );
  }
  
  
  
  // Merge the two arrays: left and right
  
  function merge (left, right) {
  
    let resultArray = [], leftIndex = 0, rightIndex = 0;
  
  
  
    // We will concatenate values into the resultArray in order
  
    while (leftIndex < left.length && rightIndex < right.length) {
  
      if (left[leftIndex] < right[rightIndex]) {
  
        resultArray.push(left[leftIndex]);
  
        leftIndex++; // move left array cursor
  
      } else {
  
        resultArray.push(right[rightIndex]);
              rightIndex++; // move right array cursor
      }
    }
 
    // We need to concat to the resultArray because there will be one element left over after the while loop 
    return resultArray
  
            .concat(left.slice(leftIndex))
  
            .concat(right.slice(rightIndex));
  
  }
function BinarySearch(array, low, high, target)
{
  //base condition
  // To exit the recursion, if array is empty or n = 1
  if(low > high) {
    return -1;
  }
  //calculate the midpoint of array
  let mid=Math.floor( (low+ high)/2) ;
  if (target == array[mid]) {
    console.log('Target is found at index: ', mid)
    return mid;
  }
  else if (target < array[mid]) {
  //if the target is less the number at the midpoint of array
  //Search the 2nd half. 
    return BinarySearch(array, low, mid-1, target);
  }
  else {
  //if the target is larger number at the midpoint of array
  //Search the 1st half.
    return BinarySearch(array, mid+1, high, target);
  }
}
// To test:
BinarySearch([1,5,7,8,9,10,15], 0, 6, 5)
// Console:
'Target is found at index:  1'

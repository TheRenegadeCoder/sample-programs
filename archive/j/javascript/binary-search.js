// Binary Search
const binarySearch = (array, searchItem) => {

  let startIndex = 0;
  let endIndex = array.length - 1;

  while(startIndex <= endIndex) {
    let middleIndex = Math.floor((startIndex + endIndex) / 2);

    if(array[middleIndex] === searchItem) {
      return console.log('Item was found at index ' + middleIndex);
    }
    if(searchItem > array[middleIndex]) {
      startIndex = middleIndex + 1;
    }

    if(searchItem < array[middleIndex]) {
      endIndex = middleIndex - 1;
    }
  }
  console.log('Item value not found in array');
}; 


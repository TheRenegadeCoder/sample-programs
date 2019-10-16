const arr = [6, 2, 5, 3, 8, 7, 1, 4]

const quickSort = (arr, start, end) => {
  if(start < end) {
    let pivot = partition(arr, start, end)
    quickSort(arr, start, pivot - 1)
    quickSort(arr, pivot + 1, end)
  } 
}

const partition = (arr, start, end) => { 
  let pivot = end
  let i = start - 1
  let j = start
  while (j < pivot) {
    if (arr[j] > arr[pivot]) {
      j++
    } else {
      i++
      swap(arr, j, i)
      j++
    }
  }
  swap(arr, i + 1, pivot)
  return i + 1
}

const swap = (arr, first, second) => {
  let temp = arr[first]
  arr[first] = arr[second]
  arr[second] = temp
}

quickSort(arr, 0, arr.length - 1)
console.log(arr)
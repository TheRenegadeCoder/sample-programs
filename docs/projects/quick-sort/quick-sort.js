// LANGUAGE : JavaScript
// Author: Sanjay Siddha Pradeep Kumar
// Created Date: 11 October, 2019
// Twitter Account : https://twitter.com/sanjaysiddha

/*
@func: swap
@args: items, leftIndex, rightIndex
@desc: swapping elements in a list/array
*/
function swap(items, leftIndex, rightIndex){
    var temp = items[leftIndex];
    items[leftIndex] = items[rightIndex];
    items[rightIndex] = temp;
}

/*
@func: partition
@args: items, left, right
@desc: partitioning total item in array
*/
function partition(items, left, right) {
    var pivot   = items[Math.floor((right + left) / 2)], //middle element
        i       = left, //left pointer
        j       = right; //right pointer
    while (i <= j) {
        while (items[i] < pivot) {
            i++;
        }
        while (items[j] > pivot) {
            j--;
        }
        if (i <= j) {
            swap(items, i, j); //sawpping two elements
            i++;
            j--;
        }
    }
    return i;
}

/*
@func: quickSort
@args: items, left and right
@desc: returns you the output 
*/
function quickSort(items, left, right) {
    var index;
    if (items.length > 1) {
        index = partition(items, left, right); //index returned from partition
        if (left < index - 1) { //more elements on the left side of the pivot
            quickSort(items, left, index - 1);
        }
        if (index < right) { //more elements on the right side of the pivot
            quickSort(items, index, right);
        }
    }
    return items;
}
var items = [5,3,7,6,2,9];
// first call to quick sort
var sortedArray = quickSort(items, 0, items.length - 1);
console.log(sortedArray); //prints [2,3,5,6,7,9]
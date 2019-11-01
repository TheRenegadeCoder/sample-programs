
import 'bubble-sort.dart';

/**
 *
 * Merge sort Algorithm from introduction to algorithm
 */

quicksort(List lst,int start,int end){
  if(start < end){

    int mid = partition(lst,start,end);
    //How to use recursive calls
    //Divide and conquer
    quicksort(lst, start, mid-1);
    quicksort(lst, mid, end);
  }
}

partition(List lst,int start,int end){
  //Sort the array accordingly to the pivot_element
  var pivot_element = lst[end];
  var start_position = start -1;
  for (var i = start; i < end; i++){
      if(lst[i] <= pivot_element){
        start_position++;
        swap(lst, start_position, i);
      }
  }
  swap(lst, start_position+1, end);
  return start_position+1;
}

swap(List<double> lst, int position, int position2){
  var tmp = lst[position];
  lst[position] = lst[position2];
  lst[position2] = tmp;
}

main(List<String> args){
  try {

  List<double> lst = parseInput(args.join());

  if (lst.length <= 1) exitWithError();
    quicksort(lst, 0, lst.length - 1);
    print(lst);
  }
  catch (e){
      exitWithError();
  }
}

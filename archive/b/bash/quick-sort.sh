#!/bin/bash

# based on https://stackoverflow.com/questions/7442417/how-to-sort-an-array-in-bash

# quicksorts positional arguments
# return is in array qsort_ret
# Note: iterative, NOT recursive! :)
# First argument is a function name that takes two arguments and compares them
qsort_iter() {
   (($#<=1)) && return 0
   local compare_fun=$1
   shift
   local stack=( 0 $(($#-1)) ) beg end i pivot smaller larger
   qsort_ret=("$@")
   while ((${#stack[@]})); do
      beg=${stack[0]}
      end=${stack[1]}
      stack=( "${stack[@]:2}" )
      smaller=() larger=()
      pivot=${qsort_ret[beg]}
      for ((i=beg+1;i<=end;++i)); do
         if "$compare_fun" "${qsort_ret[i]}" "$pivot"; then
            smaller+=( "${qsort_ret[i]}" )
         else
            larger+=( "${qsort_ret[i]}" )
         fi
      done
      qsort_ret=( "${qsort_ret[@]:0:beg}" "${smaller[@]}" "$pivot" "${larger[@]}" "${qsort_ret[@]:end+1}" )
      if ((${#smaller[@]}>=2)); then stack+=( "$beg" "$((beg+${#smaller[@]}-1))" ); fi
      if ((${#larger[@]}>=2)); then stack+=( "$((end-${#larger[@]}+1))" "$end" ); fi
   done
}

# compare function
compare_str() { [[ $1 < $2 ]]; }

ERROR="Usage: please provide a list of at least two integers to sort in the format \"1, 2, 3, 4, 5\""

#Validation to fit criteria
if [ "$#" != "1" ]; then echo $ERROR; exit 1; fi; #wrong input
if [[ ! "$1" =~ "," ]]; then echo $ERROR; exit 1; fi; #wrong format

array=($(echo $@ | tr ", " " "))

if [ "${array[0]}" == "" ]; then echo $ERROR; exit 1; fi; #empty input
if [ "${#array[@]}" == "1" ]; then echo $ERROR; exit 1; fi; #not a list

qsort_iter compare_str "${array[@]}"
arrayString=${qsort_ret[@]}
echo "${arrayString// /, }"

exit 0

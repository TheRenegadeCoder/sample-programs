""" this ia a python code to find the highest summing subarray of a list of numbers
using Kadane's Algorithm"""

def max_subarray(numbers):
    #Find a contiguous subarray with the largest sum.
    best_sum = 0  # or: float('-inf')
    best_start = best_end = 0  # or: None
    current_sum = 0
    for current_end, x in enumerate(numbers):
        if current_sum <= 0:
            # Start a new sequence at the current element
            current_start = current_end
            current_sum = x
        else:
            # Extend the existing sequence with the current element
            current_sum += x

        if current_sum > best_sum:
            best_sum = current_sum
            best_start = current_start
            best_end = current_end + 1  # the +1 is to make 'best_end' exclusive

    return best_sum, best_start, best_end

alist=input('Enter the list of numbers (with spaces between) --> ')
alist=alist.split()
alist=[int(i) for i in alist]
total_sum,start,stop=max_subarray(alist)
print(f'The maximim subarray has sum of {total_sum} \
with start index {start} and end index {stop}')

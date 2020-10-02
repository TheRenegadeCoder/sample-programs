import math


def jumpsearch(arr1, x1, n1):
    # finding block size to be jumped
    # sqrt of n is the optimal jump size concidering all scenarios
    step = math.sqrt(n1)
    print(step)
    # finding the block where the element is present
    # if it is present
    prev = 0
    while arr1[int(min(step, n1) - 1)] < x1:
        prev = step
        step += math.sqrt(n1)
        print(step)
        if prev >= n1:
            return -1
    # doing a linear  search for x in
    # block begining with prev
    while arr1[int(prev)] < x1:
        prev += 1
        print("prev", prev)
        # if we reach the next block or end of array, element is not present
        if prev == min(step, n1):
            return -1
        # if element is found
    if arr1[int(prev)] == x1:
        return prev
    return -1


arr = [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 337, 610]
x = 55
n = len(arr)
index = jumpsearch(arr, x, n)
print("number", x, "is at index", int(index))
# time commplexity=O(sqrt(n))
# space complexity=O(1)

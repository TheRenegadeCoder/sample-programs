import sys

def findMax(arr):
    maxSum = 0
    for i in range(len(arr)):
        val = arr.pop(0)
        arr.append(val)
        sum_ = [ele*j for j,ele in enumerate(arr)]
        sum_ = sum(sum_)
        if sum_ > maxSum:
            maxSum = sum_
    return maxSum

try:
    arr = [int(ele) for ele in sys.argv[1].split(",")]
    print(str(findMax(arr)))

except:
    print("Usage: please provide a list of integers (e.g. “8, 3, 1, 2”)")

    

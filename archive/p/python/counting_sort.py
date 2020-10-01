def counting_sort(arr):
    # The output character array that will have sorted arr
    output = [0 for i in range(len(arr))]

    # Create a count array to store count of inidividul items
    count = [0 for i in range(256)]

    # For storing the resulting answer
    ans = [0 for _ in arr]

    # Store count of each element
    for i in arr:
        count[i] += 1

    # Change count[i] so that count[i] now contains actual
    # position of this element in output array
    for i in range(256):
        count[i] += count[i - 1]

        # Build the output element array
    for i in range(len(arr)):
        output[count[arr[i]] - 1] = arr[i]
        count[arr[i]] -= 1

    # Copy the output array to arr, so that arr now
    # contains sorted elements
    for i in range(len(arr)):
        ans[i] = output[i]
    return ans


# create array and call counting_sort function
arr = [10, 9, 1, 12, 6, 5, 7]
ans = counting_sort(arr)
print("Sorted character array is: " + str(ans))
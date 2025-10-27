# Define a function that takes in an array of numbers
def selection_sort (numbers)
    # Store the given array into a variable
    unsorted_elements = numbers

    # Create a array to store our final sorted array
    sorted_elements = []

    # Loop through all the numbers
    while !unsorted_elements.empty?
        # Find the minimum element in the array
        min_element = unsorted_elements.min

        # Store the index of the minimum elment
        index = unsorted_elements.index(unsorted_elements.min)

        # Add the minimum element to the sorted array at the start
        sorted_elements.push(min_element)

        # Delete the element from the unsorted array
        unsorted_elements.delete_at(index)
    end

    # Return the sorted elements in an array
    return sorted_elements
end

print(selection_sort(ARGV[0]))
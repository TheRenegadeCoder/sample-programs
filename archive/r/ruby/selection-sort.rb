def selection_sort(numbers)
  # Handle missing or invalid input
  if numbers.nil? || numbers.strip.empty?
    return 'Usage: please provide a list of at least two integers to sort in the format "1, 2, 3, 4, 5"'
  end

  # Remove surrounding quotes if present
  numbers = numbers.strip
  numbers = numbers[1..-2] if numbers.start_with?('"') && numbers.end_with?('"')

  # Split into an array and convert to integers
  unsorted_elements = numbers.split(',').map(&:strip).map(&:to_i)

  # Validate array has at least 2 elements
  if unsorted_elements.length < 2
    return 'Usage: please provide a list of at least two integers to sort in the format "1, 2, 3, 4, 5"'
  end

  sorted_elements = []

  # Iterate until the list of unsorted elements is emptu
  until unsorted_elements.empty?
    # Store the minimal value in a variable
    min_element = unsorted_elements.min

    # Add the element at the end of the sorted elements array
    sorted_elements.push(min_element)

    # Delete the minimal value from the unsorted elements array
    unsorted_elements.delete_at(unsorted_elements.index(min_element))
  end

  # Return as comma-separated string
  sorted_elements.join(', ')
end

puts selection_sort(ARGV[0])
def binary_search(array, key)
    left = 0
    right = array.length - 1

    while (left <= right)
        mid = (left + right) / 2

        if (array[mid] == key)
            return "true"
        elsif(array[mid] < key)
            left = mid + 1
        else
            right = mid - 1
        end
    end
    return "false"
end

# Validation of inputs
if ARGV.length != 2 || ARGV[0].empty? || ARGV[1].empty?
    puts 'Usage: please provide a list of sorted integers ("1, 4, 5, 11, 12") and the integer to find ("11")'
else
    array = ARGV[0].split(',').map(&:strip).map(&:to_i)
    key = ARGV[1].to_i
    
    if array != array.sort
        puts 'Usage: please provide a list of sorted integers ("1, 4, 5, 11, 12") and the integer to find ("11")'
    else
        puts binary_search(array, key)
    end
end
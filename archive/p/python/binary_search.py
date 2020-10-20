import sys


def binary_search(array_list, key):
    start = 0
    end = len(array_list)
    while start < end:
        mid = (start + end) // 2
        if array_list[mid] > key:
            end = mid
        elif array_list[mid] < key:
            start = mid + 1
        else:
            return mid
    return -1


def input_list(list_str):
    array_of_numbers = list_str
    array_of_numbers = array_of_numbers.split(",")
    array_of_numbers = [int(x) for x in array_of_numbers]
    return array_of_numbers


def exit_with_error():
    print('Usage: please provide a list of sorted integers ("1, 4, 5, 11, 12") and the integer to find ("11")')
    sys.exit(1)


if __name__ == "__main__":
    try:
        array_of_numbers = sys.argv[1]
        value_to_be_found = int(sys.argv[2])
        array_of_numbers = input_list(array_of_numbers)

        if array_of_numbers != sorted(
                array_of_numbers) or len(array_of_numbers) < 1:
            exit_with_error()
        index = binary_search(array_of_numbers, value_to_be_found)
        if index < 0:
            print(False)
        else:
            print(True)
    except (IndexError, ValueError):
        exit_with_error()

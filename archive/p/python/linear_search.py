import sys

def sysarg_to_list(string):
    return [int(x.strip(" "), 10) for x in string.split(',')]

def linear_search(array, key):
    for item in array:
        if item == key:
            return True
    return False

if len(sys.argv) != 2 or not sys.argv[1]:
    print('Usage: please provide a list of sorted integers ("1, 4, 5, 11, 12") and the integer to find ("11")')
    sys.exit()

key = int(sys.argv[2])
array = sysarg_to_list(sys.argv[1])
size = len(array)

print(linear_search(array, key))

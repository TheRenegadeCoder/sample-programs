import sys

def sysarg_to_list(string):
    return [int(x.strip(" "), 10) for x in string.split(',')]

if(len(sys.argv) != 2):
    print('Usage: please provide a list of sorted integers ("1, 4, 5, 11, 12") and the integer to find ("11")')
    sys.exit()

key = int(sys.argv[2])
array = sysarg_to_list(sys.argv[1])
size = len(array)

flag = 0
pos = -1

for i in range(size):
    if array[i] == key:
        flag = 1
        pos = i
        break

print(flag)

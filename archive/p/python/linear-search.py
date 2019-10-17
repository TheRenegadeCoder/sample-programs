import sys

def sysarg_to_list(string):
    return [int(x.strip(" "), 10) for x in string.split(',')]

if(len(sys.argv) != 2):
    print("Enter two arguments: key and string containing array elements")
    sys.exit()

key = int(sys.argv[1])
array = sysarg_to_list(sys.argv[2])
size = len(array)

flag = 0
pos = -1

for i in range(size):
    if array[i] == key:
        flag = 1
        pos = i
        break

if(flag):
    print(key, "found at position", pos, ".")
else:
    print(key, "not in the array.")

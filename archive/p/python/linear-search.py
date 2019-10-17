size = int(input("Enter the size of array: "))

array = []

for i in range(size):
    inp = int(input("Enter array item " + str(i+1) + ": "))
    array.append(inp)

key = int(input("Enter the key to search: "))

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

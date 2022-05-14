import sys

if len(sys.argv) != 2 or not sys.argv[1]:
    print("Usage: please provide a string")
    sys.exit()

counter = dict()
dupes = False
for char in sys.argv[1]:
    counter.setdefault(char, 0)
    counter[char] += 1
    if counter[char] > 1:
        dupes = True

if dupes:
    for key, value in counter.items():
        if value > 1:
            print(f"{key}: {value}")
else:
    print("No duplicate characters")

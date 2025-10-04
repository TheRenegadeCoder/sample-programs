import sys

error = "Usage: please provide a string"

if len(sys.argv) == 1 or sys.argv[1] == "":
    print(error)
    sys.exit(1)

input_string = sys.argv[1]
print("".join(input_string.split()))

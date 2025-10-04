import sys

error = "Usage: please provide a string"

if len(sys.argv) == 1 or sys.argv[1] == "":
    print(error)
    sys.exit(1)

input_string = sys.argv[1]
longest_word = max(len(word) for word in input_string.split())
print(longest_word)

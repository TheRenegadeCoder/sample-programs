import sys


def palindromic_number(x):
    if x >= 0:
        reversed_number = 0

        noofdigits = 0
        temp = x
        while (temp > 0):
            noofdigits += 1
            reversed_number = (reversed_number * 10) + (temp % 10)
            temp = int(temp/10)

        if x == reversed_number:
            print("true")
        else:
            print("false")
    else:
        print("Usage: please input a non-negative integer")


def main():
    try:
        palindromic_number(int(sys.argv[1]))
    except (IndexError, ValueError):
        print("Usage: please input a non-negative integer")
        sys.exit(1)


if __name__ == "__main__":
    main()

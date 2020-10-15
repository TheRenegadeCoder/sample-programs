import sys


def even_odd(x):
    return "Even" if x % 2 == 0 else "Odd"


def exit_with_error():
    print('Usage: please input a number')
    sys.exit(1)


def main(args):
    try:
        num = int(args[0])
        print(even_odd(num))
    except (IndexError, ValueError):
        exit_with_error()


if __name__ == "__main__":
    main(sys.argv[1:])

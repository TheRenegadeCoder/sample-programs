import sys
from itertools import takewhile


def insertion_sort(xs):
    new_xs = []
    for x in xs:
        new_xs = insert(x, new_xs)
    return new_xs


def insert(x, xs):
    left = list(takewhile(lambda i: i < x, xs))
    right = xs[len(left):]
    return left + [x] + right


def input_list(list_str):
    return [int(x.strip(" "), 10) for x in list_str.split(',')]


def exit_with_error():
    print('Usage: please provide a list of at least two integers to sort in the format "1, 2, 3, 4, 5"')
    sys.exit(1)


def main(args):
    try:
        xs = input_list(args[0])
        if len(xs) <= 1:
            exit_with_error()
        print(insertion_sort(xs))
    except (IndexError, ValueError):
        exit_with_error()


if __name__ == "__main__":
    main(sys.argv[1:])

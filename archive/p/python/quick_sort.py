import sys


def quick_sort(xs):
    if len(xs) <= 0:
        return []

    left = quick_sort([l for l in xs[1:] if l <= xs[0]])
    right = quick_sort([r for r in xs[1:] if r > xs[0]])
    return left + xs[:1] + right


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
        print(quick_sort(xs))
    except (IndexError, ValueError):
        exit_with_error()


if __name__ == "__main__":
    main(sys.argv[1:])

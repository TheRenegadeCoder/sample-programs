import sys


def selection_sort(xs, sorted_xs=None):
    sorted_xs = sorted_xs or []
    if len(xs) <= 0:
        return sorted_xs
    x = min(xs)
    sorted_xs.append(x)
    xs.remove(x)
    return selection_sort(xs, sorted_xs)


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
        print(selection_sort(xs))
    except (IndexError, ValueError):
        exit_with_error()


if __name__ == "__main__":
    main(sys.argv[1:])

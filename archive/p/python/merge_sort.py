import sys


def merge_sort(xs):
    def sort(xs):
        if len(xs) <= 0:
            return []
        if len(xs) == 1:
            return xs
        return sort([merge(xs[0], xs[1])] + sort(xs[2:]))
    split_xs = [[x] for x in xs]
    return sort(split_xs)[0]


def merge(xs, ys):
    if len(xs) <= 0:
        return ys
    if len(ys) <= 0:
        return xs
    if xs[0] < ys[0]:
        return [xs[0]] + merge(xs[1:], ys)
    return [ys[0]] + merge(xs, ys[1:])


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
        print(merge_sort(xs))
    except (IndexError, ValueError):
        exit_with_error()


if __name__ == "__main__":
    main(sys.argv[1:])

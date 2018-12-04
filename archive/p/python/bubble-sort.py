#!/usr/bin/env python
import sys
import argparse
from functools import reduce


def bubble_sort(xs):
    def pass_list(xs):
        if len(xs) <= 1:
            return xs
        x0 = xs[0]
        x1 = xs[1]
        if x1 < x0:
            del xs[1]
            return [x1] + pass_list(xs)
        return [x0] + pass_list(xs[1:])
    return reduce(lambda acc, _ : pass_list(acc), xs, xs[:])


def input_list(list_str):
    return [int(x.strip(" "), 10) for x in list_str.split(',')]


if __name__ == "__main__":
    usage = 'Usage: please provide a list of at least two integers to sort in the format “1, 2, 3, 4, 5”'
    parser = argparse.ArgumentParser(usage=usage)
    parser.add_argument('list', type=input_list)
    args = parser.parse_args()
    if len(args.list) <= 1:
        print(usage)
        sys.exit(1)

    print(bubble_sort(args.list))

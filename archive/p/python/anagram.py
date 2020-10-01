#!/usr/bin/env python
import sys


def anagram(str1, str2):
    str1 = str1.replace(" ", "").lower()
    str2 = str2.replace(" ", "").lower()
    # Edge case check
    if len(str1) != len(str2):
        return False

    count = {}

    for letter in str1:
        if letter in count:
            count[letter] += 1
        else:
            count[letter] = 1

    for letter in str2:
        if letter in count:
            count[letter] -= 1
        else:
            count[letter] = 1

    for k in count:
        if count[k] != 0:
            return False

    return True


def input_list(list_str):
    return [x for x in list_str.split(',')][:2]


def exit_with_error():
    print('Usage: please provide two strings in the format "first_string,secondString"')
    sys.exit(1)


def main(args):
    try:
        str1, str2 = input_list(args[0])
        print(anagram(str1, str2))
    except (IndexError,ValueError):
        exit_with_error()


if __name__ == "__main__":
    main(sys.argv[1:])

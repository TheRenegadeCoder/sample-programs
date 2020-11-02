import sys


def input_list(list_str):
    return [int(x.strip(" "), 10) for x in list_str.split(',')]


def longest(s1, s2):
    return s1 if len(s1) > len(s2) else s2


def lcs(s1, s2):
    if len(s1) == 0 or len(s2) == 0:
        return []
    elif s1[-1] == s2[-1]:
        return lcs(s1[:-1], s2[:-1]) + [s1[-1]]
    elif s1[-1] != s2[-1]:
        return longest(lcs(s1, s2[:-1]), lcs(s1[:-1], s2))


def exit_with_error():
    print('Usage: please provide two lists in the format "1, 2, 3, 4, 5"')
    sys.exit(1)


def main(args):
    try:
        lst1 = input_list(args[0])
        lst2 = input_list(args[1])
        print(lcs(lst1, lst2))
    except (IndexError, ValueError):
        exit_with_error()


if __name__ == "__main__":
    main(sys.argv[1:])

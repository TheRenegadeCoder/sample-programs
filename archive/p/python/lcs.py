#!/usr/bin/env python

import argparse

def input_list(list_str):

    return [int(x.strip(" "), 10) for x in list_str.split(',')]

def longest(s1, s2):
    return s1 if len(s1) > len(s2) else s2

def lcs(s1, s2):

    if (len(s1) == 0 or len(s2) == 0): return []
    elif (s1[-1] == s2[-1]): return lcs(s1[:-1], s2[:-1]) + [s1[-1]]
    elif (s1[-1] != s2[-1]): return longest(lcs(s1, s2[:-1]), lcs(s1[:-1], s2))
    else: pass

if __name__ == "__main__":
    
    parser = argparse.ArgumentParser()

    parser.add_argument('A', type=input_list)
    parser.add_argument('B', type=input_list)

    args = parser.parse_args()

    print(lcs(args.A, args.B))

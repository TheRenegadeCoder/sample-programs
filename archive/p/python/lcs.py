#!/usr/bin/env python2

def longest(s1, s2):
    return s1 if len(s1) > len(s2) else s2

def lcs(s1, s2):

    if (len(s1) == 0 or len(s2) == 0): return ""
    elif (s1[-1] == s2[-1]): return lcs(s1[:-1], s2[:-1]) + s1[-1]
    elif (s1[-1] != s2[-1]): return longest(lcs(s1, s2[:-1]), lcs(s1[:-1], s2))
    else: pass

if __name__ == "__main__":
    
    string1 = "ABBBACAB"
    string2 = "AACC"

    print lcs(string1, string2)

---
title: Longest Palindromic Substring in Every Language
layout: default
date: 2019-10-08
last-modified: 2018-10-09
featured-image:
tags: [longest-palindrome-substring]
authors: 
  - Sayantan Paul
---

Given a string, we need to find the smallest substring inside the main string which is a palindrome.

## Description

Palindrome is a phenomenon, where a string has same sequence of letters when read start --> end and end --> start.

Let's say we have a string,

```
s = 'paapaapap'
```

Here, we have seven palindromic substrings. 

```
sub_1 = 'aa'
sub_2 = 'paap'
sub_3 = 'paapaap'
sub_4 = 'aapaa'
sub_5 = 'apap'
sub_6 = 'pap'
sub_7 = 'apaapa'
```

Out of the seven,  `sub_3 = 'paapaap'` is the longest. hence the output would be `'paapaap'`

## Requirements

This problem can be solved using 3 methods.

### Method 1 ( Brute Force )

The simple approach is to check each substring whether the substring is a palindrome or not. We can run three loops, the outer two loops pick all substrings one by one by fixing the corner characters, the inner loop checks whether the picked substring is palindrome or not.

- Time complexity: O (n<sup>3</sup>)
- Auxiliary complexity: O (1)

### Method 2 ( Dynamic Programming )

The time complexity can be reduced by storing results of subproblems. We maintain a boolean table[n][n] that is filled in bottom up manner. The value of table[i][j] is true, if the substring is palindrome, otherwise false. To calculate table[i][j], we first check the value of table[i+1][j-1], if the value is true and str[i] is same as str[j], then we make table[i][j] true. Otherwise, the value of table[i][j] is made false.
- Time complexity: O ( n^2 )
- Auxiliary Space: O ( n^2 ) 

### Method 3

The time complexity of the Dynamic Programming based solution is O(n<sup>2</sup>) and it requires O(n<sup>2</sup>) extra space. We can find the longest palindrome substring in (n<sup>2</sup>) time with O(1) extra space. The idea is to generate all even length and odd length palindromes and keep track of the longest palindrome seen so far.

#### Step to generate odd length palindrome:

Fix a centre and expand in both directions for longer palindromes.

#### Step to generate even length palindrome

Fix two centre ( low and high ) and expand in both directions for longer palindromes.
- Time complexity: O (n<sup>2</sup>) where n is the length of input string.
- Auxiliary Space: O ( 1 )

## Testing

The following table contains various test cases that you can use to verify the correctness of your solution:

| Description | Input | Output |
|-------------|-------|--------|
| No Input    |       |"Incorrect input provided. Program Terminated"|
|Empty String|""|"Incorrect input provided. Program Terminated"|
|Non-Palindromic string with initial capital letters|"Polip"|"No Palindromic substring present."|
|Palindromic string with disordered casing|"BoOroO"|"No Palindromic substring present."|
|Palindromic string with letters and numerics|"6eie6o6"|"Longest Palindromic Substring is: 6eie6"|

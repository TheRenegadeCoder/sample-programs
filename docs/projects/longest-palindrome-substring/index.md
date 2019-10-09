---
title: Longest Palindromic Substring in Every Language
layout: default
date: 2019-10-08
last-modified: 2018-10-09
featured-image:
tags: [longest-palindrome-substring]
authors: Sayantan Paul(https://github.com/belikesayantan)
---
Given a string, we need to find the smallest substring inside the main string which is a palindrome.
Palindrome is a phenomenon, where a string has same sequence of letters when read start --> end and end --> start.

## Example

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

## Testing

The following table contains various test cases that you can use to verify the correctness of your solution:

| Description | Input | Output |
|-------------|-------|--------|
| No Input    |       |"Incorrect input provided. Program Terminated"|
|Empty String|""|"Incorrect input provided. Program Terminated"|
|Non-Palindromic string with initial capital letters|"Polip"|"No Palindromic substring present."|
|Palindromic string with disordered casing|"BoOroO"|"No Palindromic substring present."|
|Palindromic string with letters and numerics|"6eie6o6"|"Longest Palindromic Substring is: 6eie6"|

---
title: ROT-13 in Every Language
layout: default
date: 2018-11-20
last-modified: 2018-11-20
featured-image:
tags: [rot-13]
authors:
  - auroq
---

ROT-13 is a letter substitution cipher where every letter is replaced by the
letter 13 letters after it alphabetically and wrapping from `Z` to `A` if necessary:

    ABCDEFGHIJKLMNOPQRSTUVWXYZ -> NOPQRSTUVWXYZABCDEFGHIJKLM

As a result, encrypted strings can be decrypted using the same algorithm:

    NOPQRSTUVWXYZABCDEFGHIJKLM -> ABCDEFGHIJKLMNOPQRSTUVWXYZ

## Requirements

Write a sample program that takes a string of text as input.
It should then encrypt the inputted text using ROT-13 and output the result to the console.

```console
$ ./rot-13.lang "the quick brown fox jumped over the lazy dog"
gur dhvpx oebja sbk whzcrq bire gur ynml qbt
```

The solution should handle both lower case and capital letters

```console
$ ./rot-13.lang "THE QUICK BROWN FOX JUMPED OVER THE LAZY DOG"
GUR DHVPX OEBJA SBK WHZCRQ BIRE GUR YNML QBT
```

Any characters/symbols besides a-z and A-Z should be ignored.

```console
$ ./rot-13.lang "The quick brown fox jumped. Was it over the lazy dog?"
Gur dhvpx oebja sbk whzcrq. Jnf vg bire gur ynml qbt?
```

In addition, there should be some error handling for situations where the user
doesn't supply any input.

## Testing

The following table contains various test cases that you can use to
verify the correctness of your solution:

| Description  | Input | Output |
|--------------|-------|--------|
| No Input     | | "Usage: please provide a string to encrypt" |
| Empty Input  | "" | "Usage: please provide a string to encrypt" |
| Sample Input: Lower Case | the quick brown fox jumped over the lazy dog | gur dhvpx oebja sbk whzcrq bire gur ynml qbt |
| Sample Input: Upper Case | THE QUICK BROWN FOX JUMPED OVER THE LAZY DOG | GUR DHVPX OEBJA SBK WHZCRQ BIRE GUR YNML QBT |
| Sample Input: Punctuation | The quick brown fox jumped. Was it over the lazy dog? | Gur dhvpx oebja sbk whzcrq. Jnf vg bire gur ynml qbt? |

## Articles

{% include article_list.md collection=site.categories.rot-13 %}

## Further Readings

- [ROT-13 on Wikipedia][1]

[1]: https://en.wikipedia.org/wiki/ROT13

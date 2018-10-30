---
title: Reverse a String in Every Language
layout: default
---

# Reverse a String

While Hello World is simple, it often does not show off many interesting
features of a language. Fortunately, this repository shares more samples than
Hello World. One of these more complex programs is known as Reverse a String.

In this repository, the algorithm must reverse ASCII strings. Do **NOT**
worry about reversing a string in the general case. For instance, if a string
contains surrogate pairs, it's okay if the solution corrupts the string during reversal.

## Requirements

Despite the explicit name, there are some rules in place for consistency.
When writing a Reverse a String program, the following rules should apply:

1.  The implementation must be executable
2.  The string to be reversed must come from the command line
3.  The program must verify the strings existence on the command line
4.  The user must not import libraries to obfuscate the string manipulation

In other words, the program should get a string from the command line and
reverse it using language utilities only. Acceptable language utilities include
language features and built-in libraries.

External dependencies are unacceptable. Remember, the goal is to show off language
features and utilities.

## Testing

If the solution passes these test cases, then it's a good fit for the repo.
Feel free to test other strings for fun. For instance, you may find that
your language can handle unicode characters, but it fails for emojis.

| Description  |      Input     |     Output     |
| ------------ | :------------: | :------------: |
| No Input     |                |                |
| Empty String |       ""       |                |
| Ascii String | "Hello, World" | "dlroW ,olleH" |

## Further Reading

-   [Reverse a String in Every Language by The Renegade Coder][1]

[1]: https://therenegadecoder.com/series/reverse-a-string-in-every-language/

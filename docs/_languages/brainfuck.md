---
title: Brainfuck
layout: default
---

## The Brainfuck Programming Language<sup>1</sup>

[According to Wikipedia][1], Brainfuck is an esoteric programming language created in
1992, and notable for its extreme minimalism. As people have implemented more and
more ridiculous programs with the language, it has become relatively well-known
over the years. Nowadays some see it as the ultimate coding challenge to create
something useful in Brainfuck.

At the core of the language is a more-than-compact instruction set, comprising
of a whopping eight instructions. Brainfuck uses a machine model consisting of
an infinite list of one-byte cells, an instruction pointer, and a cell pointer.
The instructions can be used to interact with this environment: `<` and `>`
move the cell pointer, `+` and `-` increment or decrement the value of the cell
at the current pointer, and `[` and `]` denote a loop.

A loop only starts when the value of the current cell is non-zero, otherwise
execution jumps to the end of the loop. Likewise, a loop ends when the value is
zero, otherwise the program jumps to the beginning of the loop. The remaining
two instructions, `,` and `.` read one character from the input into the current
cell and write one character from the current cell to the output, respectively.
That’s it!

---

#### References

1.

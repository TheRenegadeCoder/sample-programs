---
title: Hello World in Brainfuck
layout: default
last-modified: 2020-05-02
featured-image: hello-world-in-brainfuck-featured-image.JPEG
tags: [brainfuck, hello-world]
authors:
  - chrboe
---

Welcome to Hello World in Brainfuck, a classic program in an esoteric programming language.

## How to Implement the Solution

Let’s take a look at the Hello World sample:

```brainfuck
>++++++++[<+++++++++>-]<.>++++[<+++++++>-]<+.+++++++..+++.>>++++++[<+++++++>-]<+
+.------------.>++++++[<+++++++++>-]<+.<.+++.------.--------.>>>++++[<++++++++>-
]<+.
```

If you’re unfamiliar with Brainfuck, this might not really look like a
“Hello World” example to you. It might even look a little intimidating.
Granted, the syntax might not be the most verbose, but fear not! I’m sure it
will start making sense once we break it down.

For starters, let’s reindent it a little bit:

```brainfuck
>++++++++[<+++++++++>-]<.
>++++[<+++++++>-]<+.
+++++++..
+++.
>>++++++[<+++++++>-]<++.
------------.
>++++++[<+++++++++>-]<+.
<.
+++.
------.
--------.
>>>++++[<++++++++>-]<+.
```

Well, that’s already looking slightly better. Remember, the . operator writes
the current cell value to the output, so we’ve inserted a line break for every
character that gets printed.

Let’s look at it line by line:

```brainfuck
>++++++++[<+++++++++>-]<.
We can see that we immediately move one cell to the right and increment that
cell’s value eight times. This gives us—you guessed it—the value 8 in cell 1.
```

Then we start a loop, in which we move left (back to cell 0), add nine to that
cell, move right again, and subtract one from the value of cell 1. Remember that
the loop runs until the cell value is zero, so this would run 8 times, adding 9
to cell 0 every time. So we can already see that the value of cell 0 at this
point is 72, which corresponds to the uppercase letter ‘H’ in the [ASCII table][2].

So, we got our first character printed. Let’s look at the second line:

```brainfuck
>++++[<+++++++>-]<+.
```

You might immediately notice that this line looks quite similar to the last one.
That might be because it does pretty much exactly the same thing. The only
difference is in the numbers. It adds the value 28 (4 times 7) to cell 0,
and then adds one more at the end of the loop, giving us a value of 101, or
a lowercase ‘e’.

This is basically how the entire program works. It’s just a matter of choosing
the right path in order to get from one value to the next by only using simple
addition, subtraction, and loops.

## How to Run the Solution

There are plenty of Brainfuck interpreters (and even compilers!) available,
online or offline:

- [Copy.sh][3]
- [Sange.fi][4]
- [Dcode.fr][5]

As a starting point, [here’s this example on “Brainfuck Visualizer”][6], an online
tool that displays each step of a Brainfuck program’s execution.

## Further Reading

- [Hello World in Brainfuck][7] on The Renegade Coder

[2]: http://www.asciitable.com/index/asciifull.gif
[3]: https://copy.sh/brainfuck/
[4]: https://sange.fi/esoteric/brainfuck/impl/interp/i.html
[5]: https://www.dcode.fr/brainfuck-language
[6]: http://bf.jamesliu.info/
[7]: https://therenegadecoder.com/code/hello-world-in-brainfuck/

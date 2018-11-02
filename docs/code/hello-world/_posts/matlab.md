---
title: Hello World in MATLAB
layout: default
date: 2018-11-01
last-modified: 2018-11-02
featured-image: hello-world-in-matlab-featured-image.JPEG
tags: [matlab, hello-world]
author:
  - virtual_flat
---

Syntax in MATLAB is based on its MATLAB scripting language. At any rate, here
is what we are working with:

```matlab
fprintf("Hello, World!")
```

One line is all it takes! The “details-hidden” nature of the languages removes
the need to declare variables or classes before the fun begins. `fprintf` is the
command in MATLAB that formats data and displays it in the command window. In
this case, the data is the string “Hello, World!” (denoted by the
quotations).<sup>1</sup>

## How to Run the Solution<sup>1</sup>

Running our program is a relatively simple affair. First, the script must be
saved [using the MATLAB editor][1]. File > Save or CNTL+S will do the trick, and it
will generate a file with the extension \*.m (yep, only one character). After
that, hit run and watch as our polite greeting to our surroundings populates
the screen.

If you want to try this out yourself, you can get a 30 day free trial of MATLAB
R2018a (the most recent release at the time of this writing), download the .m
file and run the script! Note, if you are a university student, your school may
have licenses of MATLAB available to you.

Alternatively, you can try to use [Octave Online][2], an open-source alternative to
MATLAB. [According to its wiki page][3], Octave is mostly compatible with MATLAB.
In fact, our solution to Hello World in MATLAB works great.

---

#### References

1. R. Maldonado, “Hello World in MATLAB,” The Renegade Coder, 04-Sep-2018.
  [Online]. Available: <https://therenegadecoder.com/code/hello-world-in-matlab/>.
  [Accessed: 31-Oct-2018].

[1]: https://www.mathworks.com/products/matlab.html
[2]: https://octave-online.net/
[3]: https://en.wikipedia.org/wiki/GNU_Octave
[4]: https://github.com/TheRenegadeCoder/sample-programs

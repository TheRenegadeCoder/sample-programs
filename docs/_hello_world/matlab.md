---
title: Hello World in Matlab
layout: default
---

![Hello World in MATLAB Featured Image][5]

Once again, we have another installment of Hello World in Every Language.
This time, it’s brought to us by one of my closest friends, Robert (a.k.a. VirtualFlat),
who specializes in 3D CAD using SOLIDWORKS. Today, they’ve brought us Hello World in
MATLAB, one of their favorite engineering programming languages.

## MATLAB Background

MATLAB (short for MATrix LABoratory) is a high-level programming language initially
released in 1984. It markets itself as an easy-to-pick-up tool for scientists,
engineers, and economists to do some serious number crunching.

The development of MATLAB started in the 1970’s when a computer science professor,
Cleve Moler, developed the language, so his students could use snippets of code
for solving linear systems and obtaining eigenvalues/eigenvectors (LINPACK and
EISPACK respectively) without having to learn Fortran. Moler’s creation was
immediately popular for its ease-of-use, interactivity and expandability and
sports over 3 million users world-wide.

## Hello World in MATLAB

Syntax in MATLAB is based on its MATLAB scripting language. At any rate, here
is what we are working with:

```matlab
fprintf("Hello, World!")
```

One line is all it takes! The “details-hidden” nature of the languages removes
the need to declare variables or classes before the fun begins. `fprintf` is the
command in MATLAB that formats data and displays it in the command window. In
this case, the data is the string “Hello, World!” (denoted by the quotations).

## How to Run the Solution

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

## Sample Programs in Every Language

If you enjoyed this and would like to see “Hello, World!” in other languages,
check out the collections of articles on just that. Share this article and others
on here to continue our education, and if there is a language that needs to be
added that you specialize in, go check out the [Sample Programs][4] repository and
make an entry! Thank you for following along!

[1]: https://www.mathworks.com/products/matlab.html
[2]: https://octave-online.net/
[3]: https://en.wikipedia.org/wiki/GNU_Octave
[4]: https://github.com/TheRenegadeCoder/sample-programs
[5]: {{site.baseurl}}/assets/hello-world-in-matlab-featured-image.JPEG

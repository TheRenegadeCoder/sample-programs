---
title: Hello World in C++
layout: default
last-modified: 2019-02-06
featured-image: hello-world-in-c-plus-plus-featured-image.JPEG
tags: [c-plus-plus, hello-world]
authors:
  - the_renegade_coder
---

In this article, we'll be covering Hello World in C++.

## How to Implement the Solution

Even though C++ was built on C, the implementation of Hello World in 
C++ is slightly different:

```c++
#include 
using namespace std;
int main()
{
  cout << "Hello, World!";
  return 0;
}
```

It appears this implementation of Hello World may be competing with 
Java for hardest to learn. But at any rate, let’s break it down.

Once again, the first line is an include statement. Here, we’re including 
the IO stream code in our solution. This is how we gain access to the 
IO objects like cout.

Next, we gain access to the std namespace which basically allows us to 
shorten std::cout to cout. It’s really just a style thing that eliminates 
a lot of verbosity that you might get with other languages like Java. 
Of course, if another namespace also has a cout, we’ll run into problems.

After that, we make a main method as usual. This is exactly the same as 
C, so I won’t bother explaining the return type bit again.

Finally, we write our string to the cout stream. The syntax is a bit 
strange, but basically we can imagine that the Hello World string is 
inserted into the cout stream. In fact, the double-arrow operator is 
the insertion operator, and it has some fun properties. For instance, 
the operator can be chained together, but that’s a topic for another time.

## How to Run the Solution

Perhaps the easiest way to run the solution is to leverage the online gdb 
compiler.

Alternatively, you can try to run the C++ code in a similar way described 
in the last article. Honestly, it’s pretty easy to write and run C/C++ code 
on most platforms:

```console
gcc -o reverse-string reverse-string.cpp
```

Unfortunately, Windows pretty much requires the use of Visual Studios. So, 
instead of sharing platform specific directions, I’ll fallback on my online 
compiler recommendation. Let me know if you have questions otherwise in the 
comments.

---

#### References

[^1]: J. Grifski, “Hello World in C++,” The Renegade Coder, 19-Mar-2018. [Online]. Available: <https://therenegadecoder.com/code/hello-world-in-c-plus-plus/>. [Accessed: 07-Feb-2019].

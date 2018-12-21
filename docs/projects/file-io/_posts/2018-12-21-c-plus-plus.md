---
title: File IO in C++
layout: default
last-modified: 2018-12-21
featured-image:
tags: [c-plus-plus, file-io]
authors:
  - noah11012
---

## How to Implement the Solution

Let's first take a look at the solution. Then, we'll walk through each line of
code:

```c++
#include <iostream>
#include <fstream>
#include <string>

void write_file()
{
    std::fstream out("file.txt", std::ios::out);

    if(!out.is_open())
    {
        std::cout << "Error opening file!\n";
        return;
    }

    out << "This text will be written to the file!\n";
    out << "This line also will be written!\n";

    out.flush();
    out.close();
}

void read_function()
{
    std::fstream in("file.txt", std::ios::in);

    if(!in.is_open())
    {
        std::cout << "Could not open file for reading!\n";
        return;
    }

    std::string line;
    while(std::getline(in, line))
    {
        std::cout << line << "\n";
    }

    in.close();
}

int main()
{
    write_file();
    read_file();
}
```

In less than 50 lines, we have our solution!

### Includes

In our sample, we include three different standard library utilities:

```c++
#include <iostream>
#include <fstream>
#include <string>
```

Here, we can see that we include he standard I/O for printing messages onto the
screen, the standard file I/O for accessing files, and the C++ string library
for storing each line in the file.

### Writing to a File

From there, we defined the `write_file()` function which we'll use to write some
arbitrary text to a file:

```c++
void write_file()
{
    std::fstream out("file.txt", std::ios::out);

    if(!out.is_open())
    {
        std::cout << "Error opening file!\n";
        return;
    }

    out << "This text will be written to the file!\n";
    out << "This line also will be written!\n";

    out.flush();
    out.close();
}
```

Inside this function, we begin by creating a `std::fstream` object called out:

```c++
std::fstream out("file.txt", std::ios::out);
```

One of the constructors in `std::fstream` takes a C-style string for the first
argument and something called a "mode". A mode in this context refers to how the
file will be opened. Will the file be opened for reading, writing, or even both?
Will reading/writing begin at the beginning of the file or the end?

In this constructor, the second argument defaults to both reading and writing.
We just want write abilities so we use `std::ios::out`. You can mix and match
different modes together with the bitwise operator `|` (OR).

Example: `std::fstream out_and_append("file.txt", std::ios::out | std::ios::app);`

Of course, there are other modes available which we can find in DevDocs C++ File
I/O documentation. At any rate, let's get back to the code:

```c++
if(!out.is_open())
{
    std::cout << "Error opening file!\n";
    return;
}
```

These five lines of code are basic error checking to make sure the file is
actually opened. Then, we push a couple of strings to our output file stream:

```c++
out << "This text will be written to the file!\n";
out << "This line also will be written!\n";
```

Using a file stream in C++ is the same as using the standard output. However,
we'll need to make sure to do a few things before we're done:

```c++
out.flush();
out.close();
```

Before the function returns, we do a couple of maintenance related tasks. First,
we flush the buffer. Sometimes the function (or in our case, an operator) that
we call to write to the file doesn't immediately write them to disk. It may
still be in memory waiting to be written to the file. We call the method flush
to make sure everything in memory is written to disk.

Next, we close the file. This frees up resources that we are done using. It's a
good idea to always close a file when done. After all, if enough files are open,
the OS might complain and not allow us to open another file until some other
files have been closed. This is called the file descriptor limit and not closing
files and opening new ones over time can exhaust the number of file descriptors
available.

### Reading from a File

After we've implemented file writing, we can implement file reading:

```c++
void read_function()
{
    std::fstream in("file.txt", std::ios::in);

    if(!in.is_open())
    {
        std::cout << "Could not open file for reading!\n";
        return;
    }

    std::string line;
    while(std::getline(in, line))
    {
        std::cout << line << "\n";
    }

    in.close();
}
```

Just like last time, we open the same file. However, this time we're opening it
for reading purposes. Then, we make sure the file is opened. If it isn't, we
print a message to the screen and return:

std::fstream in("file.txt", std::ios::in);

if(!in.is_open())
{
    std::cout << "Could not open file for reading!\n";
    return;
}
After that, we can begin reading:

std::string line;
while(std::getline(in, line))
{
    std::cout << line << "\n";
}
To start, we create an empty std::string and loop line by line in the file until
we reach EOF (end of file). std::getline takes a reference to a 
std::basic_istream which std::fstream inherits from. The second argument is a
reference to a std::string. It returns a reference to a std::basic_istream.

std::basic_istream inherits from std::basic_ios which overloads the bool 
operator. This means we can use std::getline (or more precisely,
  std::basic_istream ) in boolean contexts such as while conditionals.

When we're done, we close the file and don't call flush because we just read
from the file and haven't written anything to it:

in.close();
And, that's how we read from a file in C++.

The Main Function
As usual, C++ programs cannot be executed without a main function:

int main()
{
    write_file();
    read_file();
}
Here, we make a call to each function we've created: write_file() and
read_file(). And, that's it!

## How to Run Solution

There are many online compilers such as Compiler Explorer that you can use to
compile C++ code. If you have a compiler installed on your system such g++ or
clang++ use the following commands:

g++ -o program file.cpp
clang++ -o program file.cpp
And, that's it! You've successfully executed the solution.

---

#### References

[^1]: N. Nichols, “File IO in C++,” The Renegade Coder, 29-Oct-2018. [Online]. Available: <https://therenegadecoder.com/code/file-io-in-c-plus-plus/>. [Accessed: 21-Dec-2018].

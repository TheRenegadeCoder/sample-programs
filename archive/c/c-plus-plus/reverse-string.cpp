//C++ program to reverse a string
//How to Implement the Solution
//Let’s first take a look at the solution. Then, we’ll walk through each line of code:


#include <iostream>
#include <string>
#include <algorithm>


int main(int argc, char *argv[])
{
    if(argc < 2)
        return 0;
    std::string s = argv[1];
    std::reverse(s.begin(), s.end());
    std::cout << s << "\n";
}


/*
DECLARING HEADER FILES:
Header file  iostream stands for standard input-output stream. This header file contains definitions to objects like cin, cout etc.
These two are the most basic methods of taking input and printing output in C++. To use cin and cout in C++ one must include the header file iostream in the program.
include<string> for string class.(A string is a class which defines objects that be represented as stream of characters.).
The header <algorithm> defines a collection of functions especially designed to be used on ranges of element that can be accessed through pointer or iterator.
The algorithm library has several built-in functions that provide a variety of functionalities
 (e.g., sorting, searching, counting, modifying, and non-modifying sequence operations)*/

//THE MAIN FUNCTION:
/*argv and argc are how command line arguments are passed to main() in C++.

argc (argument Count) is int and stores number of command-line arguments passed by the user including the name of the program. So if we pass a value to a program, value of argc would be 2 (one for argument and one for program name)
argv(argument Vector) is array of character pointers listing all the arguments.

Coming to if block The program itself is the first argument, argv[0], so argc is always at least 1.
simply if (argc < 2) i.e. if no arguments are passed then control will get out of main function.

In next line argv[0] holds the name of the program .Hence,argv[1]will hold string that will get assigned to variable  s.

reverse() is a predefined function in header file algorithm. It reverses the order of the elements in the range [first, last) of any container.
hence ,here our string will get reversed.

last line is pretty simple, which prints reversed string on new line.*/


//How to Run the Solution:
/*One can run the code on C++ IDE’s like CodeBlocks, Turboc++, Eclipse for C/C++, etc.
 Their installation is guided by the setup wizards and once install can allow you to run the locally on your machine,all these IDE’s are available free of cost on their respective websites.
easiest way to run the solution is to leverage the online gdb compiler.
Alternatively, you can try to run the C++ code as:
                            gcc -o reverse-string reverse-string.cpp
*/

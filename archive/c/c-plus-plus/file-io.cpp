#include <iostream>
#include <fstream>
#include <string>

void write_file()
{

    /*
        Creates an object for file outputting.

        The second argument can be changed and mixed and matched with other
        modes.

        List of modes:

        std::ios::app	    seek to the end of stream before each write
        std::ios::binary	open in binary mode
        std::ios::in	    open for reading
        std::ios::out	    open for writing
        std::ios::trunc	    discard the contents of the stream when opening
        std::ios::ate	    seek to the end of stream immediately after open

        Use the bitwise operator OR to add additional flags

        Example:

        std::fstream out("output.txt", std::ios::out | std::ios::app);

        The second argument is defaulted to std::ios::in | std::ios::in.

        We only want write abilities so we do std::ios::out.
    */
    std::fstream out("output.txt", std::ios::out);

    /*
        Good practice to make sure the variable 'out' has an associated file.
    */
    if(!out.is_open())
    {
        std::cout << "Could not open file!\n";
        return;
    }

    /*
        Just like using the standard output in C++.
    */
    out << "A line of text\n";
    out << "Another line of text\n";

    /*
        Make sure everything is written to disk.
    */
    out.flush();

    /*
        Close the file after use.
    */
    out.close();
}

void read_file()
{
    /*
        Provide no arguments to the std::fstream constructor to get a
        default initialized std::fstream instance.
    */
    std::fstream in;

    /*
        Give the object an associated file

        The method std::fstream::mode() accepts a C style string or std::string
        for the first argument. The second is the mode to open the file.

        Again, you can mix and match modes with the bitwise operator OR.

        We just want reading abilities so we use std::ios::in.
    */
    in.open("output.txt", std::ios::in);

    /* Good practice to check if everything went well */
    if(!in.is_open())
    {
        std::cout << "Could not open file!\n";
        return;
    }

    /*
        std::getline accepts a std::basic_istream which std::fstream inherits
        through std::basic_iostream.

             Inheritance Chart (Not Complete)
        std::basic_istream     std::basic_ostream
                       |       |
                           |
                    std::basic_iostream
                           |
                    std::fstream
        
        The second argument is a reference to a std::string.

        std::getline returns a reference to a std::basic_istream.
        std::basic_istream overloads the operator bool that returns a null pointer
        if an error occurs. That is why we can use std::getline in conditionals.

        Print each line of the file.
    */
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
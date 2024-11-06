/* 
Sample-Programs
    C#
        Josephus Problem
SDEV301 GRC
Coder: Jonathan Sule
Due Date: November 12, 2024
*/

//directives which make specific libraries (namespaces) available for use in following code
//System is the core namespace in C#, containing fundamental classes and types essential
//for most C# programs
//System.Collections.Generic is namespace that provides classes for working with collections
//of data like lists and queues
//stating these two directives at the start aren’t essential but without them some commands below would have to have the full path to those libraries spelled out which is cumbersome

using System;
using System.Collections.Generic;

//In C#, namespace is used to organize code into groups and prevent naming conflicts

namespace JosephusProblem
{
    //class is a blueprint for creating objects; here I define a Program class, the entry point
    //of the application
    //(namespace and class are fundamental for organizing and structuring code in C#)

    class Program
    {
        //Main method is entry point of application; it’s where program execution begins; always static;

        static void Main(string[] args)
        {
            //Console.Writeline prompts the user for input, Console.Readline reads the input

            Console.WriteLine("Enter the total number of people (n): ");

            //int.TryParse validates the input is integer; if not error message results

            if (!int.TryParse(Console.ReadLine(), out int n) || n <= 0)
            {
                Console.WriteLine("Usage: please input the total number of people and number of people to skip.");
                return;
            }

            //k is the interval for elimination

            Console.WriteLine("Enter the number of people to skip (k): ");
            if (!int.TryParse(Console.ReadLine(), out int k) || k <= 0)
            {
                Console.WriteLine("Usage: please input the total number of people and number of people to skip.");
                return;
            }

            //call  Josephus function and print result

            int survivor = FindJosephusPosition(n, k);
            Console.WriteLine($"The last person remaining is at position: {survivor}");
        }

        //the FindJosephusPosition method calculates position of last person in circle
        //this is static int method which will return an integer, the position of the last person
        //‘static’ keyword allows method to be called without creating an instance of Program

        static int FindJosephusPosition(int n, int k)
        {
            //using LIst<int> to represent people in circle, initializing a list of people from 1 to n
            //List<int> is part of System.Collections.Generic which allows creation of dynamic arrays
            //List<int> allows for dynamic resizing; is zero-indexed

            List<int> people = new List<int>();
            for (int i = 1; i <= n; i++)
            {
                people.Add(i);
            }

            //int variable tracks index of next person to be eliminated

            int currentIndex = 0;

            //while loop until only one person left in circle

            while (people.Count > 1)
            {
                //calculation of index of next person to eliminate

                currentIndex = (currentIndex + k - 1) % people.Count;

                //uncomment code line below to output current state of circle
                //provides insight by displaying state of list before each person removed
                //(debug line commented out once all tests found to be passed)
                //Console.WriteLine($"[{string.Join(", ", people)}] 1 {currentIndex}");

                //remove person at currentIndex

                people.RemoveAt(currentIndex);
            }

            //return last person position (people[0])

            return people[0];
        }
    }
}

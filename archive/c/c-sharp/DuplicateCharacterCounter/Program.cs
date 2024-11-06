using System;

namespace DuplicateCharacterCounter 
{
    class Program 
    {
        static void Main(string[] args) 
        {
            int res = Count("Helllo");
            Console.WriteLine(res);
        }

        public static int Count(string input) 
        {
            int count = 1;
            for (int i = 0; i < input.Length-1; i++)
            {
                if (input[i] == input[i+1]) {
                    count++;
                }
            }
            return count;
        }
    }
}
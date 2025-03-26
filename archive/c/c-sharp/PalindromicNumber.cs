using System;
public class PalindromicNumber
{
    public static void Main(string[] args)
    {

        try
        {
            long verifyInput = long.Parse(args[0]);

            if (verifyInput >= 0)
            {
                Console.WriteLine(palindrome(args[0]));
            }
            else
            {
                Console.WriteLine("Usage: please input a non-negative integer");
            }

        }
        catch
        {
            Console.WriteLine("Usage: please input a non-negative integer");
        }

    }

    public static string palindrome(string numString)
    {
        char[] digits = numString.ToCharArray();

        int backCount = digits.Length - 1;

        for (int i = 0; i < digits.Length; i++)
        {
            if (digits[i] != digits[backCount])
            {
                return "false";
            }
            else
            {
                backCount--;
            }

        }

        return "true";

    }

}
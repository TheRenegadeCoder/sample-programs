using System;

public class ReverseString
{
  public static string Reverse(string input)
  {
      char[] characters = input.ToCharArray();
      Array.Reverse(characters);
      return new string(characters);
  }

  public static void Main(string[] args)
  {
    if (args.Length > 0)
    {
      System.Console.WriteLine(Reverse(args[0]));
    }
  }
}

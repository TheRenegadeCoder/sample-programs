using System;
using System.Collections.Generic;
using System.Globalization;

public class ReverseString
{
  public static string Reverse(string input)
  {
    TextElementEnumerator enumerator = StringInfo.GetTextElementEnumerator(input);
    List<string> elements = new List<string>();
    while (enumerator.MoveNext())
      elements.Add(enumerator.GetTextElement());
    elements.Reverse();
    string reversed = string.Concat(elements);
    return reversed;
  }

  public static void Main(string[] args)
  {
    if (args.Length > 0)
    {
      System.Console.WriteLine(Reverse(args[0]));
    }
  }
}

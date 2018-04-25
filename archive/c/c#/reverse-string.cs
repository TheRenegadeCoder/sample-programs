class ReverseString
{
  public static string Reverse(string input)
  {
      char[] characters = input.ToCharArray();
      Array.Reverse(characters);
      return new string(characters);
  }

  static void Main()
  {

  }
}

public class ReverseString {

  public static String reverse(String toReverse) {
    char[] characters = toReverse.toCharArray();
    int start = 0;
    int end = characters.length - 1;
    char temp;
    while(end > start){
      temp = characters[start];
      characters[start] = characters[end];
      characters[end] = temp;
      end--;
      start++;
    }
    return new String(characters);
  }

  public static void main(String args[]) {
    if (args.length > 0) {
      System.out.println(reverse(args[0]));
    }
  }
}

public class EvenOdd
{
    public static void main(String[] args)
    {
        try
        {
            String nstr = args[0].trim();
            String lastDigit = nstr.substring(nstr.length() - 1);
            int n = Integer.parseInt(lastDigit);
            String result = n % 2 == 0 ? "Even" : "Odd";
            System.out.println(result);
        }
        catch (Exception e)
        {
            System.out.println("Usage: please input a number");
            System.exit(1);
        }
    }
}

namespace FizzBuzz
{
    public class Program
    {
        public static string FizzBuzz(int number)
        {
            string temp = "";
            if (number % 3 == 0)
            {
                temp += "Fizz";
            }
            if (number % 5 == 0)
            {
                temp += "Buzz";
            }
            if (string.IsNullOrEmpty(temp))
            {
                temp += number;
            }
            return temp;
        }

        private static void Main(string[] args)
        {
            for (int i = 1; i <= 100; i++)
            {
                string line = FizzBuzz(i);
                System.Console.WriteLine(line);
            }
        }
    }
}
